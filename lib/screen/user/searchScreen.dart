import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/component/card.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/job/job_view_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:jobhunt_ftl/value/style.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/edittext.dart';
import '../../model/address.dart';

class JobSearchScreen extends ConsumerStatefulWidget {
  const JobSearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JobSearchScreenState();
}


class _JobSearchScreenState extends ConsumerState<JobSearchScreen> {
  var searchController = TextEditingController();
  var minSalaryController = TextEditingController();
  var maxSalaryController = TextEditingController();
  var yearExperienceController = TextEditingController();
  bool focusCheck = false;
  ProvinceList? provinceChoose;
  String jobTypeChoose = '';


  @override
  Widget build(BuildContext context) {
    final listSearch = ref.watch(listJobSearchProvider);
    final sizePhone = MediaQuery.of(context).size;


    List<ProvinceList> listProvince = [];
    List<String> listJobType = [
      Keystring.INTERN.tr,
      Keystring.PART_TIME.tr,
      Keystring.FULL_TIME.tr
    ];
    final listProvinceData = ref.watch(listProvinceProvider);

    // final listAllTitleJobData = ref.watch(listAllTitleJobSettingProvider);


    listProvinceData.when(
      data: (_data) {
        listProvince.addAll(_data);
        listProvince.sort((a, b) => a.name!.compareTo(b.name!));
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    DropdownButtonHideUnderline dropProvince() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.height / 3),
          hint: Text(
            Keystring.SELECT.tr,
          ),
          iconStyleData: IconStyleData(iconSize: 20),
          items: listProvince
              .map((item) => DropdownMenuItem<ProvinceList>(
                    value: item,
                    child: Text(item.name ?? '', style: textNormal),
                  ))
              .toList(),
          value: provinceChoose?.code != null ? provinceChoose : null,
          onChanged: (value) {
            provinceChoose = value;
            log('Province: ${value?.code}');
            setState(() {});
          },
          buttonStyleData: dropDownButtonStyle2,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }


    DropdownButtonHideUnderline dropJobType() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          iconStyleData: IconStyleData(iconSize: 20),
          hint: Text(
            Keystring.SELECT.tr,
          ),
          items: listJobType
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: textNormal),
                  ))
              .toList(),
          value: jobTypeChoose.isNotEmpty
              ? jobTypeChoose == '0'
                  ? Keystring.INTERN.tr
                  : jobTypeChoose == '1'
                      ? Keystring.PART_TIME.tr
                      : Keystring.FULL_TIME.tr
              : null,
          onChanged: (value) {
            if (value == Keystring.INTERN.tr) jobTypeChoose = '0';
            if (value == Keystring.PART_TIME.tr) jobTypeChoose = '1';
            if (value == Keystring.FULL_TIME.tr) jobTypeChoose = '2';
            setState(() {});
          },
          buttonStyleData: dropDownButtonStyle2,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    ref.listen<InsideEvent>(LoginControllerProvider, (previous, state) {
      log('pre - state : $previous - $state');

      if (state == GetListErrorEvent()) {
        Loader.hide();
        log('error');
        Fluttertoast.showToast(
          msg: Keystring.UNSUCCESSFUL.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      if (state == GetListSuccessEvent()) {
        Loader.hide();
        log('success');
        // setState(() {});
      }

      if (state == ThingLoadingEvent()) {
        Loader.show(context);
      }
    });

    return StatefulBuilder(
      builder: (context, mSetState) {
        return Container(
          height: sizePhone.height,
          decoration: BoxDecoration(
              gradient: Theme.of(context).colorScheme.background == Colors.white
                  ? bgGradientColor3
                  : bgGradientColor1),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Expanded(
                      //   child: AppAutocompleteEditText2(
                      //     listSuggestion: listAllTitleJobData.value ?? [],
                      //     onChanged: (value) {
                      //       //
                      //     },
                      //     hintText: Keystring.SEARCH.tr,
                      //   ),
                      // ),
                      Expanded(
                        child: EditText2Form(
                          onChanged: (value) {
                            mSetState(
                              () {},

                            );
                          },
                          autoFocus: true,
                          controller: searchController,
                          hintText: Keystring.SEARCH.tr,
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                  onPressed: () {
                                    mSetState(() {
                                      searchController.clear();
                                    });
                                  },
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      AppButton(
                        width: sizePhone.width / 9.5,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          ref
                              .read(LoginControllerProvider.notifier)
                              .getSearchJobList(
                                searchController.text,
                                minSalaryController.text,
                                maxSalaryController.text,
                                jobTypeChoose,
                                yearExperienceController.text,
                                provinceChoose?.code ?? '',
                              );
                        },

                        label: Keystring.SEARCH.tr,
                        bgColor: Colors.white,
                        textColor: Colors.black,
                        colorBorder: Colors.black,
                      ),
                    ],

                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppBorderFrame(
                          labelText: Keystring.PROVINCE.tr,
                          child: dropProvince(),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: AppBorderFrame(
                          labelText: Keystring.Type_Job.tr,
                          child: dropJobType(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: EditText2Form(
                          onChanged: (value) {
                            //
                          },
                          controller: minSalaryController,
                          label: Keystring.MIN_SALARY.tr,
                          suffixIcon: Transform.rotate(
                            angle: 180 * 3.14 / 180,
                            child: Icon(
                              Icons.currency_ruble_rounded,
                              size: 14,
                            ),
                          ),
                          // hintText: 'VNĐ',
                          typeKeyboard: TextInputType.number,
                          maxLines: 1,
                          maxLength: 12,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: EditText2Form(
                          onChanged: (value) {
                            //
                          },
                          controller: maxSalaryController,
                          label: Keystring.MAX_SALARY.tr,
                          suffixIcon: Transform.rotate(
                            angle: 180 * 3.14 / 180,
                            child: Icon(
                              Icons.currency_ruble_rounded,
                              size: 14,
                            ),
                          ),
                          // hintText: 'VNĐ',
                          typeKeyboard: TextInputType.number,
                          maxLines: 1,
                          maxLength: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: sizePhone.width / 2.75,
                        child: EditText2Form(
                          onChanged: (value) {
                            //
                          },
                          controller: yearExperienceController,
                          label: Keystring.Year_Experience.tr,
                          typeKeyboard: TextInputType.number,
                          maxLines: 1,
                          maxLength: 3,
                        ),
                      ),
                      AppButton(
                        width: sizePhone.width / 9,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          searchController.clear();
                          provinceChoose = null;
                          jobTypeChoose = '';
                          minSalaryController.clear();
                          maxSalaryController.clear();
                          yearExperienceController.clear();
                          setState(() {});
                        },
                        label: Keystring.RESET.tr,
                        bgColor: appPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                listSearch.isNotEmpty
                    ? Container(
                        width: sizePhone.width,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "${Keystring.Number_Available_Jobs.tr}: ${ref.watch(numberJobSearchProvider)}",
                          style: textNormalBold,
                        ),
                      )
                    : SizedBox(width: 0),
                SizedBox(height: 16),
                listSearch.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              String avatar =
                                  listSearch[index].company?.avatarUrl ?? '';
                              String name = listSearch[index].name ?? '';
                              String companyName =
                                  listSearch[index].company?.fullname ?? '';
                              String province = getProvinceName(
                                  listSearch[index].address!.substring(
                                      listSearch[index]
                                              .address!
                                              .lastIndexOf(',') +
                                          1),
                                  ref);
                              String money = listSearch[index].maxSalary != -1
                                  ? '${listSearch[index].maxSalary} ${listSearch[index].currency}'
                                  : Keystring.ARGEEMENT.tr;
                              String deadline =
                                  listSearch[index].deadline ?? '';

                              return GestureDetector(
                                onTap: () {
                                  ref.read(jobDetailProvider.notifier).state =
                                      listSearch[index];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobViewScreen()),
                                  );
                                },
                                child: AppJobCard(
                                  avatar: avatar,
                                  name: name,
                                  companyName: companyName,
                                  province: province,
                                  money: money,
                                  deadline: deadline,
                                ),
                              );
                            },
                            itemCount: listSearch.length,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 80),
                          child: Center(
                            child: Text(
                              Keystring.NO_DATA.tr,
                              style: textNormal,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
