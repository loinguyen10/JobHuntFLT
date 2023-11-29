import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/component/app_small_button.dart';
import 'package:jobhunt_ftl/component/edittext.dart';

import '../../blocs/app_riverpod_object.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import 'application_view_screen.dart';

class AllAppicationRecuiterScreen extends ConsumerWidget {
  const AllAppicationRecuiterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizePhone = MediaQuery.of(context).size;
    var _data = ref.watch(listRecuiterApplicationProvider);

    final statusCheck = ref.watch(StatusCheckProvider);

    if (statusCheck == '') _data = ref.watch(listRecuiterApplicationProvider);
    if (statusCheck == 'waiting') {
      _data = ref.watch(listRecuiterWaitingApplicationProvider);
    }
    if (statusCheck == 'approve') {
      _data = ref.watch(listRecuiterApproveApplicationProvider);
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
                    width: sizePhone.width / 10,
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
                      if (statusCheck == 'approve') {
                        ref.invalidate(StatusCheckProvider);
                      } else {
                        ref.read(StatusCheckProvider.notifier).state =
                            'approve';
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
                        Keystring.APPROVE.tr,
                        textAlign: TextAlign.center,
                        style: statusCheck == 'approve'
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
            Expanded(
              child: SingleChildScrollView(
                child: _data.when(
                  data: (data) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        String avatarCompany =
                            data[index].job!.company!.avatarUrl ?? '';
                        String name = data[index].job!.name ?? '';
                        String company =
                            data[index].job!.company!.fullname ?? '';
                        String approve = data[index].approve ?? '';
                        String sentTime = data[index].sendTime ?? '';
                        String interviewTime = data[index].interviewTime ?? '';
                        String time = approve.isEmpty
                            ? sentTime
                            : data[index].approveTime ?? '';

                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              color: approve == ''
                                  ? Colors.white
                                  : approve == '1'
                                      ? Color.fromARGB(75, 0, 150, 0)
                                      : Color.fromARGB(75, 255, 0, 0),
                              border: Border.all(
                                width: 1,
                                color:
                                    approve == '' ? Colors.grey : Colors.black,
                              )),
                          child: ExpansionTile(
                            textColor: approve == ''
                                ? Colors.black
                                : approve == '1'
                                    ? Color.fromARGB(255, 0, 150, 0)
                                    : Color.fromARGB(255, 255, 0, 0),
                            collapsedTextColor: approve == ''
                                ? Colors.black
                                : approve == '1'
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
                                  width: sizePhone.width / 13,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(16),
                                      child: avatarCompany.isNotEmpty
                                          ? Image.network(avatarCompany,
                                              fit: BoxFit.cover)
                                          : Icon(
                                              Icons.apartment,
                                              size: 32,
                                            ),
                                    ),
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
                                  width: sizePhone.width / 4,
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
                                        width: sizePhone.width / 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${Keystring.COMPANY.tr}:',
                                              style: textNormal.copyWith(
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            Text(
                                              company.toUpperCase(),
                                              style: textNormalBold,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: sizePhone.width / 2.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${Keystring.SENT_TIME.tr}:',
                                              style: textNormal.copyWith(
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            Text(
                                              sentTime.toUpperCase(),
                                              style: textNormalBold,
                                            ),
                                          ],
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
                                            approve == ''
                                                ? Keystring.WAITING.tr
                                                    .toUpperCase()
                                                : approve == '1'
                                                    ? Keystring.APPROVE.tr
                                                        .toUpperCase()
                                                    : Keystring.REJECT.tr
                                                        .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: approve == ''
                                                  ? Colors.black
                                                  : approve == '1'
                                                      ? Color.fromARGB(
                                                          255, 0, 150, 0)
                                                      : Color.fromARGB(
                                                          255, 255, 0, 0),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: sizePhone.width / 2.5,
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
                                  Container(
                                      margin:
                                          EdgeInsets.only(bottom: 8, top: 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          approve == '1'
                                              ? AppSmallButton(
                                                  onPressed: () {
                                                    //
                                                  },
                                                  label: Keystring.CHAT.tr,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                  width: sizePhone.width / 4,
                                                  bgColor: Colors
                                                      .blueAccent.shade100,
                                                  icon:
                                                      Icon(Icons.chat_outlined),
                                                )
                                              : SizedBox(width: 0),
                                          AppSmallButton(
                                            onPressed: () {
                                              ref
                                                  .read(
                                                      applicationDetailProvider
                                                          .notifier)
                                                  .state = data[index];
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ApplicationViewFullScreen()),
                                              );
                                            },
                                            label: Keystring.DETAIL.tr,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            width: sizePhone.width / 3,
                                            icon: Icon(
                                              CupertinoIcons.briefcase,
                                              color: Colors.black,
                                            ),
                                            bgColor:
                                                Colors.amberAccent.shade100,
                                            textColor: Colors.black,
                                          ),
                                        ],
                                      )),
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
    final sizePhone = MediaQuery.of(context).size;
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
                width: sizePhone.width / 4,
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
                width: sizePhone.width / 4,
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
                          width: sizePhone.width / 4,
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
                          width: sizePhone.width / 4,
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
