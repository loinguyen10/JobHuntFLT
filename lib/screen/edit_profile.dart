import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../blocs/app_riverpod_object.dart';
import '../component/edittext.dart';
import '../model/userprofile.dart';
import '../value/style.dart';

class EditProfileScreenNew extends ConsumerWidget {
  const EditProfileScreenNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//
    final listEducationData = ref.watch(listEducationProvider);
    final listProvinceData = ref.watch(listProvinceProvider);
    final listDistrictData = ref.watch(listDistrictProvider);
    final listWardData = ref.watch(listWardProvider);

    final educationChoose = ref.watch(educationChooseProvider);
    final provinceChoose = ref.watch(provinceChooseProvider);
    final districtChoose = ref.watch(districtChooseProvider);
    final wardChoose = ref.watch(wardChooseProvider);

    List<EducationList> listEducation = [];
    List<ProvinceList> listProvince = [];
    List<DistrictList> listDistrict = [];
    List<WardList> listWard = [];

    listEducationData.when(
      data: (_data) {
        listEducation.addAll(_data);
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    listProvinceData.when(
      data: (_data) {
        listProvince.addAll(_data);
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    listDistrictData.when(
      data: (_data) {
        for (var district in _data) {
          if (provinceChoose!.code != null) {
            if (district.provinceCode == provinceChoose.code) {
              listDistrict.add(district);
            }
          }
        }
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    listWardData.when(
      data: (_data) {
        for (var ward in _data) {
          if (districtChoose!.code != null) {
            if (ward.districtCode == districtChoose.code) {
              listWard.add(ward);
            }
          }
        }
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );
//
    DropdownButtonHideUnderline dropEducation() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: listEducation
              .map((item) => DropdownMenuItem<EducationList>(
                    value: item,
                    child: Text(item.title ?? '', style: textNormal),
                  ))
              .toList(),
          value: educationChoose?.id != null ? educationChoose : null,
          onChanged: (value) {
            ref.read(educationChooseProvider.notifier).state = value;
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
            // listProvince.clear();
            if (provinceChoose!.code != null) {
              ref.read(wardChooseProvider.notifier).state = null;
              ref.read(districtChooseProvider.notifier).state = null;
            }
            ref.read(provinceChooseProvider.notifier).state = value;
          },
          buttonStyleData: dropDownButtonStyle1,
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
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: listDistrict
              .map((item) => DropdownMenuItem<DistrictList>(
                    value: item,
                    child: Text(item.name ?? '', style: textNormal),
                  ))
              .toList(),
          value: districtChoose?.code != null ? districtChoose : null,
          onChanged: (value) {
            // listWard.clear();
            if (wardChoose!.code != null) {
              ref.read(wardChooseProvider.notifier).state = null;
            }
            ref.read(districtChooseProvider.notifier).state = value;
          },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    DropdownButtonHideUnderline dropWard() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: listWard
              .map((item) => DropdownMenuItem<WardList>(
                    value: item,
                    child: Text(item.name ?? '', style: textNormal),
                  ))
              .toList(),
          value: wardChoose?.code != null ? wardChoose : null,
          onChanged: (value) {
            ref.read(wardChooseProvider.notifier).state = value;
          },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(gradient: bgGradientColor),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(
                Icons.no_accounts_outlined,
                size: 160,
              ),
              SizedBox(height: 32),
              EditTextForm(
                onChanged: ((value) {
                  //
                }),
                // content: widget.profileDetail?.fullName ?? '',
                label: Keystring.FULLNAME.tr,
                // hintText: Keystring.FULLNAME.tr,
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  //
                }),
                // content: widget.profileDetail?.fullName ?? '',
                label: Keystring.DISPLAY_NAME.tr,
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  //
                }),
                // content: widget.profileDetail?.fullName ?? '',
                label: Keystring.EMAIL.tr,
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  //
                }),
                // content: widget.profileDetail?.fullName ?? '',
                label: Keystring.PHONE.tr,
              ),
              SizedBox(height: 24),
              Container(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: Keystring.ADDRESS.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: Keystring.PROVINCE.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: dropProvince(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: Keystring.DISTRICT.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: dropDistrict(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: Keystring.WARD.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: dropWard(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: Keystring.EDUCATION.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      dropEducation(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  //
                }),
                // content: widget.profileDetail?.fullName ?? '',
                label: Keystring.WANT_JOB.tr,
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: EditTextForm(
                      onChanged: ((value) {
                        //
                      }),
                      // content: widget.profileDetail?.fullName ?? '',
                      label: Keystring.MIN_SALARY.tr,
                      // width: 50,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: EditTextForm(
                      onChanged: ((value) {
                        //
                      }),
                      // content: widget.profileDetail?.fullName ?? '',
                      label: Keystring.MAX_SALARY.tr,
                      // width: 50,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: EditTextForm(
                      onChanged: ((value) {
                        //
                      }),
                      // content: widget.profileDetail?.fullName ?? '',
                      label: Keystring.CURRENCY.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
