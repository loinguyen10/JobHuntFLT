import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/component/edittext.dart';

import '../../blocs/app_riverpod_object.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import 'application_view_screen.dart';

class AllAppicationRecuiterScreen extends ConsumerWidget {
  const AllAppicationRecuiterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _data = ref.watch(listRecuiterApplicationProvider);

    final statusCheck = ref.watch(StatusCheckProvider);

    if (statusCheck == '') _data = ref.watch(listRecuiterApplicationProvider);
    if (statusCheck == 'waiting') {
      _data = ref.watch(listRecuiterWaitingApplicationProvider);
    }
    if (statusCheck == 'apporve') {
      _data = ref.watch(listRecuiterApporveApplicationProvider);
    }
    if (statusCheck == 'reject') {
      _data = ref.watch(listRecuiterRejectApplicationProvider);
    }

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: EditTextForm(
                      onChanged: (value) {
                        //
                      },
                      label: Keystring.SEARCH.tr,
                      hintText: Keystring.SEARCH.tr,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AppButton(
                    onPressed: () {
                      //
                    },
                    label: Keystring.SEARCH.tr,
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (statusCheck == 'waiting') {
                        ref.invalidate(StatusCheckProvider);
                      } else {
                        ref.read(StatusCheckProvider.notifier).state =
                            'waiting';
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 4),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.grey,
                      ),
                      child: Text(
                        Keystring.WAITING.tr,
                        textAlign: TextAlign.center,
                        style: statusCheck == 'waiting'
                            ? textStatus2View
                            : textStatusView,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (statusCheck == 'apporve') {
                        ref.invalidate(StatusCheckProvider);
                      } else {
                        ref.read(StatusCheckProvider.notifier).state =
                            'apporve';
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 4),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.green,
                      ),
                      child: Text(
                        Keystring.APPORVE.tr,
                        textAlign: TextAlign.center,
                        style: statusCheck == 'apporve'
                            ? textStatus2View
                            : textStatusView,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (statusCheck == 'reject') {
                        ref.invalidate(StatusCheckProvider);
                      } else {
                        ref.read(StatusCheckProvider.notifier).state = 'reject';
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 4),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.red,
                      ),
                      child: Text(
                        Keystring.REJECT.tr,
                        textAlign: TextAlign.center,
                        style: statusCheck == 'reject'
                            ? textStatus2View
                            : textStatusView,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  _data.when(
                    data: (data) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          String name = data[index].job!.name ?? '';
                          String company =
                              data[index].job!.company!.fullname ?? '';
                          String apporve = data[index].apporve ?? '';
                          String sentTime = data[index].sendTime ?? '';
                          String interviewTime =
                              data[index].interviewTime ?? '';
                          String time = apporve.isEmpty
                              ? sentTime
                              : data[index].apporveTime ?? '';

                          return Container(
                            decoration: BoxDecoration(
                                color: apporve == ''
                                    ? Colors.white
                                    : const Color.fromARGB(160, 158, 158, 158),
                                border: Border.all(
                                  width: 1,
                                  color: apporve == ''
                                      ? Colors.grey
                                      : Colors.black,
                                )),
                            child: ExpansionTile(
                              textColor: apporve == ''
                                  ? Colors.black
                                  : apporve == '1'
                                      ? Color.fromARGB(255, 0, 150, 0)
                                      : Color.fromARGB(255, 255, 0, 0),
                              collapsedTextColor: apporve == ''
                                  ? Colors.black
                                  : apporve == '1'
                                      ? Color.fromARGB(255, 0, 150, 0)
                                      : Color.fromARGB(255, 255, 0, 0),
                              tilePadding:
                                  EdgeInsets.only(left: 16, top: 2, bottom: 2),
                              childrenPadding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 6, vertical: 12),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 13,
                                    child: Text(
                                      (index + 1).toString(),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Text(
                                      time,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Icon(null),
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          child: Text(
                                            '${Keystring.COMPANY.tr}: ${company.toUpperCase()}',
                                            style: textNormal,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                            '${Keystring.SENT_TIME.tr}: ${sentTime}',
                                            textAlign: TextAlign.right,
                                            style: textNormal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${Keystring.STATUS.tr}:',
                                              style: textNormal,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              apporve == ''
                                                  ? Keystring.WAITING.tr
                                                      .toUpperCase()
                                                  : apporve == '1'
                                                      ? Keystring.APPORVE.tr
                                                          .toUpperCase()
                                                      : Keystring.REJECT.tr
                                                          .toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: apporve == ''
                                                    ? Colors.black
                                                    : apporve == '1'
                                                        ? Color.fromARGB(
                                                            255, 0, 150, 0)
                                                        : Color.fromARGB(
                                                            255, 255, 0, 0),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: interviewTime.isEmpty
                                              ? Text('')
                                              : Text(
                                                  '${Keystring.INTERVIEW_TIME.tr}: ${interviewTime}',
                                                  textAlign: TextAlign.right,
                                                  style: textNormal,
                                                ),
                                        ),
                                      ],
                                    ),
                                    AppButton(
                                        onPressed: () {
                                          ref
                                              .read(applicationDetailProvider
                                                  .notifier)
                                              .state = data[index];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ApplicationViewFullScreen()),
                                          );
                                        },
                                        label: Keystring.DETAIL.tr)
                                  ],
                                )
                              ],
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
          ],
        ),
      ),
    );
  }
}

//
class ApplicationTodayRecuiterScreen extends ConsumerStatefulWidget {
  const ApplicationTodayRecuiterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApplicationTodayRecuiterScreenState();
}

class _ApplicationTodayRecuiterScreenState
    extends ConsumerState<ApplicationTodayRecuiterScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(listRecuiterTodayApplicationProvider);

    // if (ref.watch(userLoginProvider) != null &&
    //     ref.watch(userLoginProvider)!.role == 'recuiter') {
    //   Timer.periodic(Duration(seconds: 15), (Timer t) {
    //     ref.invalidate(listRecuiterApplicationProvider);
    //     log('refresh ne');
    //   });
    // }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  Keystring.CANDIDATE.tr,
                  textAlign: TextAlign.center,
                  style: textNormalBold,
                ),
              ),
              Expanded(
                child: Text(
                  Keystring.Name_Job.tr,
                  textAlign: TextAlign.center,
                  style: textNormalBold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  Keystring.SENT_TIME.tr,
                  textAlign: TextAlign.center,
                  style: textNormalBold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        data.when(
          skipLoadingOnRefresh: true,
          data: (data) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                String name = data[index].job!.name ?? '';
                String nameCandidate = data[index].candidate!.fullName ?? '';
                String sentTime = data[index].sendTime ?? '';

                return Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      ref.read(applicationDetailProvider.notifier).state =
                          data[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplicationViewFullScreen()),
                      );
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                            nameCandidate,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                            sentTime,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
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
        data.value?.length == 0
            ? SizedBox(
                height: 160,
                child: Center(
                  child: Text(Keystring.NO_DATA.tr),
                ),
              )
            : SizedBox(height: 0),
      ],
    );
  }
}
