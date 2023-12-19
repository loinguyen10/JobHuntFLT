import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/app_autocomplete.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:jobhunt_ftl/value/style.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../component/edittext.dart';
import '../../component/loader_overlay.dart';
import '../../model/address.dart';
import '../../model/job_setting.dart';

class JobRecommendSettingScreen extends ConsumerWidget {
  const JobRecommendSettingScreen({super.key, this.edit = false});
  final bool edit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(userDetailJobSettingProvider);

    // final currencyChoose = ref.watch(currencyChooseJobSettingProvider);
    final provinceChoose = ref.watch(provinceChooseJobSettingProvider);


    // final _gender = ref.watch(genderJobSettingProvider);
    final listJob = ref.watch(listJob2SettingProvider);
    final listProvinceChoose = ref.watch(listProvinceChooseJobSettingProvider);

    final listCurrencyData = ref.watch(listCurrencyProvider);
    final listProvinceData = ref.watch(listProvinceProvider);

    final listAllTitleJobData = ref.watch(listAllTitleJobSettingProvider);


    List<CurrencyList> listCurrency = [];
    List<ProvinceList> listProvince = [];

    List<String> listTitleJob = [];

    listCurrencyData.when(
      data: (_data) {
        listCurrency.addAll(_data);
        listCurrency.sort((a, b) => a.code!.compareTo(b.code!));
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    listProvinceData.when(
      data: (_data) {
        listProvince.addAll(_data);
        listProvince.sort((a, b) => a.name!.compareTo(b.name!));
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

    // DropdownButtonHideUnderline dropCurrency() {
    //   return DropdownButtonHideUnderline(
    //     child: DropdownButton2(
    //       isExpanded: true,
    //       hint: Text(
    //         Keystring.SELECT.tr,
    //         style: textNormal,
    //       ),
    //       items: listCurrency
    //           .map((item) => DropdownMenuItem<CurrencyList>(
    //                 value: item,
    //                 child: Text('${item.symbol ?? ''}  ${item.code ?? ''}',
    //                     style: textNormal),
    //               ))
    //           .toList(),
    //       value: currencyChoose?.code != null ? currencyChoose : null,
    //       onChanged: (value) {
    //         ref.read(currencyChooseJobSettingProvider.notifier).state = value;
    //       },
    //       buttonStyleData: dropDownButtonStyle1,
    //       menuItemStyleData: const MenuItemStyleData(
    //         height: 40,
    //       ),
    //     ),
    //   );
    // }

    DropdownButtonHideUnderline dropProvince() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.height / 2.5),
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
            ref.read(provinceChooseJobSettingProvider.notifier).state = value;
            if (!listProvinceChoose.any((x) => x == value)) {
              ref.read(listProvinceChooseJobSettingProvider.notifier).state = [
                ...listProvinceChoose,
                value!
              ];
            }
            log('Province: ${value?.code}');
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

        if (state is CreateThingSuccessEvent ||
            state is UpdateThingSuccessEvent) {
          Loader.hide();
          log('c-success');
          // ref.refresh(listPostJobProvider.future);
          // ref.refresh(listJobProvider.future);
          Navigator.pop(context);
        }

        if (state is CreateThingLoadingEvent ||
            state is UpdateThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    void done() {
      String job = '';

      String provinceId = '';

      for (var y in listJob) {
        if (!listTitleJob.any((x) => x == y)) {
          log('message title: $y');
          ref.read(LoginControllerProvider.notifier).createJobTitle(y);
        }
        job += '$y,';
      }



      for (var y in listProvinceChoose) {
        provinceId += '${y.code},';
      }

      if (edit) {
        ref.read(LoginControllerProvider.notifier).updateJobRecommendSetting(
              ref.watch(userLoginProvider)!.uid ?? '',
              job.substring(0, job.length - 1),

              ref.watch(yearExpericementJobSettingProvider),
              provinceId.substring(0, provinceId.length - 1),
              ref.watch(minSalaryJobSettingProvider),
              ref.watch(maxSalaryJobSettingProvider),
            );
      } else {
        ref.read(LoginControllerProvider.notifier).createJobRecommendSetting(
              ref.watch(userLoginProvider)!.uid ?? '',
              job.substring(0, job.length - 1),
              ref.watch(yearExpericementJobSettingProvider),
              provinceId.substring(0, provinceId.length - 1),
              ref.watch(minSalaryJobSettingProvider),
              ref.watch(maxSalaryJobSettingProvider),
              // currencyChoose?.code ?? '',
            );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Keystring.JOB_RECOMMEND_SETTING.tr),
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
                SizedBox(height: 16),
                // AppBorderFrame(
                //     labelText: Keystring.GENDER.tr,
                //     child: Column(
                //       children: [
                //         ListTile(
                //           title: Text(Keystring.MALE.tr),
                //           leading: Radio(
                //             activeColor: Theme.of(context).colorScheme.primary,
                //             value: 'Male',
                //             groupValue: _gender,
                //             onChanged: (value) {
                //               ref
                //                   .read(genderJobSettingProvider.notifier)
                //                   .state = value!;
                //             },
                //           ),
                //         ),
                //         ListTile(
                //           title: Text(Keystring.FEMALE.tr),
                //           leading: Radio(
                //             activeColor: Theme.of(context).colorScheme.primary,
                //             value: 'Female',
                //             groupValue: _gender,
                //             onChanged: (value) {
                //               ref
                //                   .read(genderJobSettingProvider.notifier)
                //                   .state = value!;
                //             },
                //           ),
                //         ),
                //         ListTile(
                //           title: Text(Keystring.OTHER.tr),
                //           leading: Radio(
                //             activeColor: Theme.of(context).colorScheme.primary,
                //             value: 'Other',
                //             groupValue: _gender,
                //             onChanged: (value) {
                //               ref
                //                   .read(genderJobSettingProvider.notifier)
                //                   .state = value!;
                //             },
                //           ),
                //         ),
                //       ],
                //     )),
                // SizedBox(height: 16),
                AppBorderFrame(
                  labelText: Keystring.WANT_JOB.tr,
                  child: Column(
                    children: [
                      AppAutocompleteEditText(
                        listSuggestion: listTitleJob,
                        onSelected: (value) {
                          if (!listJob.any((x) => x == value)) {
                            ref.read(listJob2SettingProvider.notifier).state = [
                              ...listJob,
                              value
                            ];
                            // listEducationShowData.sort((a, b) => a.id!.compareTo(b.id!));
                          }
                        },
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
                                        InkWell(
                                          child: Icon(Icons.delete_outlined),
                                          onTap: () {
                                            if (listJob.isNotEmpty) {
                                              ref
                                                  .read(listJob2SettingProvider
                                                      .notifier)
                                                  .state = [
                                                for (final value in listJob)
                                                  if (value != listJob[index])
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


                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: Keystring.Year_Experience.tr,
                    child: Row(
                      children: [
                        SizedBox(width: 16),
                        Text(Keystring.LESS_THAN.tr, style: textNormal),
                        SizedBox(width: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 8,
                          child: EditTextForm(
                            typeKeyboard: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: ((value) {
                              ref
                                  .read(yearExpericementJobSettingProvider
                                      .notifier)
                                  .state = int.parse(value);
                            }),
                            content: setting?.yearExperience.toString() ?? '',
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(Keystring.YEAR.tr, style: textNormal),
                      ],
                    )),
                SizedBox(height: 16),
                AppBorderFrame(
                  labelText: Keystring.SALARY.tr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: EditTextFormWithSuffixIcon(
                          typeKeyboard: TextInputType.number,
                          onChanged: ((value) {
                            ref
                                .read(minSalaryJobSettingProvider.notifier)
                                .state = int.parse(value);
                          }),
                          suffixIcon: Transform.rotate(
                            angle: 180 * 3.14 / 180,
                            child: Icon(
                              Icons.currency_ruble_rounded,
                              size: 14,
                            ),
                          ),
                          content: setting?.minSalary.toString() ?? '',
                          label: Keystring.MIN_SALARY.tr,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: EditTextFormWithSuffixIcon(
                          typeKeyboard: TextInputType.number,
                          onChanged: ((value) {
                            ref
                                .read(maxSalaryJobSettingProvider.notifier)
                                .state = int.parse(value);
                          }),
                          suffixIcon: Transform.rotate(
                            angle: 180 * 3.14 / 180,
                            child: Icon(
                              Icons.currency_ruble_rounded,
                              size: 14,
                            ),
                          ),
                          content: setting?.maxSalary.toString() ?? '',
                          label: Keystring.MAX_SALARY.tr,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: Keystring.PLACE_JOB.tr,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: dropProvince(),
                        ),
                        listProvinceChoose.isNotEmpty
                            ? SizedBox(height: 16)
                            : SizedBox(height: 0),
                        listProvinceChoose.isNotEmpty
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
                                          Text(
                                            listProvinceChoose[index].name ??
                                                '',
                                            overflow: TextOverflow.fade,
                                            maxLines: 3,
                                          ),
                                          InkWell(
                                            child: Icon(Icons.delete_outlined),
                                            onTap: () {
                                              if (listProvinceChoose
                                                  .isNotEmpty) {
                                                ref
                                                    .read(
                                                        listProvinceChooseJobSettingProvider
                                                            .notifier)
                                                    .state = [
                                                  for (final value
                                                      in listProvinceChoose)
                                                    if (value !=
                                                        listProvinceChoose[
                                                            index])
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
                                itemCount: listProvinceChoose.length,
                              )
                            : SizedBox(height: 0),
                      ],
                    )),
                SizedBox(height: 32),
                AppButton(
                  onPressed: () {
                    if (listJob.isEmpty ||

                        listProvinceChoose.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "File is blank.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      done();
                    }
                  },
                  label: Keystring.DONE.tr,
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
