import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/component/outline_text.dart';
import 'package:jobhunt_ftl/screen/job/edit_job.dart';
import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../component/app_button.dart';
import '../../component/loader_overlay.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';

class JobViewScreen extends ConsumerWidget {
  const JobViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userLoginProvider)?.role;
    final job = ref.watch(jobDetailProvider);
    final bmCheck = ref.watch(turnBookmarkOn);

    //listen
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent || state is UpdateThingErrorEvent) {
          Loader.hide();
          log('error4');
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

        if (state is CreateThingSuccessEvent ||
            state is UpdateThingSuccessEvent) {
          Loader.hide();
          log('c-success');
        }

        if (state is CreateThingLoadingEvent ||
            state is UpdateThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return Container(
      decoration: BoxDecoration(gradient: bgGradientColor),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                elevation: 0,
                actions: [
                  role == 'recuiter'
                      ? Container(
                          margin: EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        JobEditScreen(edit: true)),
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        )
                      : SizedBox(width: 0),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(72),
                      child: job!.company!.avatarUrl != ''
                          ? Image.network(job.company!.avatarUrl ?? '',
                              fit: BoxFit.cover)
                          : Icon(
                              Icons.apartment,
                              size: 120,
                            ),
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppOutlineText(
                          text: job.name ?? '',
                          fontSize: 24,
                          strokeWidth: 3,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          job.company?.fullname ?? '',
                          overflow: TextOverflow.fade,
                          maxLines: 3,
                          style: textCompanyJView,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        role != null
                            ? role != 'recuiter'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppButton(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        onPressed: () {
                                          //
                                        },
                                        content: Keystring.APPLY_NOW.tr,
                                        bgColor: appPrimaryColor,
                                        colorBorder: appPrimaryColor,
                                        borderRadius: 16,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (bmCheck) {
                                            ref
                                                .read(LoginControllerProvider
                                                    .notifier)
                                                .removeFavorive(
                                                  job.code ?? '0',
                                                  ref
                                                          .watch(
                                                              userLoginProvider)
                                                          ?.uid ??
                                                      '0',
                                                );
                                          } else {
                                            ref
                                                .read(LoginControllerProvider
                                                    .notifier)
                                                .addFavorive(
                                                  job.code ?? '0',
                                                  ref
                                                          .watch(
                                                              userLoginProvider)
                                                          ?.uid ??
                                                      '0',
                                                );
                                          }
                                        },
                                        child: bmCheck
                                            ? const Icon(
                                                Icons.bookmark_added_rounded,
                                                size: 48,
                                                color: Colors.yellow,
                                              )
                                            : const Icon(
                                                Icons.bookmark_outline,
                                                size: 48,
                                              ),
                                      ),
                                    ],
                                  )
                                : AppButton(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    onPressed: () {
                                      //
                                    },
                                    content: Keystring.CHECK_CV.tr,
                                    bgColor: appPrimaryColor,
                                    colorBorder: appPrimaryColor,
                                    borderRadius: 16,
                                  )
                            : SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '${Keystring.INFORMATION.tr}:',
                  style: textTitleJView,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: appPrimaryColor,
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${getDistrictName(job.address!.substring(0, job.address!.indexOf(',')), ref)}, ${getProvinceName(job.address!.substring(job.address!.lastIndexOf(',') + 1), ref)}',
                        style: textNormal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: appPrimaryColor,
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        job.minSalary == -1 && job.maxSalary == -1
                            ? Keystring.ARGEEMENT.tr
                            : '${job.minSalary} - ${job.maxSalary} ${job.currency}',
                        style: textNormal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: appPrimaryColor,
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${job.yearExperience} ${Keystring.Year_Experience.tr}',
                        style: textNormal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: appPrimaryColor,
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        job.typeJob == 0
                            ? Keystring.INTERN.tr
                            : job.typeJob == 1
                                ? Keystring.PART_TIME.tr
                                : Keystring.FULL_TIME.tr,
                        style: textNormal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.people_alt_outlined,
                      color: appPrimaryColor,
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${job.numberCandidate} ${Keystring.PERSON.tr}',
                        style: textNormal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: appPrimaryColor,
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${Keystring.Deadline.tr}: ${job.deadline ?? ''}',
                        style: textNormal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '${Keystring.Job_Detail.tr}:',
                  style: textTitleJView,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  job.description ?? '',
                  style: textNormal,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${Keystring.Candidate_Requirement.tr}:',
                  style: textTitle2JView,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  job.candidateRequirement ?? '',
                  style: textNormal,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${Keystring.Job_Benefit.tr}:',
                  style: textTitle2JView,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  job.jobBenefit ?? '',
                  style: textNormal,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${Keystring.Tag.tr}:',
                  style: textTitle2JView,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  job.tag ?? '',
                  style: textNormal,
                ),
              ),
              role != 'recuiter'
                  ? SizedBox(
                      height: 24,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              role != 'recuiter'
                  ? AppBorderFrame(
                      labelText: '',
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(56),
                                    child: job.company!.avatarUrl != ''
                                        ? Image.network(
                                            job.company!.avatarUrl ?? '',
                                            fit: BoxFit.cover)
                                        : Icon(
                                            Icons.apartment,
                                            size: 96,
                                          ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  job.company?.fullname ?? '',
                                  style: textCompany2JView,
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(width: 12),
                          // Expanded(
                          //   child: Container(
                          //     child: JobCompanySuggestionScreen(),
                          //   ),
                          // ),
                          SizedBox(width: 8),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
