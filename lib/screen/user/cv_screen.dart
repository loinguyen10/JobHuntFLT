import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/screen/user/viewcv.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../component/loader_overlay.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';

class CVChooseScreen extends ConsumerWidget {
  const CVChooseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Keystring.YOUR_CV.tr),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ref.invalidate(cvUploadProvider);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CVUploadScreen()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.upload_file_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.UPLOAD_CV.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.invalidate(listYourCVProvider);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CVManagerScreen()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.folder_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.MANAGER_CV.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CVCreateScreen extends ConsumerWidget {
  const CVCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.CREATE_CV.tr),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CVUploadScreen extends ConsumerWidget {
  const CVUploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String cv = ref.watch(cvUploadProvider);
    String status = ref.watch(uploadCheckProvider);
    final user = ref.watch(userLoginProvider);

    Future<void> upload() async {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);

        ref.read(cvUploadProvider.notifier).state = file.path;
        ref.invalidate(uploadCheckProvider);
      } else {
        // User canceled the picker
      }
    }

//listen
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent || state is CheckCountErrorEvent) {
          log('error');
          ref.read(uploadCheckProvider.notifier).state = 'error';
        }

        if (state is CreateThingSuccessEvent) {
          log('c-success');
          ref.read(uploadCheckProvider.notifier).state = 'success';
          if (ref.watch(userProfileProvider)?.level != 'Premium') {
            ref.read(LoginControllerProvider.notifier).addCount(
                  ref.watch(userLoginProvider)?.uid ?? '',
                  Keystring.candidate_upload_cv,
                );
          }
        }

        if (state is CheckCountSuccessEvent) {
          ref
              .read(LoginControllerProvider.notifier)
              .uploadCV(user!.uid ?? '0', cv);
        }

        if (state is CheckCountOverwriteEvent) {
          ref.read(uploadCheckProvider.notifier).state = 'error';
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  state.messageOverwrite == 'CV full'
                      ? Keystring.CV_FULL.tr
                      : Keystring.WARNING.tr,
                  style: textNormal,
                ),
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

        if (state is CreateThingLoadingEvent || state is ThingLoadingEvent) {
          log('c-loading');
          ref.read(uploadCheckProvider.notifier).state = 'loading';
        }
      },
    );

    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.UPLOAD_CV.tr),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              GestureDetector(
                onTap: () {
                  if (cv == '') {
                    upload();
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(Keystring.HAVING.tr),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                upload();
                                Navigator.pop(context);
                              },
                              child: Text(Keystring.ThatsRight.tr),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(Keystring.CANCEL.tr),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: AppBorderFrame(
                  labelText: '',
                  child: Column(
                    children: [
                      Icon(
                        Icons.upload_file_rounded,
                        size: 80,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        Keystring.PRESS_CHOOSE.tr,
                        style: textNormal,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Keystring.SUPPORTED_FILE.tr}: Pdf',
                      style: textNormal,
                    ),
                    Text(
                      '${Keystring.MAXIMIUM_SIZE.tr}: <5MB',
                      style: textNormal,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              AppButton(
                onPressed: () {
                  if (cv != '') {
                    if (ref.watch(userProfileProvider)?.level == 'Premium') {
                      ref
                          .read(LoginControllerProvider.notifier)
                          .uploadCV(user!.uid ?? '0', cv);
                    } else {
                      ref.read(LoginControllerProvider.notifier).checkCount(
                          ref.watch(userLoginProvider)!.uid ?? '',
                          Keystring.candidate_upload_cv);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: Keystring.NOT_FULL_DATA.tr,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                label: Keystring.UPLOAD.tr,
                height: 56,
                fontSize: 20,
              ),
              SizedBox(
                height: 16,
              ),
              cv != ''
                  ? SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 2),
                            child: Expanded(
                              child: Text(
                                cv.substring(cv.lastIndexOf('/') + 1),
                                style: textNormal,
                              ),
                            ),
                          ),
                          status == 'waiting'
                              ? Text(
                                  Keystring.WAITING.tr,
                                  style: textCV,
                                )
                              : status == 'loading'
                                  ? CircularProgressIndicator()
                                  : status == 'success'
                                      ? Text(
                                          Keystring.SUCCESSFUL.tr,
                                          style: textCVupload.copyWith(
                                              color: Colors.green),
                                        )
                                      : Text(
                                          Keystring.UNSUCCESSFUL.tr,
                                          style: textCVupload,
                                        ),
                        ],
                      ),
                    )
                  : SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class CVManagerScreen extends ConsumerWidget {
  const CVManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listYourCVProvider);

    void deleteDialog(String code) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(Keystring.DELETE.tr),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(LoginControllerProvider.notifier).removeCV(code);
                  Navigator.pop(context);
                },
                child: const Text('YES'),
              ),
            ],
          );
        },
      );
    }

    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is RemoveCVErrorEvent) {
          Loader.hide();
          log('error');
        }

        if (state is RemoveCVSuccessEvent) {
          Loader.hide();
          log('c-success');
        }

        if (state is ThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.MANAGER_CV.tr),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 8),
              Text(
                Keystring.HOLD_DELETE.tr.toUpperCase(),
                style: textNormal,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              _data.when(
                data: (data) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      String type = data[index].type ?? '';
                      String createTime = data[index].createTime ?? '';
                      String? updateTime = data[index].updateTime;

                      return Card(
                        shadowColor: Colors.black,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 5,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewCVScreen(
                                        cv: data[index].cvUrl ?? '',
                                      )),
                            );
                          },
                          onLongPress: () =>
                              deleteDialog(data[index].code ?? '0'),
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 15,
                                  child: Text(
                                    (index + 1).toString(),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    type == 'create'
                                        ? '${Keystring.CREATED_CV.tr} - ${index + 1}'
                                        : '${Keystring.UPLOADED_CV.tr} - ${index + 1}',
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    updateTime != null && updateTime.isNotEmpty
                                        // ? '${Keystring.UPDATE.tr}: ${updateTime}'
                                        // : '${Keystring.CREATE.tr}: ${createTime}',
                                        ? updateTime
                                        : createTime,
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ]),
                        ),
                      );
                    },
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) => SizedBox(
                  height: 160,
                  child: Center(
                    child: Text(Keystring.NO_DATA.tr),
                  ),
                ),
                loading: () => const SizedBox(
                  height: 160,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
