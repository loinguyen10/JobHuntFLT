import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/component/outline_text.dart';
import 'package:jobhunt_ftl/screen/job/apply_job_screen.dart';
import 'package:jobhunt_ftl/screen/job/edit_job.dart';
import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../component/app_button.dart';
import '../../component/loader_overlay.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../report/report_company.dart';
import '../user/company_information.dart';

class JobViewScreen extends ConsumerWidget {
  const JobViewScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userLoginProvider)?.role;
    final job = ref.watch(jobDetailProvider);
    final bmCheck = ref.watch(turnBookmarkOn);

    final address = job!.company!.address!;
    final last = address.lastIndexOf(',');
    String addressRoad = address.substring(
        0, address.lastIndexOf(',', address.lastIndexOf(',', last - 1) - 1));
    String addressWard = getWardName(
        address.substring(
            address.lastIndexOf(',', address.lastIndexOf(',', last - 1) - 1) +
                1,
            address.lastIndexOf(',', last - 1)),
        ref);
    String addressDistrict = getDistrictName(
        address.substring(
            address.lastIndexOf(',', last - 1) + 1, address.lastIndexOf(',')),
        ref);
    String addressProvince = getProvinceName(address.substring(last + 1), ref);

    final tagJob = job.tag!.split(',');
    final tagCompany = job.company!.job?.split(',');

    if (role != 'recruiter') {
      ref
          .read(LoginControllerProvider.notifier)
          .clickViewPlusJob(job.code ?? '0');
    }

    //listen
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is FavoriteErrorEvent) {
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

        if (state is FavoriteSuccessEvent) {
          Loader.hide();
          log('c-success');
          log('bm: ${bmCheck}');
        }

        if (state is FavoriteLoadingEvent) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                elevation: 0,
                actions: [
                  role == 'recruiter'
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
                      : Container(
                          margin: EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReportScreen(job: job),
                                  ));
                            },
                            child: Icon(
                              Icons.report_rounded,
                              color: Colors.redAccent.shade700,
                              size: 40,
                            ),
                          ),
                        )
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
                      child: job.company!.avatarUrl != ''
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
                            ? role != 'recruiter'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      job.remainPeople! > 0 && job.active == 1
                                          ? AppButton(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ApplyJobScreen()));
                                              },
                                              label: Keystring.APPLY_NOW.tr,
                                              fontSize: 14,
                                              bgColor: appPrimaryColor,
                                              colorBorder: appPrimaryColor,
                                              borderRadius: 16,
                                            )
                                          : SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              child: Container()),
                                      Expanded(
                                        child: InkWell(
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
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 48,
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
                height: job.remainPeople! > 0 && job.active == 1 ? 0 : 24,
              ),
              job.remainPeople! > 0 && job.active == 1
                  ? SizedBox(height: 0)
                  : Container(
                      color: appBgGradientColor,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          Keystring.NO_AVAILABLE.tr,
                          style: textNormal.copyWith(color: Colors.white),
                        ),
                      ),
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
                            : '${getReduceZeroMoney(job.minSalary ?? 0)} - ${getReduceZeroMoney(job.maxSalary ?? 0)} ${job.currency}',
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
                        job.yearExperience! > 0
                            ? '${job.yearExperience} ${Keystring.Year_Experience.tr}'
                            : Keystring.No_Experience_Required.tr,
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
                        role != 'recruiter'?
                        '${job.remainPeople} ${Keystring.PERSON.tr}'
                            : '${job.remainPeople} ${Keystring.PERSON.tr} (${Keystring.Require.tr} ${job.numberCandidate} ${Keystring.PERSON.tr})'
                        ,
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
                  child: Wrap(
                    children: [
                      for (var i in tagJob)
                        AppTagCard(
                          margin:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: Text(i),
                        ),
                    ],
                  )),
              SizedBox(
                height: role != 'recruiter' ? 24 : 0,
              ),
              role != 'recruiter'
                  ? AppBorderFrame(
                      labelText: '',
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
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
                                SizedBox(height: 16),
                                AppButton(
                                  onPressed: () {
                                    ref
                                        .read(companyInforProvider.notifier)
                                        .state = job.company!;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompanyInformation()),
                                    );
                                  },
                                  height: 40,
                                  label: Keystring.CHECK.tr,
                                  bgColor: appPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${Keystring.HEADQUARTER.tr}:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '$addressRoad, $addressWard, $addressDistrict, $addressProvince',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Wrap(
                                  children: [
                                    AppTagCard(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 4),
                                      child: Text(tagCompany![0]),
                                    ),
                                    tagCompany.length >= 2
                                        ? AppTagCard(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 8),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 4),
                                            child: Text(tagCompany[1]),
                                          )
                                        : SizedBox(width: 0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(height: 0),
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
