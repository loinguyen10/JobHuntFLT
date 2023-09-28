import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/component/date_dialog.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../blocs/app_controller.dart';
import '../blocs/app_event.dart';
import '../blocs/app_riverpod_object.dart';
import '../component/edittext.dart';
import '../model/userprofile.dart';
import '../value/style.dart';
import 'home.dart';

class EditProfileScreenNew extends ConsumerStatefulWidget {
  const EditProfileScreenNew({
    super.key,
    this.edit = false,
  });
  final bool edit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScreenEditProfileNew();
}

class _ScreenEditProfileNew extends ConsumerState<EditProfileScreenNew> {
  @override
  Widget build(BuildContext context) {
    String filePath = '';

    final user = ref.watch(userLoginProvider);
    final profile = ref.watch(userProfileProvider);

    final listEducationData = ref.watch(listEducationProvider);
    final listProvinceData = ref.watch(listProvinceProvider);
    final listDistrictData = ref.watch(listDistrictProvider);
    final listWardData = ref.watch(listWardProvider);
    final listCurrencyData = ref.watch(listCurrencyProvider);
    final listEducationShowData = ref.watch(listEducationShowProvider);

    final educationChoose = ref.watch(educationChooseProvider);
    final provinceChoose = ref.watch(provinceChooseProvider);
    final districtChoose = ref.watch(districtChooseProvider);
    final wardChoose = ref.watch(wardChooseProvider);
    final currencyChoose = ref.watch(currencyChooseProvider);

    final avatarProfile = ref.watch(avatarProfileProvider);
    final cvProfile = ref.watch(cvUploadProvider);
    final birthdayProfile = ref.watch(dateBirthProvider);

    List<EducationList> listEducation = [];
    List<ProvinceList> listProvince = [];
    List<DistrictList> listDistrict = [];
    List<WardList> listWard = [];
    List<CurrencyList> listCurrency = [];

//get data
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

    listCurrencyData.when(
      data: (_data) {
        listCurrency.addAll(_data);
        listCurrency.sort((a, b) => a.code!.compareTo(b.code!));
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

//dropdown
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
            if (!listEducationShowData.any((x) => x == value)) {
              ref.read(educationChooseProvider.notifier).state = value;
              ref.read(listEducationShowProvider.notifier).state = [
                ...listEducationShowData,
                value!
              ];
              // listEducationShowData.sort((a, b) => a.id!.compareTo(b.id!));
            }
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
            if (provinceChoose?.code != null) {
              ref.read(wardChooseProvider.notifier).state = null;
              ref.read(districtChooseProvider.notifier).state = null;
            }
            ref.read(provinceChooseProvider.notifier).state = value;
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
              ref.read(wardChooseProvider.notifier).state = null;
            }
            ref.read(districtChooseProvider.notifier).state = value;
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
            ref.read(wardChooseProvider.notifier).state = value;
            log('Ward: ${value?.code}');
          },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

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
            ref.read(currencyChooseProvider.notifier).state = value;
          },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

//upload
    Future<void> upload(int type) async {
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
                          type == 1 ? 'Avatar' : 'CV',
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
                        type == 1
                            ? Container(
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
                              )
                            : Container(
                                child: filePath != ''
                                    ? Container(
                                        width: double.infinity,
                                        height: 150,
                                        color: Colors.white,
                                        child: Center(
                                          child: Text('Uploaded'),
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 150,
                                        color: Colors.white,
                                        child: Center(
                                          child: Text('NOTHING'),
                                        ),
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
                                        if (type == 1) {
                                          ref
                                              .read(avatarProfileProvider
                                                  .notifier)
                                              .state = filePath;
                                          Navigator.pop(context);
                                        } else {
                                          ref
                                              .read(cvUploadProvider.notifier)
                                              .state = filePath;
                                          Navigator.pop(context);
                                        }
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
                                      log(filePath);
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
                                        if (type == 1) {
                                          XFile? file;
                                          file = await ImagePicker().pickImage(
                                              source: ImageSource.gallery);
                                          if (file != null) {
                                            filePath = file.path;
                                            setState(() {});
                                          }
                                        } else {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                                      type: FileType.custom,
                                                      allowedExtensions: [
                                                'pdf'
                                              ]);

                                          if (result != null &&
                                              result.files.single.path !=
                                                  null) {
                                            File file =
                                                File(result.files.single.path!);

                                            filePath = file.path;
                                          } else {
                                            // User canceled the picker
                                          }
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
                    onTap: () => upload(1),
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
                  ref.read(fullNameProfileProvider.notifier).state = value;
                  log(value);
                }),
                label: Keystring.FULLNAME.tr,
                // hintText: Keystring.FULLNAME.tr,
                content: profile?.fullName ?? '',
              ),
              // SizedBox(height: 24),
              // EditTextForm(
              //   onChanged: ((value) {
              //     //
              //   }),
              //   label: Keystring.DISPLAY_NAME.tr,
              // ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  // ref.read(emailProfileProvider.notifier).state = value;
                }),
                label: Keystring.EMAIL.tr,
                content: profile?.email ?? ref.watch(emailLoginProvider),
                readOnly: true,
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(phoneProfileProvider.notifier).state = value;
                }),
                label: Keystring.PHONE.tr,
                content: profile?.phone ?? '',
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
                      // SizedBox(height: 20),
                      // EditTextForm(
                      //   onChanged: ((value) {
                      //     //
                      //   }),
                      //   label: Keystring.ROAD_STREET.tr,
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                color: Colors.white,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: Keystring.EDUCATION.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      dropEducation(),
                      listEducationShowData.isNotEmpty
                          ? SizedBox(
                              height: 16,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      listEducationShowData.isNotEmpty
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
                                          listEducationShowData[index].title ??
                                              '',
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                        ),
                                        InkWell(
                                          child: Icon(Icons.delete_outlined),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: listEducationShowData.length,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: Keystring.BIRTHDAY.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child:
                      DateCustomDialog().dalDate(context, ref, birthdayProfile),
                ),
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(jobProfileProvider.notifier).state = value;
                }),
                label: Keystring.WANT_JOB.tr,
                content: profile?.job ?? '',
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: EditTextForm(
                      typeKeyboard: TextInputType.number,
                      onChanged: ((value) {
                        ref.read(minSalaryProvider.notifier).state =
                            int.parse(value);
                      }),
                      content: profile?.minSalary.toString() ?? '0',
                      label: Keystring.MIN_SALARY.tr,
                      // width: 50,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: EditTextForm(
                      typeKeyboard: TextInputType.number,
                      onChanged: ((value) {
                        ref.read(maxSalaryProvider.notifier).state =
                            int.parse(value);
                      }),
                      content: profile?.maxSalary.toString() ?? '0',
                      label: Keystring.MAX_SALARY.tr,
                      // width: 50,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: Keystring.CURRENCY.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: dropCurrency(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              AppButton(
                onPressed: () {
                  if (ref.watch(fullNameProfileProvider).isNotEmpty &&
                      ref.watch(phoneProfileProvider).isNotEmpty &&
                      provinceChoose!.code != null &&
                      districtChoose!.code != null &&
                      wardChoose!.code != null &&
                      listEducationShowData.isNotEmpty &&
                      ref.watch(dateBirthProvider).isNotEmpty &&
                      ref.watch(jobProfileProvider).isNotEmpty &&
                      ref.watch(minSalaryProvider) > 0 &&
                      ref.watch(maxSalaryProvider) > 0 &&
                      ref.watch(minSalaryProvider) <
                          ref.watch(maxSalaryProvider) &&
                      currencyChoose!.code != null) {
                    var eduImport = '';
                    for (var edu in listEducationShowData) {
                      eduImport += "${edu.id},";
                    }

                    log('${eduImport.substring(0, eduImport.length - 1)}');
                    log('${user!.uid} + ${ref.watch(fullNameProfileProvider)} + ${ref.watch(phoneProfileProvider)} + ${provinceChoose!.code} + ${districtChoose!.code} + ${wardChoose!.code} + ${ref.watch(dateBirthProvider)} + ${listEducationShowData.length} + ${ref.watch(jobProfileProvider)} + ${ref.watch(minSalaryProvider)} + ${ref.watch(maxSalaryProvider)} + ${currencyChoose!.code} ');
                    if (!widget.edit) {
                      log("click done");
                      ref.read(LoginControllerProvider.notifier).createProfile(
                            user!.uid ?? '0',
                            ref.watch(fullNameProfileProvider),
                            ref.watch(avatarProfileProvider),
                            ref.watch(emailLoginProvider),
                            ref.watch(phoneProfileProvider),
                            ',${wardChoose.code},${districtChoose.code},${provinceChoose.code}',
                            ref.watch(dateBirthProvider),
                            eduImport.substring(0, eduImport.length - 1),
                            ref.watch(jobProfileProvider),
                            ref.watch(minSalaryProvider),
                            ref.watch(maxSalaryProvider),
                            currencyChoose.code ?? '',
                          );
                    } else {
                      log("click update");
                      ref.read(LoginControllerProvider.notifier).updateProfile(
                            user!.uid ?? '0',
                            ref.watch(fullNameProfileProvider),
                            ref.watch(avatarProfileProvider),
                            ref.watch(emailLoginProvider),
                            ref.watch(phoneProfileProvider),
                            ',${wardChoose.code},${districtChoose.code},${provinceChoose.code}',
                            ref.watch(dateBirthProvider),
                            eduImport.substring(0, eduImport.length - 1),
                            ref.watch(jobProfileProvider),
                            ref.watch(minSalaryProvider),
                            ref.watch(maxSalaryProvider),
                            currencyChoose.code ?? '',
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
                content: widget.edit ? Keystring.UPDATE.tr : Keystring.DONE.tr,
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
