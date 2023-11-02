import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/app_autocomplete.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:jobhunt_ftl/value/style.dart';

import '../../component/edittext.dart';

class JobRecommendSettingScreen extends ConsumerWidget {
  const JobRecommendSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _gender = ref.watch(genderJobSetting);
    final listS = <String>['aardvark', 'bobcat', 'chameleon'];
    final listJob = ref.watch(listJob2Setting);
    final listSkill = ref.watch(listSkillJobSetting);

    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Keystring.JOB_RECOMMEND_SETTING.tr),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: 'Gender',
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Male'),
                          leading: Radio(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: 'Male',
                            groupValue: _gender,
                            onChanged: (value) {
                              ref.read(genderJobSetting.notifier).state =
                                  value!;
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('Female'),
                          leading: Radio(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: 'Female',
                            groupValue: _gender,
                            onChanged: (value) {
                              ref.read(genderJobSetting.notifier).state =
                                  value!;
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('Null'),
                          leading: Radio(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: 'Null',
                            groupValue: _gender,
                            onChanged: (value) {
                              ref.read(genderJobSetting.notifier).state =
                                  value!;
                            },
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 16),
                EditTextForm(
                  onChanged: ((value) {
                    //
                  }),
                  label: 'Position',
                ),
                SizedBox(height: 16),
                AppBorderFrame(
                  labelText: 'Job',
                  child: Column(
                    children: [
                      AppAutocompleteEditText(
                        borderSelected: Colors.transparent,
                        listSuggestion: listS,
                        onSelected: (value) {
                          if (!listJob.any((x) => x == value)) {
                            ref.read(listJob2Setting.notifier).state = [
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
                                        Text(
                                          listJob[index],
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                        ),
                                        InkWell(
                                          child: Icon(Icons.delete_outlined),
                                          onTap: () {
                                            //
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
                  labelText: 'Skill',
                  child: Column(
                    children: [
                      AppAutocompleteEditText(
                        borderSelected: Colors.transparent,
                        listSuggestion: listS,
                        onSelected: (value) {
                          if (!listSkill.any((x) => x == value)) {
                            ref.read(listSkillJobSetting.notifier).state = [
                              ...listSkill,
                              value
                            ];
                            // listEducationShowData.sort((a, b) => a.id!.compareTo(b.id!));
                          }
                        },
                      ),
                      listSkill.isNotEmpty
                          ? SizedBox(height: 16)
                          : SizedBox(height: 0),
                      listSkill.isNotEmpty
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
                                          listSkill[index],
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                        ),
                                        InkWell(
                                          child: Icon(Icons.delete_outlined),
                                          onTap: () {
                                            //
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: listSkill.length,
                            )
                          : SizedBox(height: 0),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: 'Expericement',
                    child: Column(
                      children: [
                        //
                      ],
                    )),
                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: 'Payment',
                    child: Column(
                      children: [
                        //
                      ],
                    )),
                SizedBox(height: 16),
                AppBorderFrame(
                    labelText: 'Place',
                    child: Column(
                      children: [
                        //
                      ],
                    )),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
