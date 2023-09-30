import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';

import '../blocs/app_controller.dart';
import '../blocs/app_event.dart';
import '../component/app_button.dart';
import '../component/loader_overlay.dart';
import '../value/keystring.dart';
import '../value/style.dart';

class BlankTestScreen extends ConsumerWidget {
  const BlankTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String filePath = '';

    final profile = ref.watch(userProfileProvider);

    final avatarProfile = ref.watch(avatarProfileProvider);
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
        }

        if (state is UpdateThingSuccessEvent) {
          Loader.hide();
          log('u-success');
        }

        if (state is CreateThingLoadingEvent ||
            state is UpdateThingLoadingEvent) {
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
              AppButton(
                onPressed: () {
                  // ref.read(LoginControllerProvider.notifier).uploadImage(
                  //     'candidate', '2', ref.watch(avatarProfileProvider));
                },
                bgColor: appPrimaryColor,
                height: 64,
                content: Keystring.DONE.tr,
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
