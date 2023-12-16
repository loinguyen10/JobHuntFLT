import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/screen/job/job_screen.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../user/company_screen.dart';

class JobRecommendUser extends StatelessWidget {
  const JobRecommendUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            title: Text(Keystring.RECOMMEND_JOB.tr),
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: const SingleChildScrollView(
            child: JobRecommendListScreen(homeMode: false),
          ),
        ),
      ),
    );
  }
}

class JobBestAllScreen extends ConsumerWidget {
  const JobBestAllScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizePhone = MediaQuery.of(context).size;

    final listProvinceData = ref.watch(listProvinceProvider);
    final listDistrictData = ref.watch(listDistrictProvider);

    final provinceChoose = ref.watch(provinceBestJobProvider);
    final districtChoose = ref.watch(districtBestJobProvider);

    List<ProvinceList> listProvince = [];
    List<DistrictList> listDistrict = [];

//get data
    listProvinceData.when(
      data: (_data) {
        listProvince.addAll(_data);
        listProvince.sort((a, b) => a.name!.compareTo(b.name!));
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    listDistrictData.when(
      data: (_data) {
        for (var district in _data) {
          if (provinceChoose != null) {
            if (district.provinceCode == provinceChoose.code) {
              listDistrict.add(district);
              listDistrict.sort((a, b) => a.name!.compareTo(b.name!));
            }
          }
        }
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    //dropdown
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
                    child: Text(item.name ?? ''),
                  ))
              .toList(),
          value: provinceChoose?.code != null ? provinceChoose : null,
          onChanged: (value) {
            if (provinceChoose?.code != null) {
              ref.read(districtBestJobProvider.notifier).state = null;
            }
            ref.read(provinceBestJobProvider.notifier).state = value;
            log('Province: ${value?.code}');

            ref.invalidate(listJobBestProvider);
          },
          buttonStyleData: dropDownButtonStyle2,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    DropdownButtonHideUnderline dropDistrict() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.height / 3),
          hint: Text(
            Keystring.SELECT.tr,
          ),
          iconStyleData: IconStyleData(iconSize: 20),
          items: listDistrict
              .map((item) => DropdownMenuItem<DistrictList>(
                    value: item,
                    child: Text(item.fullName ?? ''),
                  ))
              .toList(),
          value: districtChoose?.code != null ? districtChoose : null,
          onChanged: (value) {
            ref.read(districtBestJobProvider.notifier).state = value;
            log('District: ${value?.code}');

            ref.invalidate(listJobBestProvider);
          },
          buttonStyleData: dropDownButtonStyle2,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(Keystring.BEST_JOB.tr),
      ),
      body: Container(
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
                        labelText: Keystring.DISTRICT.tr,
                        child: dropDistrict(),
                      ),
                    ),
                    provinceChoose != null
                        ? GestureDetector(
                            onTap: () {
                              ref.invalidate(provinceBestJobProvider);
                              ref.invalidate(districtBestJobProvider);
                              ref.invalidate(listJobBestProvider);
                            },
                            child: Container(
                              width: sizePhone.width / 15,
                              margin: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            width: sizePhone.width / 15,
                            margin: EdgeInsets.only(left: 8),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              const Expanded(
                  child: SingleChildScrollView(child: JobBestListScreen())),
            ],
          ),
        ),
      ),
    );
  }
}

class CompanyVerifyScreen extends StatelessWidget {
  const CompanyVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(0, 255, 255, 255),
              elevation: 0,
              bottom: TabBar(
                tabs: [
                  Tab(text: Keystring.PREMIUM_COMPANIES.tr),
                  Tab(text: Keystring.ALL_COMPANIES.tr),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            body: const TabBarView(
              children: [
                SingleChildScrollView(
                  child: CompanyPremiumScreen(),
                ),
                SingleChildScrollView(
                  child: AllCompanyScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
