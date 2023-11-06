import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/app_button.dart';
import '../../component/card.dart';
import '../../component/loader_overlay.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../home.dart';
import '../user/viewcv.dart';
import 'job_view_screen.dart';

class ApplicationViewFullScreen extends ConsumerWidget {
  const ApplicationViewFullScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final application = ref.watch(applicationDetailProvider);
    final job = application!.job;
    final candidate = application.candidate;

    //listen
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent) {
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
          Fluttertoast.showToast(
              msg: Keystring.SUCCESSFUL.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.offAll(HomeScreen());
        }

        if (state is CreateThingLoadingEvent) {
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
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
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
              AppButton(
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
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        ref
                            .read(LoginControllerProvider.notifier)
                            .apporveApplication(
                              application.code ?? '0',
                              '1',
                            );
                      },
                      label: Keystring.APPORVE.tr,
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
                        ref
                            .read(LoginControllerProvider.notifier)
                            .apporveApplication(
                              application.code ?? '0',
                              '0',
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
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
