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
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/component/date_dialog.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/edittext.dart';
import '../../value/style.dart';
import '../home.dart';

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

    final listProvinceData = ref.watch(listProvinceProvider);
    final listDistrictData = ref.watch(listDistrictProvider);
    final listWardData = ref.watch(listWardProvider);

    final provinceChoose = ref.watch(provinceChooseProvider);
    final districtChoose = ref.watch(districtChooseProvider);
    final wardChoose = ref.watch(wardChooseProvider);

    final avatarProfile = ref.watch(avatarProfileProvider);
    final birthdayProfile = ref.watch(dateBirthProvider);

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
                                          String newFile = convertJpg(filePath);
                                          ref
                                              .read(avatarProfileProvider
                                                  .notifier)
                                              .state = newFile;
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
        if (state is CreateThingErrorEvent || state is UpdateThingErrorEvent) {
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

        if (state is CreateThingSuccessEvent) {
          Loader.hide();
          log('c-success');
          Get.offAll(HomeScreen());
        }

        if (state is UpdateThingSuccessEvent) {
          Loader.hide();
          log('u-success');
          Navigator.pop(context);
        }

        if (state is CreateThingLoadingEvent ||
            state is UpdateThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.background == Colors.white
                ? bgGradientColor0
                : bgGradientColor1),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                widget.edit
                    ? AppBar(
                        title: Text(Keystring.YOUR_PROFILE.tr),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      )
                    : SizedBox(
                        height: 0,
                      ),
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
                  content:
                      profile?.email ?? ref.watch(emailProfileProvider) ?? '',
                  readOnly: true,
                  typeKeyboard: TextInputType.emailAddress,
                ),
                SizedBox(height: 24),
                EditTextForm(
                  onChanged: ((value) {
                    if (value.length >= 11) {
                      Fluttertoast.showToast(
                          msg: Keystring.PHONE_LESS_11.tr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }

                    ref.read(phoneProfileProvider.notifier).state = value;
                  }),
                  label: Keystring.PHONE.tr,
                  content: profile?.phone ?? '',
                  maxLines: 1,
                  maxLength: 11,
                  typeKeyboard: TextInputType.phone,
                ),
                SizedBox(height: 24),
                AppBorderFrame(
                  labelText: Keystring.ADDRESS.tr,
                  child: Column(
                    children: [
                      AppBorderFrame(
                        labelText: Keystring.PROVINCE.tr,
                        child: dropProvince(),
                      ),
                      SizedBox(height: 20),
                      AppBorderFrame(
                        labelText: Keystring.DISTRICT.tr,
                        child: dropDistrict(),
                      ),
                      SizedBox(height: 20),
                      AppBorderFrame(
                        labelText: Keystring.WARD.tr,
                        child: dropWard(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                AppBorderFrame(
                  labelText: Keystring.BIRTHDAY.tr,
                  child:
                      DateCustomDialog().dobDate(context, ref, birthdayProfile),
                ),
                SizedBox(
                    height: profile?.premiumExpiry != null &&
                            profile?.premiumExpiry != ''
                        ? 24
                        : 0),
                profile?.premiumExpiry != null && profile?.premiumExpiry != ''
                    ? EditTextForm(
                        onChanged: ((value) {
                          ref
                              .read(premiumExpireProfileProvider.notifier)
                              .state = value;
                        }),
                        label: Keystring.PREMIUM_EXPIRY_DATE.tr,
                        content: profile?.premiumExpiry ?? '',
                        maxLines: 1,
                        readOnly: true,
                      )
                    : SizedBox(height: 0),
                SizedBox(height: 32),
                AppButton(
                  onPressed: () {
                    if (ref.watch(fullNameProfileProvider).isNotEmpty &&
                        ref.watch(phoneProfileProvider).isNotEmpty &&
                        provinceChoose!.code != null &&
                        districtChoose!.code != null &&
                        wardChoose!.code != null &&
                        ref.watch(dateBirthProvider).isNotEmpty) {
                      log('${user!.uid} + ${ref.watch(fullNameProfileProvider)} + ${ref.watch(phoneProfileProvider)} + ${provinceChoose.code} + ${districtChoose.code} + ${wardChoose.code} + ${ref.watch(dateBirthProvider)} ');
                      if (ref.watch(phoneProfileProvider).length < 9) {
                        Fluttertoast.showToast(
                          msg: Keystring.PHONE_MORE_9.tr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        if (!widget.edit) {
                          log("click done");
                          ref
                              .read(LoginControllerProvider.notifier)
                              .createProfile(
                                user.uid ?? '0',
                                ref.watch(fullNameProfileProvider),
                                ref.watch(avatarProfileProvider),
                                ref.watch(emailProfileProvider),
                                ref.watch(phoneProfileProvider),
                                ',${wardChoose.code},${districtChoose.code},${provinceChoose.code}',
                                ref.watch(dateBirthProvider),
                              );
                        } else {
                          log("click update");
                          ref
                              .read(LoginControllerProvider.notifier)
                              .updateProfile(
                                user.uid ?? '0',
                                ref.watch(fullNameProfileProvider),
                                ref.watch(avatarProfileProvider),
                                ref.watch(emailProfileProvider),
                                ref.watch(phoneProfileProvider),
                                ',${wardChoose.code},${districtChoose.code},${provinceChoose.code}',
                                ref.watch(dateBirthProvider),
                                // eduImport.substring(0, eduImport.length - 1),
                              );
                        }
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
                  label: widget.edit ? Keystring.UPDATE.tr : Keystring.DONE.tr,
                  fontSize: 16,
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
