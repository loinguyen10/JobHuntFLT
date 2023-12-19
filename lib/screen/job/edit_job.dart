import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/app_autocomplete.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../component/app_button.dart';
import '../../component/date_dialog.dart';
import '../../component/edittext.dart';
import '../../component/loader_overlay.dart';
import '../../model/address.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';

class JobEditScreen extends ConsumerWidget {
  const JobEditScreen({super.key, this.edit = false});

  final bool edit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(companyProfileProvider);
    final job = ref.watch(jobDetailProvider);

    final listProvinceData = ref.watch(listProvinceProvider);
    final listDistrictData = ref.watch(listDistrictProvider);

    final provinceChoose = ref.watch(provinceJobProvider);
    final districtChoose = ref.watch(districtJobProvider);
    final jobTypeChoose = ref.watch(jobTypeChooseProvider);

    final jobDeadline = ref.watch(jobDeadlineProvider);
    final jobActive = ref.watch(jobActiveProvider);
    final salaryActive = ref.watch(jobSalaryProvider);

    final listAllTitleJobData = ref.watch(listAllTitleJobSettingProvider);
    final listJob = ref.watch(listJobTagProviderProvider);

    bool isBanned = false;

    List<String> listTitleJob = [];

    List<ProvinceList> listProvince = [];
    List<DistrictList> listDistrict = [];
    List<String> listJobType = [
      Keystring.INTERN.tr,
      Keystring.PART_TIME.tr,
      Keystring.FULL_TIME.tr
    ];

    String jobTag2 = '';

    if (job?.remainPeople == 0) {
      isBanned = true;
    }

