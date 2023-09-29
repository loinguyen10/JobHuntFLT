import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';

import '../blocs/app_controller.dart';
import '../blocs/app_event.dart';
import '../blocs/app_riverpod_object.dart';
import '../component/app_button.dart';
import '../component/date_dialog.dart';
import '../component/edittext.dart';
import '../component/loader_overlay.dart';
import '../model/address.dart';
import '../value/keystring.dart';
import '../value/style.dart';
import 'home.dart';

class RecuiterEditScreen extends ConsumerWidget {
  const RecuiterEditScreen({super.key, this.edit = false});

  final bool edit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String filePath = '';

    final user = ref.watch(userLoginProvider);
    final company = ref.watch(companyProfileProvider);

    final listProvinceData = ref.watch(listProvinceProvider);
    final listDistrictData = ref.watch(listDistrictProvider);
    final listWardData = ref.watch(listWardProvider);

    final provinceChoose = ref.watch(provinceCompanyProvider);
    final districtChoose = ref.watch(districtCompanyProvider);
    final wardChoose = ref.watch(wardCompanyProvider);

    final avatarProfile = ref.watch(avatarCompanyProvider);

    List<ProvinceList> listProvince = [];
    List<DistrictList> listDistrict = [];
    List<WardList> listWard = [];

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
          if (provinceChoose!.code != null) {
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

    listWardData.when(
      data: (_data) {
        for (var ward in _data) {
          if (districtChoose?.code != null) {
            if (ward.districtCode == districtChoose?.code) {
              listWard.add(ward);
              listWard.sort((a, b) => a.name!.compareTo(b.name!));
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
            if (provinceChoose?.code != null) {
              ref.read(wardCompanyProvider.notifier).state = null;
              ref.read(districtCompanyProvider.notifier).state = null;
            }
            ref.read(provinceCompanyProvider.notifier).state = value;
            log('Province: ${value?.code}');
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
                    child: Text(item.fullName ?? '', style: textNormal),
                  ))
              .toList(),
          value: districtChoose?.code != null ? districtChoose : null,
          onChanged: (value) {
            // listWard.clear();
            if (wardChoose?.code != null) {
              ref.read(wardCompanyProvider.notifier).state = null;
            }
            ref.read(districtCompanyProvider.notifier).state = value;
            log('District: ${value?.code}');
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
                    child: Text(item.fullName ?? '', style: textNormal),
                  ))
              .toList(),
          value: wardChoose?.code != null ? wardChoose : null,
          onChanged: (value) {
            ref.read(wardCompanyProvider.notifier).state = value;
            log('Ward: ${value?.code}');
          },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

//upload
    Future<void> uploadImg() async {
      filePath = '';

      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  // height: 430,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Avatar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            // color: MyColor('#ff4500'),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 1,
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: filePath != ''
                              ? Image.file(
                                  File(filePath),
                                  width: double.infinity,
                                  height: 250,
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 250,
                                  color: Colors.white,
                                ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (filePath != '') {
                                        String newFile = convertJpg(filePath);
                                        ref
                                            .read(
                                                avatarCompanyProvider.notifier)
                                            .state = newFile;
                                        Navigator.pop(context);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "File is blank.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                    child: Container(
                                      width: 80,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                    color: Colors
                                                        .transparent)))))),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (filePath != '') {
                                        setState(() {
                                          filePath = '';
                                        });
                                      } else {
                                        XFile? file;
                                        file = await ImagePicker().pickImage(
                                            source: ImageSource.gallery);
                                        if (file != null) {
                                          filePath = file.path;
                                          setState(() {});
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 80,
                                      alignment: Alignment.center,
                                      child: Text(
                                        filePath != ''
                                            ? 'Clear File'
                                            : 'Upload File',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: Colors.orange,
                                                )))))),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }

