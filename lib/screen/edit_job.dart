import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';

import '../blocs/app_controller.dart';
import '../blocs/app_event.dart';
import '../blocs/app_riverpod_object.dart';
import '../component/app_button.dart';
import '../component/date_dialog.dart';
import '../component/edittext.dart';
import '../component/loader_overlay.dart';
import '../model/address.dart';
import '../model/userprofile.dart';
import '../value/keystring.dart';
import '../value/style.dart';
import 'home.dart';

class JobEditScreen extends ConsumerWidget {
  const JobEditScreen({super.key, this.edit = false});

  final bool edit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String filePath = '';
    CurrencyList? vndCurrency;

    final user = ref.watch(userLoginProvider);
    final company = ref.watch(companyProfileProvider);
    final job = ref.watch(jobDetailProvider);

    final listProvinceData = ref.watch(listProvinceProvider);
    final listDistrictData = ref.watch(listDistrictProvider);
    final listCurrencyData = ref.watch(listCurrencyProvider);

    final provinceChoose = ref.watch(provinceJobProvider);
    final districtChoose = ref.watch(districtJobProvider);
    final currencyChoose = ref.watch(jobCurrencyProvider);
    final jobTypeChoose = ref.watch(jobTypeChooseProvider);

    final jobDeadline = ref.watch(jobDeadlineProvider);
    final jobActive = ref.watch(jobActiveProvider);
    final salaryActive = ref.watch(jobSalaryProvider);

    List<ProvinceList> listProvince = [];
    List<DistrictList> listDistrict = [];
    List<CurrencyList> listCurrency = [];
    List<String> listJobType = [
      Keystring.INTERN.tr,
      Keystring.PART_TIME.tr,
      Keystring.FULL_TIME.tr
    ];

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

    listCurrencyData.when(
      data: (_data) {
        listCurrency.addAll(_data);
        listCurrency.sort((a, b) => a.code!.compareTo(b.code!));

        for (var i in _data) {
          if (i.code == 'VND') vndCurrency = i;
        }
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
          onChanged: (value) {
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

    DropdownButtonHideUnderline dropCurrency() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: listCurrency
              .map((item) => DropdownMenuItem<CurrencyList>(
                    value: item,
                    child: Text('${item.symbol ?? ''}  ${item.code ?? ''}',
                        style: textNormal),
                  ))
              .toList(),
          value: currencyChoose?.code != null ? currencyChoose : null,
          onChanged: (value) {
            ref.read(jobCurrencyProvider.notifier).state = value;
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
          onChanged: (value) {
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

//void
    void doneButton() {
      log('${company!.uid} + ${ref.watch(jobNameProvider)} + ${ref.watch(jobMinSalaryProvider)} + ${ref.watch(jobMaxSalaryProvider)} + ${currencyChoose!.code} + ${provinceChoose!.code} + ${districtChoose!.code} + ${ref.watch(jobYearExperienceProvider)}  + ${jobTypeChoose!} + ${ref.watch(jobNumberCandidateProvider)}  + ${ref.watch(jobDescriptionProvider)} + ${ref.watch(jobCandidateRequirementProvider)} + ${ref.watch(jobBenefitProvider)} + ${ref.watch(jobTagProvider)} + ${jobDeadline}');
      if (ref.watch(jobNameProvider).isNotEmpty &&
          !ref.watch(jobMinSalaryProvider).isNaN &&
          !ref.watch(jobMaxSalaryProvider).isNaN &&
          currencyChoose.code != null &&
          !ref.watch(jobYearExperienceProvider).isNaN &&
          jobTypeChoose != null &&
          !ref.watch(jobNumberCandidateProvider).isNaN &&
          provinceChoose.code != null &&
          districtChoose.code != null &&
          ref.watch(jobDescriptionProvider).isNotEmpty &&
          ref.watch(jobCandidateRequirementProvider).isNotEmpty &&
          ref.watch(jobBenefitProvider).isNotEmpty &&
          ref.watch(jobTagProvider).isNotEmpty &&
          jobDeadline.isNotEmpty) {
        if (!edit) {
          log("click done");

          ref.read(LoginControllerProvider.notifier).createJob(
                ref.watch(jobNameProvider),
                company.uid ?? '0',
                ref.watch(jobMinSalaryProvider),
                ref.watch(jobMaxSalaryProvider),
                currencyChoose.code ?? '',
                ref.watch(jobYearExperienceProvider),
                jobTypeChoose,
                ref.watch(jobNumberCandidateProvider),
                '${districtChoose.code},${provinceChoose.code}',
                ref.watch(jobDescriptionProvider),
                ref.watch(jobCandidateRequirementProvider),
                ref.watch(jobBenefitProvider),
                ref.watch(jobTagProvider),
                jobDeadline,
                jobActive ? 1 : 0,
              );
        } else {
          log("click update");
          ref.read(LoginControllerProvider.notifier).updateJob(
                job!.code ?? '0',
                ref.watch(jobNameProvider),
                company.uid ?? '0',
                ref.watch(jobMinSalaryProvider),
                ref.watch(jobMaxSalaryProvider),
                currencyChoose.code ?? '',
                ref.watch(jobYearExperienceProvider),
                jobTypeChoose,
                ref.watch(jobNumberCandidateProvider),
                '${districtChoose.code},${provinceChoose.code}',
                ref.watch(jobDescriptionProvider),
                ref.watch(jobCandidateRequirementProvider),
                ref.watch(jobBenefitProvider),
                ref.watch(jobTagProvider),
                jobDeadline,
                jobActive ? 1 : 0,
              );
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
          ref.refresh(listPostJobProvider.future);
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

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: bgGradientColor),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32),
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
                            ref.read(jobSalaryProvider.notifier).state = value;
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
                                child: EditTextForm(
                                  typeKeyboard: TextInputType.number,
                                  onChanged: ((value) {
                                    ref
                                        .read(jobMinSalaryProvider.notifier)
                                        .state = int.parse(value);
                                  }),
                                  content: job?.minSalary == null
                                      ? ''
                                      : job?.minSalary.toString() ?? '',
                                  label: Keystring.MIN_SALARY.tr,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: EditTextForm(
                                  typeKeyboard: TextInputType.number,
                                  onChanged: ((value) {
                                    ref
                                        .read(jobMaxSalaryProvider.notifier)
                                        .state = int.parse(value);
                                  }),
                                  content: job?.maxSalary == null
                                      ? ''
                                      : job?.maxSalary.toString() ?? '',
                                  label: Keystring.MAX_SALARY.tr,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: AppBorderFrame(
                                  labelText: Keystring.CURRENCY.tr,
                                  child: dropCurrency(),
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
                        ref.read(jobDescriptionProvider.notifier).state = value;
                      }),
                      label: Keystring.DESCRIPTION.tr,
                      height: 120,
                      content: job?.description ?? '',
                      maxLines: 4,
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(jobTagProvider.notifier).state = value;
                }),
                label: Keystring.Tag.tr,
                content: job?.tag ?? '',
              ),
              SizedBox(height: 24),
              AppBorderFrame(
                labelText: Keystring.Deadline.tr,
                child: DateCustomDialog().jobDate(context, ref, jobDeadline),
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
                      value: jobActive,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (bool value) {
                        ref.read(jobActiveProvider.notifier).state = value;
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
                    ref.read(jobCurrencyProvider.notifier).state = vndCurrency;
                    doneButton();
                  } else {
                    doneButton();
                  }
                },
                bgColor: appPrimaryColor,
                height: 64,
                content: edit ? Keystring.UPDATE.tr : Keystring.DONE.tr,
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