    if (jobActive == -1) {
      isBanned = true;
    }

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
          onChanged: isBanned
              ? null
              : (ProvinceList? value) {
                  // listProvince.clear();
                  if (provinceChoose?.code != null) {
                    ref.read(districtJobProvider.notifier).state = null;
                  }
                  ref.read(provinceJobProvider.notifier).state = value;
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
          onChanged: isBanned
              ? null
              : (DistrictList? value) {
                  ref.read(districtJobProvider.notifier).state = value;
                  log('District: ${value?.code}');
                },
          buttonStyleData: dropDownButtonStyle1,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    DropdownButtonHideUnderline dropJobType() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: listJobType
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: textNormal),
                  ))
              .toList(),
          value: jobTypeChoose != null
              ? jobTypeChoose == 0
                  ? Keystring.INTERN.tr
                  : jobTypeChoose == 1
                      ? Keystring.PART_TIME.tr
                      : Keystring.FULL_TIME.tr
              : null,
          onChanged: isBanned
              ? null
              : (String? value) {
                  int? index;
                  if (value == Keystring.INTERN.tr) index = 0;
                  if (value == Keystring.PART_TIME.tr) index = 1;
                  if (value == Keystring.FULL_TIME.tr) index = 2;
                  ref.read(jobTypeChooseProvider.notifier).state = index;
                  log('$value + $index');
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

//void
    void doneButton() {
      if (ref.watch(jobNameProvider).isNotEmpty &&
          !ref.watch(jobMinSalaryProvider).isNaN &&
          !ref.watch(jobMaxSalaryProvider).isNaN &&
          !ref.watch(jobYearExperienceProvider).isNaN &&
          jobTypeChoose != null &&
          !ref.watch(jobNumberCandidateProvider).isNaN &&
          provinceChoose!.code != null &&
          districtChoose!.code != null &&
          ref.watch(jobDescriptionProvider).isNotEmpty &&
          ref.watch(jobCandidateRequirementProvider).isNotEmpty &&
          ref.watch(jobBenefitProvider).isNotEmpty &&
          listJob.isNotEmpty &&
          jobDeadline.isNotEmpty) {
        String jobTag = '';

        for (var y in listJob) {
          if (!listTitleJob.any((x) => x == y)) {
            log('message title: $y');
            ref.read(LoginControllerProvider.notifier).createJobTitle(y);
          }
          jobTag += '$y,';
        }

        jobTag2 = jobTag.substring(0, jobTag.length - 1);

        if (company?.level != 'Premium') {
          ref.read(LoginControllerProvider.notifier).checkCount(
                ref.watch(userLoginProvider)!.uid ?? '',
                edit
                    ? '${Keystring.recruiter_edit_job_}${job?.code}'
                    : Keystring.recruiter_post_job,
              );
        } else {
          if (!edit) {
            log("click done");

            ref.read(LoginControllerProvider.notifier).createJob(
                  ref.watch(jobNameProvider),
                  company!.uid ?? '0',
                  ref.watch(jobMinSalaryProvider),
                  ref.watch(jobMaxSalaryProvider),
                  ref.watch(jobYearExperienceProvider),
                  jobTypeChoose,
                  ref.watch(jobNumberCandidateProvider),
                  '${districtChoose.code},${provinceChoose.code}',
                  ref.watch(jobDescriptionProvider),
                  ref.watch(jobCandidateRequirementProvider),
                  ref.watch(jobBenefitProvider),
                  jobTag.substring(0, jobTag.length - 1),
                  jobDeadline,
                  jobActive, // ? 1 : 0,
                );
          } else {
            log("click update");
            ref.read(LoginControllerProvider.notifier).updateJob(
                  job!.code ?? '0',
                  ref.watch(jobNameProvider),
                  company!.uid ?? '0',
                  ref.watch(jobMinSalaryProvider),
                  ref.watch(jobMaxSalaryProvider),
                  ref.watch(jobYearExperienceProvider),
                  jobTypeChoose,
                  ref.watch(jobNumberCandidateProvider),
                  '${districtChoose.code},${provinceChoose.code}',
                  ref.watch(jobDescriptionProvider),
                  ref.watch(jobCandidateRequirementProvider),
                  ref.watch(jobBenefitProvider),
                  jobTag.substring(0, jobTag.length - 1),
                  jobDeadline,
                  jobActive, // ? 1 : 0,
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
    }

//listen
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent ||
            state is UpdateThingErrorEvent ||
            state is CheckCountErrorEvent) {
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

        if (state is CreateThingSuccessEvent ||
            state is UpdateThingSuccessEvent) {
          Loader.hide();

          if (company?.level != 'Premium') {
            ref.read(LoginControllerProvider.notifier).addCount(
                  ref.watch(userLoginProvider)!.uid ?? '',
                  edit
                      ? '${Keystring.recruiter_edit_job_}${job?.code}'
                      : Keystring.recruiter_post_job,
                );
          }

          log('c-success');
          ref.refresh(listPostJobProvider.future);
          ref.refresh(listJobProvider.future);
          Navigator.pop(context);
        }

        if (state is CheckCountSuccessEvent) {
          if (edit) {
            ref.read(LoginControllerProvider.notifier).updateJob(
                  job!.code ?? '0',
                  ref.watch(jobNameProvider),
                  company!.uid ?? '0',
                  ref.watch(jobMinSalaryProvider),
                  ref.watch(jobMaxSalaryProvider),
                  ref.watch(jobYearExperienceProvider),
                  jobTypeChoose!,
                  ref.watch(jobNumberCandidateProvider),
                  '${districtChoose!.code},${provinceChoose!.code}',
                  ref.watch(jobDescriptionProvider),
                  ref.watch(jobCandidateRequirementProvider),
                  ref.watch(jobBenefitProvider),
                  jobTag2,
                  jobDeadline,
                  jobActive, // ? 1 : 0,
                );
          } else {
            ref.read(LoginControllerProvider.notifier).createJob(
                  ref.watch(jobNameProvider),
                  company!.uid ?? '0',
                  ref.watch(jobMinSalaryProvider),
                  ref.watch(jobMaxSalaryProvider),
                  ref.watch(jobYearExperienceProvider),
                  jobTypeChoose!,
                  ref.watch(jobNumberCandidateProvider),
                  '${districtChoose!.code},${provinceChoose!.code}',
                  ref.watch(jobDescriptionProvider),
                  ref.watch(jobCandidateRequirementProvider),
                  ref.watch(jobBenefitProvider),
                  jobTag2,
                  jobDeadline,
                  jobActive, // ? 1 : 0,
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

        if (state is CreateThingLoadingEvent ||
            state is UpdateThingLoadingEvent ||
            state is ThingLoadingEvent) {
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
                !isBanned
                    ? SizedBox(height: 0)
                    : Container(
                        color: Colors.white60,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            Keystring.NO_AVAILABLE.tr,
                            style:
                                textNormalBold.copyWith(color: Colors.red[900]),
                          ),
                        ),
                      ),
                SizedBox(height: isBanned ? 24 : 32),
                EditTextForm(
                  onChanged: ((value) {
                    //
                  }),
                  label: Keystring.Company_Name.tr,
                  content: ref.watch(fullNameCompanyProvider),
                  readOnly: true,
                ),
                SizedBox(height: 24),
                EditTextForm(
                  onChanged: ((value) {
                    ref.read(jobNameProvider.notifier).state = value;
                  }),
                  label: Keystring.Name_Job.tr,
                  content: job?.name ?? '',
                  readOnly: isBanned,
                ),
                SizedBox(height: 24),
                AppBorderFrame(
                  labelText: Keystring.SALARY.tr,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.ARGEEMENT.tr,
                            style: textNormal,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Switch(
                            value: salaryActive,
                            activeColor: appPrimaryColor,
                            inactiveThumbColor: appPrimaryColor,
                            onChanged: (bool value) {
                              isBanned
                                  ? null
                                  : ref.read(jobSalaryProvider.notifier).state =
                                      value;
                            },
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.DISARGEEMENT.tr,
                            style: textNormal,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                      salaryActive ? SizedBox(height: 16) : SizedBox(height: 0),
                      salaryActive
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: EditTextFormWithSuffixIcon(
                                    typeKeyboard: TextInputType.number,
                                    onChanged: ((value) {
                                      ref
                                          .read(jobMinSalaryProvider.notifier)
                                          .state = int.parse(value);
                                    }),
                                    suffixIcon: Transform.rotate(
                                      angle: 180 * 3.14 / 180,
                                      child: Icon(
                                        Icons.currency_ruble_rounded,
                                        size: 14,
                                      ),
                                    ),
                                    content: job?.minSalary == null
                                        ? ''
                                        : job?.minSalary.toString() ?? '',
                                    label: Keystring.MIN_SALARY.tr,
                                    readOnly: isBanned,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: EditTextFormWithSuffixIcon(
                                    typeKeyboard: TextInputType.number,
                                    onChanged: ((value) {
                                      ref
                                          .read(jobMaxSalaryProvider.notifier)
                                          .state = int.parse(value);
                                    }),
                                    suffixIcon: Transform.rotate(
                                      angle: 180 * 3.14 / 180,
                                      child: Icon(
                                        Icons.currency_ruble_rounded,
                                        size: 14,
                                      ),
                                    ),
                                    content: job?.maxSalary == null
                                        ? ''
                                        : job?.maxSalary.toString() ?? '',
                                    label: Keystring.MAX_SALARY.tr,
                                    readOnly: isBanned,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(height: 0),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: EditTextForm(
                        onChanged: ((value) {
                          ref.read(jobYearExperienceProvider.notifier).state =
                              int.parse(value);
                        }),
                        label: Keystring.Year_Experience.tr,
                        content: job?.yearExperience == null
                            ? ''
                            : job?.yearExperience.toString() ?? '',
                        readOnly: isBanned,
                      ),
                    ),
                    SizedBox(width: 8),
                    AppBorderFrame(
                      labelText: Keystring.Type_Job.tr,
                      child: dropJobType(),
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: EditTextForm(
                        onChanged: ((value) {
                          ref.read(jobNumberCandidateProvider.notifier).state =
                              int.parse(value);
                        }),
                        label: Keystring.Number_Candidate.tr,
                        content: job?.numberCandidate == null
                            ? ''
                            : job?.numberCandidate.toString() ?? '',
                        readOnly: isBanned,
                      ),
                    ),
                  ],
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
                      SizedBox(
                        height: 20,
                      ),
                      AppBorderFrame(
                        labelText: Keystring.DISTRICT.tr,
                        child: dropDistrict(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                AppBorderFrame(
                  labelText: Keystring.Job_Detail.tr,
                  child: Column(
                    children: [
                      EditTextForm(
                        onChanged: ((value) {
                          ref.read(jobDescriptionProvider.notifier).state =
                              value;
                        }),
                        label: Keystring.DESCRIPTION.tr,
                        height: 120,
                        content: job?.description ?? '',
                        maxLines: 4,
                        readOnly: isBanned,
                      ),
                      SizedBox(height: 20),
                      EditTextForm(
                        onChanged: ((value) {
                          ref
                              .read(jobCandidateRequirementProvider.notifier)
                              .state = value;
                        }),
                        label: Keystring.Candidate_Requirement.tr,
                        height: 120,
                        content: job?.candidateRequirement ?? '',
                        maxLines: 4,
                        readOnly: isBanned,
                      ),
                      SizedBox(height: 20),
                      EditTextForm(
                        onChanged: ((value) {
                          ref.read(jobBenefitProvider.notifier).state = value;
                        }),
                        label: Keystring.Job_Benefit.tr,
                        height: 120,
                        content: job?.jobBenefit ?? '',
                        maxLines: 4,
                        readOnly: isBanned,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                AppBorderFrame(
                  labelText: Keystring.Tag.tr,
                  child: Column(
                    children: [
                      AppAutocompleteEditText(
                        listSuggestion: listTitleJob,
                        onSelected: (value) {
                          if (!listJob.any((x) => x == value)) {
                            ref
                                .read(listJobTagProviderProvider.notifier)
                                .state = [...listJob, value];
                            // listEducationShowData.sort((a, b) => a.id!.compareTo(b.id!));
                          }
                        },
                        readOnly: isBanned,
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
                                        isBanned
                                            ? SizedBox(width: 0)
                                            : InkWell(
                                                child:
                                                    Icon(Icons.delete_outlined),
                                                onTap: () {
                                                  if (listJob.isNotEmpty) {
                                                    ref
                                                        .read(
                                                            listJobTagProviderProvider
                                                                .notifier)
                                                        .state = [
                                                      for (final value
                                                          in listJob)
                                                        if (value !=
                                                            listJob[index])
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
                SizedBox(height: 24),
                AppBorderFrame(
                  labelText: Keystring.Deadline.tr,
                  child: DateCustomDialog()
                      .jobDate(context, ref, jobDeadline, isBanned),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Colors.black45,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        Keystring.ACTIVE.tr,
                        style: textNormal,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Switch(
                        value: jobActive == 1 ? true : false,
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        onChanged: (bool value) {
                          if (isBanned) {
                            null;
                          } else {
                            if (value) {
                              ref.read(jobActiveProvider.notifier).state = 1;
                            } else {
                              ref.read(jobActiveProvider.notifier).state = 0;
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                AppButton(
                  onPressed: () {
                    if (salaryActive == false) {
                      ref.read(jobMinSalaryProvider.notifier).state = -1;
                      ref.read(jobMaxSalaryProvider.notifier).state = -1;
                      doneButton();
                    } else {
                      doneButton();
                    }
                  },
                  disableBtn: isBanned,
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
