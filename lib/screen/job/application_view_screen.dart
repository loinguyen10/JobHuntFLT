import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/date_dialog.dart';
import 'package:jobhunt_ftl/screen/user/show_proflie.dart';
import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/app_button.dart';
import '../../component/card.dart';
import '../../component/loader_overlay.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../user/viewcv.dart';
import 'job_view_screen.dart';

class ApplicationViewFullScreen extends ConsumerStatefulWidget {
  const ApplicationViewFullScreen({
    super.key,
    required this.recruiter,
  });
  final bool recruiter;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApplicationViewFullScreenState();
}

class _ApplicationViewFullScreenState
    extends ConsumerState<ApplicationViewFullScreen> {
  @override
  Widget build(BuildContext context) {
    final application = ref.watch(applicationDetailProvider);
    final job = application!.job;
    final candidate = application.candidate;

    bool? approveIt;

    void showInterviewTime(bool edit) {
      showDialog(
        context: context,
        builder: (context) {
          return InterviewTimeDialog(
            code: application.code ?? '0',
            edit: edit,
          );
        },
      );
    }

    //listen
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent || state is CheckCountErrorEvent) {
          Loader.hide();
          log('error-apply');
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
          log('c-success-apply');

          if (ref.watch(companyProfileProvider)?.level != 'Premium') {
            ref.read(LoginControllerProvider.notifier).addCount(
                  ref.watch(userLoginProvider)!.uid ?? '',
                  Keystring.recruiter_job_appication,
                );
          }

          ref.invalidate(getListRecuiterApplicationProvider);
          Get.back();
          Fluttertoast.showToast(
              msg: Keystring.SUCCESSFUL.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        if (state is CheckCountSuccessEvent) {
          if (approveIt == true) {
            Loader.hide();
            showInterviewTime(false);
          } else if (approveIt == false) {
            ref.read(LoginControllerProvider.notifier).approveApplication(
                  application.code ?? '0',
                  '0',
                );
          }
        }

        if (state is CheckCountOverwriteEvent) {
          Loader.hide();
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

        if (state is ThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return Container(
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                title: Text(Keystring.DETAIL.tr),
              ),
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
              AppButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobViewScreen()),
                  );
                },
                label: Keystring.VIEW_JOB.tr,
                bgColor: Colors.grey,
                textColor: Colors.black,
                colorBorder: Colors.black,
                borderRadius: 16,
                height: 56,
              ),
              SizedBox(height: 32),
              AppCandidateProfileCard(
                candidate: candidate,
                province: getProvinceName(
                    candidate!.address!
                        .substring(candidate.address!.lastIndexOf(',') + 1),
                    ref),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  widget.recruiter
                      ? Expanded(
                          child: AppButton(
                            onPressed: () {
                              getCandidateRecommend(
                                  application.candidate!.uid ?? '0', ref);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowProfileScreen(
                                          profile: application.candidate!,
                                        )),
                              );
                            },
                            label: Keystring.VIEW_PROFILE.tr,
                            bgColor: Colors.grey,
                            textColor: Colors.black,
                            colorBorder: Colors.black,
                            borderRadius: 16,
                            height: 56,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        )
                      : SizedBox(width: 0),
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewCVScreen(
                                    cv: application.cvUrl ?? '',
                                  )),
                        );
                      },
                      label: Keystring.VIEW_CV.tr,
                      bgColor: Colors.grey,
                      textColor: Colors.black,
                      colorBorder: Colors.black,
                      borderRadius: 16,
                      height: 56,
                      margin: EdgeInsets.symmetric(
                          horizontal: widget.recruiter ? 16 : 0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              widget.recruiter
                  ? Container(
                      child: application.approve == null ||
                              application.approve == ''
                          ? Row(
                              children: [
                                SizedBox(width: 16),
                                Expanded(
                                  child: AppButton(
                                    onPressed: () {
                                      if (ref
                                              .watch(companyProfileProvider)
                                              ?.level ==
                                          'Premium') {
                                        showInterviewTime(false);
                                      } else {
                                        approveIt = true;
                                        ref
                                            .read(LoginControllerProvider
                                                .notifier)
                                            .checkCount(
                                              ref
                                                      .watch(userLoginProvider)!
                                                      .uid ??
                                                  '',
                                              Keystring
                                                  .recruiter_job_appication,
                                            );
                                      }
                                    },
                                    label: Keystring.APPROVE.tr,
                                    bgColor: Colors.green,
                                    textColor: Colors.white,
                                    colorBorder: Colors.green,
                                    borderRadius: 16,
                                    height: 56,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: AppButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(Keystring.CONFIRM.tr),
                                          content: Text(Keystring.CONFIRM.tr),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                if (ref
                                                        .watch(
                                                            companyProfileProvider)
                                                        ?.level ==
                                                    'Premium') {
                                                  ref
                                                      .read(
                                                          LoginControllerProvider
                                                              .notifier)
                                                      .approveApplication(
                                                        application.code ?? '0',
                                                        '0',
                                                      );
                                                } else {
                                                  approveIt = false;
                                                  ref
                                                      .read(
                                                          LoginControllerProvider
                                                              .notifier)
                                                      .checkCount(
                                                        ref
                                                                .watch(
                                                                    userLoginProvider)!
                                                                .uid ??
                                                            '',
                                                        Keystring
                                                            .recruiter_job_appication,
                                                      );
                                                }
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  Text(Keystring.ThatsRight.tr),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(Keystring.CANCEL.tr),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    label: Keystring.REJECT.tr,
                                    bgColor: Colors.red,
                                    textColor: Colors.white,
                                    colorBorder: Colors.red,
                                    borderRadius: 16,
                                    height: 56,
                                  ),
                                ),
                                SizedBox(width: 16),
                              ],
                            )
                          : application.approve == '1'
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${Keystring.INTERVIEW_TIME.tr}:',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            application.interviewTime ?? '',
                                            style: textNormalBold.copyWith(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 0, 150, 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: AppButton(
                                        onPressed: () {
                                          ref.invalidate(
                                              timeInterviewApplicationProvider);
                                          showInterviewTime(true);
                                        },
                                        label: Keystring.EDIT.tr,
                                        bgColor: appPrimaryColor,
                                        borderRadius: 16,
                                        height: 56,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(height: 0),
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

class InterviewTimeDialog extends ConsumerStatefulWidget {
  const InterviewTimeDialog({
    super.key,
    required this.code,
    required this.edit,
  });

  final String code;
  final bool edit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InterviewTimeDialogState();
}

class _InterviewTimeDialogState extends ConsumerState<InterviewTimeDialog> {
  @override
  Widget build(BuildContext context) {
    final date = ref.watch(dateTimeInterviewApplicationProvider);
    final time = ref.watch(timeTimeInterviewApplicationProvider);
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(Keystring.INTERVIEW_TIME.tr),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Keystring.SET_DATE.tr,
                  style: textNormalBold.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 16),
                      DateCustomDialog().setDateInterview(context, ref),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  Keystring.SET_TIME.tr,
                  style: textNormalBold.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 16),
                      DateCustomDialog().setTimeInterview(context, ref),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (date.isEmpty || time.isEmpty) {
                  Fluttertoast.showToast(
                    msg: Keystring.NOT_FULL_DATA.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(Keystring.CONFIRM.tr),
                      content: Text(Keystring.CONFIRM.tr),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            ref
                                    .read(timeInterviewApplicationProvider.notifier)
                                    .state =
                                '${ref.watch(dateTimeInterviewApplicationProvider)} ${ref.watch(timeTimeInterviewApplicationProvider)}';

                            log('date new: ${ref.watch(timeInterviewApplicationProvider)}');

                            if (!widget.edit) {
                              ref
                                  .read(LoginControllerProvider.notifier)
                                  .approveApplication(
                                    widget.code,
                                    '1',
                                  );
                              Navigator.pop(context);
                            }

                            ref
                                .read(LoginControllerProvider.notifier)
                                .updateInterviewApplication(
                                  widget.code,
                                  ref.watch(timeInterviewApplicationProvider),
                                );

                            Navigator.pop(context);
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
                    ),
                  );
                }
              },
              child: Icon(Icons.check),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close),
            ),
          ],
        );
      },
    );
  }
}
