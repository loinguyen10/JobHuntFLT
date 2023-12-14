import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/app_button.dart';
import '../../component/border_frame.dart';
import '../../component/card.dart';
import '../../component/loader_overlay.dart';
import '../../model/cv.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../user/viewcv.dart';

class ApplyJobScreen extends ConsumerWidget {
  const ApplyJobScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CVdata = ref.watch(listYourCVProvider);

    final job = ref.watch(jobDetailProvider);

    List<CVDetail> cvList = [];

    final CVChoose = ref.watch(CVChooseProvider);

    CVdata.when(
      data: (data) {
        cvList.addAll(data);
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    DropdownButtonHideUnderline dropCV() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: cvList
              .map((item) => DropdownMenuItem<CVDetail>(
                    value: item,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.type == 'create'
                                  ? Keystring.CREATED_CV.tr
                                  : Keystring.UPLOADED_CV.tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item.updateTime != null &&
                                      item.updateTime!.isNotEmpty
                                  ? '${Keystring.UPDATE.tr}: ${item.updateTime}'
                                  : '${Keystring.CREATE.tr}: ${item.createTime}',
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ]),
                  ))
              .toList(),
          value: CVChoose?.code != null ? CVChoose : null,
          onChanged: (value) {
            ref.read(CVChooseProvider.notifier).state = value;
            log('CV: ${value?.type}');
          },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    //listen
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent || state is CheckCountErrorEvent) {
          Loader.hide();
          log('error2');
          Fluttertoast.showToast(
              msg: Keystring.UNSUCCESSFUL.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        if (state is CreateThingSuccessEvent) {
          Loader.hide();
          log('c-success1');
          if (ref.watch(userProfileProvider)?.level != 'Premium') {
            ref.read(LoginControllerProvider.notifier).addCount(
                  ref.watch(userLoginProvider)?.uid ?? '',
                  Keystring.candidate_apply_job,
                );
          }
          Fluttertoast.showToast(
              msg: Keystring.SUCCESSFUL.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        }

        if (state is CheckCountSuccessEvent) {
          ref.read(LoginControllerProvider.notifier).createApplication(
                CVChoose?.cvUrl ?? '',
                job?.code ?? '',
                ref.watch(userLoginProvider)!.uid ?? '',
                job?.company!.uid ?? '',
              );
        }

        if (state is CheckCountOverwriteEvent) {
          Loader.hide();
          log('error3');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  Keystring.WARNING.tr,
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
          Loader.show(context);
        }
      },
    );

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.background == Colors.white
                ? bgGradientColor0
                : bgGradientColor1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32),
              AppJobCard(
                avatar: job!.company!.avatarUrl ?? '',
                name: job.name ?? '',
                companyName: job.company!.fullname ?? '',
                province: getProvinceName(
                    job.address!.substring(job.address!.lastIndexOf(',') + 1),
                    ref),
                money: job.maxSalary != -1
                    ? '${job.maxSalary} ${job.currency}'
                    : Keystring.ARGEEMENT.tr,
                deadline: job.deadline ?? '',
              ),
              SizedBox(height: 32),
              AppBorderFrame(
                labelText: Keystring.SELECT_CV.tr,
                child: dropCV(),
              ),
              SizedBox(height: 32),
              CVChoose?.code != null
                  ? AppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewCVScreen(
                                    cv: CVChoose?.cvUrl ?? '',
                                  )),
                        );
                      },
                      label: Keystring.VIEW_SELECTED_CV.tr,
                      bgColor: Colors.grey,
                      textColor: Colors.black,
                      colorBorder: Colors.black,
                      borderRadius: 16,
                      height: 56,
                    )
                  : SizedBox(height: 0),
              SizedBox(height: 20),
              CVChoose?.code != null
                  ? AppButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                  '${Keystring.CONFIRM.tr.toUpperCase()}?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    if (ref.watch(userProfileProvider)?.level ==
                                        'Premium') {
                                      ref
                                          .read(
                                              LoginControllerProvider.notifier)
                                          .createApplication(
                                            CVChoose?.cvUrl ?? '',
                                            job.code ?? '',
                                            ref.watch(userLoginProvider)!.uid ??
                                                '',
                                            job.company!.uid ?? '',
                                          );
                                    } else {
                                      ref
                                          .read(
                                              LoginControllerProvider.notifier)
                                          .checkCount(
                                              ref
                                                      .watch(userLoginProvider)!
                                                      .uid ??
                                                  '',
                                              Keystring.candidate_apply_job);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text(Keystring.CONFIRM.tr),
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
                      },
                      label: Keystring.DONE.tr,
                      bgColor: appPrimaryColor,
                      height: 56,
                    )
                  : SizedBox(height: 0),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
