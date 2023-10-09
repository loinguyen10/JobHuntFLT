import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/card.dart';

import '../../value/keystring.dart';
import '../../value/style.dart';
import '../job/job_view_screen.dart';

class YourJobStatusScreen extends ConsumerWidget {
  const YourJobStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _data = ref.watch(listCandidateApplicationProvider);

    final statusCheck = ref.watch(StatusCheckProvider);

    if (statusCheck == '') _data = ref.watch(listCandidateApplicationProvider);
    if (statusCheck == 'waiting') {
      _data = ref.watch(listCandidateWaitingApplicationProvider);
    }
    if (statusCheck == 'apporve') {
      _data = ref.watch(listCandidateApporveApplicationProvider);
    }
    if (statusCheck == 'reject') {
      _data = ref.watch(listCandidateRejectApplicationProvider);
    }

    return SafeArea(
      child: Container(
          color: bgPrimaryColor,
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.YOUR_JOB_STATUS.tr),
                backgroundColor: bgPrimaryColor,
                elevation: 0,
                foregroundColor: Colors.black,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (statusCheck == 'waiting') {
                          ref.refresh(StatusCheckProvider);
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
                          ref.refresh(StatusCheckProvider);
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
                          ref.refresh(StatusCheckProvider);
                        } else {
                          ref.read(StatusCheckProvider.notifier).state =
                              'reject';
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
              _data.when(
                data: (data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      String name = data[index].job!.name ?? '';
                      String company = data[index].job!.company!.fullname ?? '';
                      String apporve = data[index].apporve ?? '';
                      String sentTime = data[index].sendTime ?? '';
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
                              color: apporve == '' ? Colors.grey : Colors.black,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 13,
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
                                width: MediaQuery.of(context).size.width / 4,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: Text(
                                        '${Keystring.COMPANY.tr}: ${company.toUpperCase()}',
                                        style: textNormal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
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
                                  children: [
                                    Text(
                                      '${Keystring.STATUS.tr}:',
                                      style: textNormal,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      apporve == ''
                                          ? Keystring.WAITING.tr.toUpperCase()
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
                                                ? Color.fromARGB(255, 0, 150, 0)
                                                : Color.fromARGB(
                                                    255, 255, 0, 0),
                                      ),
                                    )
                                  ],
                                )
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
          )),
    );
  }
}

class YourJobSavedScreen extends ConsumerWidget {
  const YourJobSavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listYourFavoriteProvider);

    return SafeArea(
      child: Container(
        color: bgPrimaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.YOUR_JOB_SAVED.tr),
                backgroundColor: bgPrimaryColor,
                elevation: 0,
                foregroundColor: Colors.black,
              ),
              SizedBox(height: 16),
              _data.when(
                data: (data) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      String avatar = data[index].job!.company!.avatarUrl ?? '';
                      String name = data[index].job!.name ?? '';
                      String nameCompany =
                          data[index].job!.company!.fullname ?? '';
                      String? deadline = data[index].job!.deadline ?? '';
                      String? money = data[index].job!.maxSalary != -1
                          ? '${data[index].job!.maxSalary} ${data[index].job!.currency}'
                          : Keystring.ARGEEMENT.tr;
                      bool active = data[index].job!.active == 1 ? true : false;

                      return Card(
                        shadowColor: Colors.black,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () {
                            ref.read(jobDetailProvider.notifier).state =
                                data[index].job!;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobViewScreen()));
                          },
                          child: AppFavoriteCard(
                            avatar: avatar,
                            name: name,
                            nameCompany: nameCompany,
                            deadline: deadline,
                            money: money,
                            bgColor: active
                                ? Colors.white
                                : Color.fromARGB(123, 123, 123, 123),
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
            ],
          ),
        ),
      ),
    );
  }
}