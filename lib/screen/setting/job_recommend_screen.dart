import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/app_autocomplete.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:jobhunt_ftl/value/style.dart';

import '../../component/edittext.dart';
import '../../model/address.dart';
import '../../model/userprofile.dart';

class JobRecommendSettingScreen extends ConsumerWidget {
  const JobRecommendSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyChoose = ref.watch(currencyChooseJobSettingProvider);
    final provinceChoose = ref.watch(provinceChooseJobSettingProvider);

    final _gender = ref.watch(genderJobSettingProvider);
    final listS = <String>['aardvark', 'bobcat', 'chameleon'];
    final listJob = ref.watch(listJob2SettingProvider);
    final listSkill = ref.watch(listSkillJobSettingProvider);
    final listProvinceChoose = ref.watch(listProvinceChooseJobSettingProvider);

    final listCurrencyData = ref.watch(listCurrencyProvider);
    final listProvinceData = ref.watch(listProvinceProvider);

    List<CurrencyList> listCurrency = [];
    List<ProvinceList> listProvince = [];

    listCurrencyData.when(
      data: (_data) {
        listCurrency.addAll(_data);
        listCurrency.sort((a, b) => a.code!.compareTo(b.code!));
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    listProvinceData.when(
      data: (_data) {
        listProvince.addAll(_data);
        listProvince.sort((a, b) => a.name!.compareTo(b.name!));
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    DropdownButtonHideUnderline dropCurrency() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: listCurrency
              .map((item) => DropdownMenuItem<CurrencyList>(
                    value: item,
                    child: Text('${item.symbol ?? ''}  ${item.code ?? ''}',
                        style: textNormal),
                  ))
              .toList(),
          value: currencyChoose?.code != null ? currencyChoose : null,
          onChanged: (value) {
            ref.read(currencyChooseJobSettingProvider.notifier).state = value;
          },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    DropdownButtonHideUnderline dropProvince() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.height / 2.5),
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: listProvince
              .map((item) => DropdownMenuItem<ProvinceList>(
                    value: item,
                    child: Text(item.name ?? '', style: textNormal),
                  ))
              .toList(),
          value: provinceChoose?.code != null ? provinceChoose : null,
          onChanged: (value) {
            ref.read(provinceChooseJobSettingProvider.notifier).state = value;
            if (!listProvinceChoose.any((x) => x == value)) {
              ref.read(listProvinceChooseJobSettingProvider.notifier).state = [
                ...listProvinceChoose,
                value!
              ];
            }
            log('Province: ${value?.code}');
          },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Keystring.JOB_RECOMMEND_SETTING.tr),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: 'Gender',
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Male'),
                          leading: Radio(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: 'Male',
                            groupValue: _gender,
                            onChanged: (value) {
                              ref
                                  .read(genderJobSettingProvider.notifier)
                                  .state = value!;
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('Female'),
                          leading: Radio(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: 'Female',
                            groupValue: _gender,
                            onChanged: (value) {
                              ref
                                  .read(genderJobSettingProvider.notifier)
                                  .state = value!;
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('Null'),
                          leading: Radio(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: 'Null',
                            groupValue: _gender,
                            onChanged: (value) {
                              ref
                                  .read(genderJobSettingProvider.notifier)
                                  .state = value!;
                            },
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 16),
                EditTextForm(
                  onChanged: ((value) {
                    //
                  }),
                  label: 'Position',
                ),
                SizedBox(height: 16),
                AppBorderFrame(
                  labelText: 'Job',
                  child: Column(
                    children: [
                      AppAutocompleteEditText(
                        borderSelected: Colors.transparent,
                        listSuggestion: listS,
                        onSelected: (value) {
                          if (!listJob.any((x) => x == value)) {
                            ref.read(listJob2SettingProvider.notifier).state = [
                              ...listJob,
                              value
                            ];
                            // listEducationShowData.sort((a, b) => a.id!.compareTo(b.id!));
                          }
                        },
                      ),
                      listJob.isNotEmpty
                          ? SizedBox(height: 16)
                          : SizedBox(height: 0),
                      listJob.isNotEmpty
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return Card(
                                  shadowColor: Colors.grey,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  elevation: 2,
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          listJob[index],
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                        ),
                                        InkWell(
                                          child: Icon(Icons.delete_outlined),
                                          onTap: () {
                                            //
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: listJob.length,
                            )
                          : SizedBox(height: 0),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                AppBorderFrame(
                  labelText: 'Skill',
                  child: Column(
                    children: [
                      AppAutocompleteEditText(
                        borderSelected: Colors.transparent,
                        listSuggestion: listS,
                        onSelected: (value) {
                          if (!listSkill.any((x) => x == value)) {
                            ref
                                .read(listSkillJobSettingProvider.notifier)
                                .state = [...listSkill, value];
                            // listEducationShowData.sort((a, b) => a.id!.compareTo(b.id!));
                          }
                        },
                      ),
                      listSkill.isNotEmpty
                          ? SizedBox(height: 16)
                          : SizedBox(height: 0),
                      listSkill.isNotEmpty
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return Card(
                                  shadowColor: Colors.grey,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  elevation: 2,
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          listSkill[index],
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                        ),
                                        InkWell(
                                          child: Icon(Icons.delete_outlined),
                                          onTap: () {
                                            //
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: listSkill.length,
                            )
                          : SizedBox(height: 0),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: 'Expericement',
                    child: Column(
                      children: [
                        //
                      ],
                    )),
                SizedBox(height: 16),
                AppBorderFrame(
                  labelText: 'Payment',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: EditTextForm(
                          typeKeyboard: TextInputType.number,
                          onChanged: ((value) {
                            ref
                                .read(minSalaryJobSettingProvider.notifier)
                                .state = int.parse(value);
                          }),
                          // content: profile?.minSalary == null ? '' : profile?.minSalary.toString() ?? '',
                          label: Keystring.MIN_SALARY.tr,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: EditTextForm(
                          typeKeyboard: TextInputType.number,
                          onChanged: ((value) {
                            ref
                                .read(maxSalaryJobSettingProvider.notifier)
                                .state = int.parse(value);
                          }),
                          // content: profile?.maxSalary == null ? '' : profile?.maxSalary.toString() ?? '',
                          label: Keystring.MAX_SALARY.tr,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: AppBorderFrame(
                          labelText: Keystring.CURRENCY.tr,
                          child: dropCurrency(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: 'Place',
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: dropProvince(),
                        ),
                        listProvinceChoose.isNotEmpty
                            ? SizedBox(height: 16)
                            : SizedBox(height: 0),
                        listProvinceChoose.isNotEmpty
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return Card(
                                    shadowColor: Colors.grey,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    elevation: 2,
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            listProvinceChoose[index].name ??
                                                '',
                                            overflow: TextOverflow.fade,
                                            maxLines: 3,
                                          ),
                                          InkWell(
                                            child: Icon(Icons.delete_outlined),
                                            onTap: () {
                                              //
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: listProvinceChoose.length,
                              )
                            : SizedBox(height: 0),
                      ],
                    )),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