//listen
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateProfileErrorEvent ||
            state is UpdateProfileErrorEvent) {
          Loader.hide();
          log('error');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(Keystring.UNSUCCESSFUL.tr),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        if (state is CreateProfileSuccessEvent) {
          Loader.hide();
          log('c-success');
          Get.offAll(HomeScreen());
        }

        if (state is UpdateProfileSuccessEvent) {
          Loader.hide();
          log('u-success');
          Navigator.pop(context);
        }

        if (state is CreateProfileLoadingEvent ||
            state is UpdateProfileLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: bgGradientColor),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(128), // Image radius
                  child: GestureDetector(
                    onTap: () => uploadImg(),
                    child: avatarProfile != ''
                        ? avatarProfile.substring(0, 8) == 'https://'
                            ? Image.network(
                                avatarProfile,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(avatarProfile),
                                fit: BoxFit.cover,
                              )
                        : Icon(
                            Icons.no_accounts_outlined,
                            size: 256,
                          ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(fullNameCompanyProvider.notifier).state = value;
                  log(value);
                }),
                label: Keystring.FULLNAME.tr,
                content: company?.fullname ?? '',
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  // ref.read(emailProfileProvider.notifier).state = value;
                }),
                label: Keystring.EMAIL.tr,
                content: company?.email ?? ref.watch(emailCompanyProvider),
                readOnly: true,
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(phoneCompanyProvider.notifier).state = value;
                }),
                label: Keystring.PHONE.tr,
                content: company?.phone ?? '',
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(websiteCompanyProvider.notifier).state = value;
                }),
                label: Keystring.WEBSITE.tr,
                content: company?.web ?? '',
              ),
              SizedBox(height: 24),
              Container(
                color: Colors.white,
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
                      SizedBox(height: 20),
                      EditTextForm(
                        onChanged: ((value) {
                          ref.read(roadCompanyProvider.notifier).state = value;
                        }),
                        label: Keystring.ROAD_STREET.tr,
                        content: company?.address!
                                .substring(0, company.address!.indexOf(',')) ??
                            '',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(descriptionCompanyProvider.notifier).state = value;
                }),
                label: Keystring.DESCRIPTION.tr,
                height: 120,
                content: company?.description ?? '',
                maxLines: 5,
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(jobCompanyProvider.notifier).state = value;
                }),
                label: Keystring.WANT_JOB.tr,
                content: company?.job ?? '',
              ),
              SizedBox(height: 32),
              AppButton(
                onPressed: () {
                  log('${user!.uid} + ${ref.watch(fullNameCompanyProvider)} + ${ref.watch(phoneCompanyProvider)} + ${ref.watch(websiteCompanyProvider)} + ${provinceChoose!.code} + ${districtChoose!.code} + ${wardChoose!.code} + ${ref.watch(roadCompanyProvider)} + ${ref.watch(jobCompanyProvider)}  + ${ref.watch(descriptionCompanyProvider)}');
                  if (ref.watch(fullNameCompanyProvider).isNotEmpty &&
                      ref.watch(phoneCompanyProvider).isNotEmpty &&
                      ref.watch(websiteCompanyProvider).isNotEmpty &&
                      provinceChoose.code != null &&
                      districtChoose.code != null &&
                      wardChoose.code != null &&
                      ref.watch(roadCompanyProvider).isNotEmpty &&
                      ref.watch(jobCompanyProvider).isNotEmpty &&
                      ref.watch(descriptionCompanyProvider).isNotEmpty) {
                    if (!edit) {
                      log("click done");

                      ref.read(LoginControllerProvider.notifier).createCompany(
                            user!.uid ?? '0',
                            ref.watch(fullNameCompanyProvider),
                            ref.watch(avatarCompanyProvider),
                            ref.watch(emailCompanyProvider),
                            ref.watch(phoneCompanyProvider),
                            '${ref.watch(roadCompanyProvider)},${wardChoose.code},${districtChoose.code},${provinceChoose.code}',
                            ref.watch(websiteCompanyProvider),
                            ref.watch(descriptionCompanyProvider),
                            ref.watch(jobCompanyProvider),
                          );
                    } else {
                      log("click update");
                      ref.read(LoginControllerProvider.notifier).updateCompany(
                            user!.uid ?? '0',
                            ref.watch(fullNameCompanyProvider),
                            ref.watch(avatarCompanyProvider),
                            ref.watch(emailLoginProvider),
                            ref.watch(phoneCompanyProvider),
                            '${ref.watch(roadCompanyProvider)},${wardChoose.code},${districtChoose.code},${provinceChoose.code}',
                            ref.watch(websiteCompanyProvider),
                            ref.watch(descriptionCompanyProvider),
                            ref.watch(jobCompanyProvider),
                          );
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: Keystring.NOT_FULL_DATA.tr,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                bgColor: appPrimaryColor,
                height: 64,
                content: edit ? Keystring.UPDATE.tr : Keystring.DONE.tr,
                fontSize: 16,
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
