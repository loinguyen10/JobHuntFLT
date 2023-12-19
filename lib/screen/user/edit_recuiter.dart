import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/app_autocomplete.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../component/app_button.dart';
import '../../component/border_frame.dart';
import '../../component/edittext.dart';
import '../../component/loader_overlay.dart';
import '../../model/address.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../home.dart';

class RecuiterEditScreen extends ConsumerWidget {
  const RecuiterEditScreen({super.key, this.edit = false});

  final bool edit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String filePath = '';

    final user = ref.watch(userLoginProvider);
    final company = ref.watch(companyProfileProvider);
    final listJob = ref.watch(listJobTagCompanyProvider);

    final listProvinceData = ref.watch(listProvinceProvider);
    final listDistrictData = ref.watch(listDistrictProvider);
    final listWardData = ref.watch(listWardProvider);
    final listAllTitleJobData = ref.watch(listAllTitleJobSettingProvider);

    final provinceChoose = ref.watch(provinceCompanyProvider);
    final districtChoose = ref.watch(districtCompanyProvider);
    final wardChoose = ref.watch(wardCompanyProvider);

    final avatarProfile = ref.watch(avatarCompanyProvider);

    List<ProvinceList> listProvince = [];
    List<DistrictList> listDistrict = [];
    List<WardList> listWard = [];
    List<String> listTitleJob = [];

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

    listAllTitleJobData.when(
      data: (_data) {
        listTitleJob.addAll(_data);
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

    String capitalizeWords(String text) {
      if (text.isEmpty) {
        return text;
      }

      List<String> words = text.split(' ');
      for (int i = 0; i < words.length; i++) {
        if (words[i].isNotEmpty) {
          words[i] = words[i][0].toUpperCase() + words[i].substring(1);
        }
      }

      return words.join(' ').trim();
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
        if (state is CreateThingErrorEvent || state is UpdateThingErrorEvent) {
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

        if (state is CreateThingSuccessEvent) {
          Loader.hide();
          log('c-success');
          Get.offAll(() => HomeScreen());
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
                edit
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

                    ref.read(phoneCompanyProvider.notifier).state = value;
                  }),
                  label: Keystring.PHONE.tr,
                  content: company?.phone ?? '',
                  maxLines: 1,
                  maxLength: 11,
                  typeKeyboard: TextInputType.phone,
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
                EditTextForm(
                  onChanged: ((value) {
                    ref.read(taxCodeCompanyProvider.notifier).state = value;
                  }),
                  label: Keystring.TAX_CODE.tr,
                  content: company?.taxcode ?? '',
                  maxLines: 1,
                  maxLength: 10,
                  typeKeyboard: TextInputType.number,
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
                // EditTextForm(
                //   onChanged: ((value) {
                //     ref.read(jobCompanyProvider.notifier).state = value;
                //   }),
                //   label: Keystring.WANT_JOB.tr,
                //   content: company?.job ?? '',
                // ),
                AppBorderFrame(
                  labelText: Keystring.WANT_JOB.tr,
                  child: Column(
                    children: [
                      AppAutocompleteEditText(
                        listSuggestion: listTitleJob,
                        onSelected: (value) {
                          if (!listJob.any((x) => x == value)) {
                            ref.read(listJobTagCompanyProvider.notifier).state =
                                [...listJob, value];
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
                                        Expanded(
                                          child: Text(
                                            listJob[index],
                                            overflow: TextOverflow.fade,
                                            maxLines: 3,
                                          ),
                                        ),
                                        InkWell(
                                          child: Icon(Icons.delete_outlined),
                                          onTap: () {
                                            if (listJob.isNotEmpty) {
                                              ref
                                                  .read(
                                                      listJobTagCompanyProvider
                                                          .notifier)
                                                  .state = [
                                                for (final value in listJob)
                                                  if (value != listJob[index])
                                                    value
                                              ];
                                            }
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
                SizedBox(
                    height: company?.premiumExpiry != null &&
                            company?.premiumExpiry != ''
                        ? 24
                        : 0),
                company?.premiumExpiry != null && company?.premiumExpiry != ''
                    ? EditTextForm(
                        onChanged: ((value) {
                          ref
                              .read(premiumExpireProfileProvider.notifier)
                              .state = value;
                        }),
                        label: Keystring.PREMIUM_EXPIRY_DATE.tr,
                        content: company?.premiumExpiry ?? '',
                        maxLines: 1,
                        readOnly: true,
                      )
                    : SizedBox(height: 0),
                SizedBox(height: 32),
                AppButton(
                  onPressed: () {
                    log(ref.watch(taxCodeCompanyProvider));

                    if (ref.watch(fullNameCompanyProvider).isNotEmpty &&
                        ref.watch(phoneCompanyProvider).isNotEmpty &&
                        ref.watch(websiteCompanyProvider).isNotEmpty &&
                        ref.watch(taxCodeCompanyProvider).isNotEmpty &&
                        provinceChoose!.code != null &&
                        districtChoose!.code != null &&
                        wardChoose!.code != null &&
                        ref.watch(roadCompanyProvider).isNotEmpty &&
                        listJob.isNotEmpty &&
                        ref.watch(descriptionCompanyProvider).isNotEmpty) {
                      if (ref.watch(phoneCompanyProvider).length < 9) {
                        Fluttertoast.showToast(
                          msg: Keystring.PHONE_MORE_9.tr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else if (ref.watch(taxCodeCompanyProvider).length !=
                          10) {
                        Fluttertoast.showToast(
                          msg: Keystring.TAX_CODE_MUST_10.tr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        String job = '';

                        for (var y in listJob) {
                          if (!listTitleJob.any((x) => x == y)) {
                            log('message title: $y');
                            ref
                                .read(LoginControllerProvider.notifier)
                                .createJobTitle(y);
                          }
                          job += '$y,';
                        }

                        if (!edit) {
                          log("click done");

                          ref
                              .read(LoginControllerProvider.notifier)
                              .createCompany(
                                user!.uid ?? '0',
                                ref.watch(fullNameCompanyProvider),
                                ref.watch(avatarCompanyProvider),
                                ref.watch(emailCompanyProvider),
                                ref.watch(phoneCompanyProvider),
                                '${ref.watch(roadCompanyProvider)},${wardChoose.code},${districtChoose.code},${provinceChoose.code}',
                                ref.watch(websiteCompanyProvider),
                                ref.watch(taxCodeCompanyProvider),
                                ref.watch(descriptionCompanyProvider),
                                job.substring(0, job.length - 1),
                              );
                        } else {
                          log("click update");
                          ref
                              .read(LoginControllerProvider.notifier)
                              .updateCompany(
                                user!.uid ?? '0',
                                ref.watch(fullNameCompanyProvider),
                                ref.watch(avatarCompanyProvider),
                                company?.email ?? '',
                                ref.watch(phoneCompanyProvider),
                                '${ref.watch(roadCompanyProvider)},${wardChoose.code},${districtChoose.code},${provinceChoose.code}',
                                ref.watch(websiteCompanyProvider),
                                ref.watch(taxCodeCompanyProvider),
                                ref.watch(descriptionCompanyProvider),
                                job.substring(0, job.length - 1),
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
                  label: edit ? Keystring.UPDATE.tr : Keystring.DONE.tr,
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
