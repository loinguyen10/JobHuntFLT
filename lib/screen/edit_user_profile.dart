import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhunt_ftl/value/style.dart';
import 'package:path_provider/path_provider.dart';

import '../blocs/app_bloc.dart';
import '../blocs/app_event.dart';
import '../blocs/app_state.dart';
import '../component/edittext.dart';
import '../component/loader_overlay.dart';
import '../model/userprofile.dart';

class EditUserProfileScreen extends StatelessWidget {
  EditUserProfileScreen({super.key, required this.profileDetail});
  UserProfileDetail? profileDetail;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsideBloc, InsideState>(
      builder: (context, state) {
        log('profile: ${state.uploadProfileAvatarStatus}');
        if (state.uploadProfileAvatarStatus ==
            UploadProfileAvatarStatus.success) {
          // Loader.show(context);
        }

        if (state.uploadProfileAvatarStatus == UploadProfileCVStatus.open) {
          // Loader.hide();
        }

        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text("EDIT USER PROFILE"),
            backgroundColor: Colors.black,
          ),
          body: ScreenEditUserProfile(
            profileDetail: profileDetail,
          ),
        ));
      },
    );
  }
}

class ScreenEditUserProfile extends StatefulWidget {
  ScreenEditUserProfile({
    super.key,
    this.profileDetail,
  });
  UserProfileDetail? profileDetail;

  @override
  State<ScreenEditUserProfile> createState() => _ScreenEditUserProfile();
}

enum _typeSalaryRadio { usd, vnd }

class _ScreenEditUserProfile extends State<ScreenEditUserProfile> {
  String avatar = '';
  String cv = '';
  String filePath = '';
  String? education;
  String? profession;
  _typeSalaryRadio? typeSalary = _typeSalaryRadio.vnd;

  List<String> listEducation = [
    'Tốt nghiệp THPT',
    'Tốt nghiệp trung cấp',
    'Tốt nghiệp Cao Đẳng',
    'Tốt nghiệp đại học',
    'Trên đại học',
  ];

  List<String> listProfession = [
    'Công nghệ thông tin',
    'Marketing',
    'Kế toán',
    'Bảo hiểm',
    'Bác sĩ',
  ];

  @override
  void initState() {
    super.initState();

    avatar = widget.profileDetail?.avatarUrl ?? '';
  }

  DropdownButtonHideUnderline dropButton(List<String> list) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: list
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: list == listEducation ? education : profession,
        onChanged: (String? value) {
          setState(() {
            list == listEducation
                ? education = value
                //  BlocProvider.of<InsideBloc>(context).add(UserProfileEducationChangedEvent(education: value))
                : profession = value;
            // BlocProvider.of<InsideBloc>(context).add(UserProfileProfessionChangedEvent(profession: value));
            log('$education & $profession');
          });
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }

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
                                        // final bytes =
                                        //     File(filePath).readAsBytesSync();

                                        // String img64 =
                                        //     'data:image/png;base64,' +
                                        //         base64Encode(bytes);

                                        fileCall(1, filePath);
                                        Navigator.pop(context);

                                        // saveSignatureStaff(type, img64);
                                      } else {
                                        fileCall(2, filePath);
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
                                                  color:
                                                      Colors.transparent)))))),
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
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['pdf']);

                                        if (result != null &&
                                            result.files.single.path != null) {
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

  void fileCall(int type, String filePath) {
    if (type == 1) {
      avatar = filePath;
      BlocProvider.of<InsideBloc>(context).add(UserProfileAvatarChangedEvent());
    } else {
      cv = filePath;
      BlocProvider.of<InsideBloc>(context).add(UserProfileCVChangedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      avatar.trim().substring(0, 8) == 'https://'
                          ? Image.network(
                              avatar,
                              width: 256,
                              height: 256,
                            )
                          : Image.file(
                              File(avatar),
                              width: 256,
                              height: 256,
                            ),
                      ElevatedButton(
                          onPressed: () {
                            upload(1);
                          },
                          child: Text('Avatar')),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.profileDetail?.cvUrl != null
                          ? cv != ''
                              ? Text(
                                  'CV has uploaded',
                                  style: textCVupload,
                                )
                              : Text(
                                  'This profile has CV.',
                                  style: textCV,
                                )
                          : cv != ''
                              ? Text(
                                  'CV has uploaded',
                                  style: textCVupload,
                                )
                              : Text(
                                  'This profile don\'t have CV.',
                                  style: textCV,
                                ),
                      ElevatedButton(
                          onPressed: () {
                            upload(2);
                          },
                          child: Text('CV')),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Education'),
                      Container(
                        child: dropButton(listEducation),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                EditTextForm(
                  onChanged: ((value) {
                    BlocProvider.of<InsideBloc>(context).add(
                        UserProfileMinSalaryChangedEvent(minSalary: value));
                  }),
                  content: widget.profileDetail?.minSalary ?? '',
                  textColor: Colors.black,
                  borderSelected: Colors.orange,
                  label: 'Min Salary',
                  hintText: 'Min Salary',
                ),
                SizedBox(height: 30.0),
                EditTextForm(
                  onChanged: ((value) {
                    BlocProvider.of<InsideBloc>(context).add(
                        UserProfileMaxSalaryChangedEvent(maxSalary: value));
                  }),
                  content: widget.profileDetail?.maxSalary ?? '',
                  textColor: Colors.black,
                  borderSelected: Colors.orange,
                  label: 'Max Salary',
                  hintText: 'Max Salary',
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Profession'),
                      Container(
                        child: dropButton(listProfession),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                // EditTextForm(
                //   onChanged: ((value) {
                //     BlocProvider.of<InsideBloc>(context).add(
                //         UserProfileTypeSalaryChangedEvent(typeSalary: value));
                //   }),
                //   content: widget.profileDetail?.typeSalary ?? '',
                //   textColor: Colors.black,
                //   borderSelected: Colors.orange,
                //   label: 'Type Salary',
                //   hintText: 'Type Salary',
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Type Salary'),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     RadioListTile<_typeSalaryRadio>(
                      //       title: Text('USD'),
                      //       value: _typeSalaryRadio.usd,
                      //       groupValue: typeSalary,
                      //       onChanged: (_typeSalaryRadio? value) {
                      //         typeSalary = value;
                      //         setState(() {});
                      //       },
                      //     ),
                      //     RadioListTile<_typeSalaryRadio>(
                      //       title: Text('VND'),
                      //       value: _typeSalaryRadio.vnd,
                      //       groupValue: typeSalary,
                      //       onChanged: (_typeSalaryRadio? value) {
                      //         typeSalary = value;
                      //         setState(() {});
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
              ],
            ),
          )
          //
          ),
    );
  }
}
