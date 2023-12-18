import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/component/app_small_button.dart';
import 'package:jobhunt_ftl/component/date_dialog.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/job.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../setting/message_user_recruiter.dart';
import 'application_view_screen.dart';

class AllAppicationRecuiterScreen extends ConsumerStatefulWidget {
  const AllAppicationRecuiterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllAppicationRecuiterScreenState();
}

class _AllAppicationRecuiterScreenState
    extends ConsumerState<AllAppicationRecuiterScreen> {
  var textEditingController = TextEditingController();
  bool focusCheck = false;
  String statusCheck = '';
  JobDetail? jobChoose;

  @override
  Widget build(BuildContext context) {
    final sizePhone = MediaQuery.of(context).size;
    var list = ref.watch(listRecuiterApplicationProvider);
    final getListJob = ref.watch(listCompanyJobProvider);

    final listJob = [];

    getListJob.when(
      data: (_data) {
        listJob.addAll(_data);
      },
      error: (error, stackTrace) => null,
      loading: () => const CircularProgressIndicator(),
    );

    ref.listen<InsideEvent>(LoginControllerProvider, (previous, state) {
      log('pre - state : $previous - $state');

      if (state == GetListErrorEvent()) {
        Loader.hide();
        log('error');
        Fluttertoast.showToast(
          msg: Keystring.OTP_fail.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      if (state == GetListSuccessEvent()) {
        Loader.hide();
        log('success');
        setState(() {});
      }

      if (state == ThingLoadingEvent()) {
        Loader.show(context);
      }
    });

    void searchDone() {
      ref
          .read(LoginControllerProvider.notifier)
          .getRecuiterApplicationWithSetting(
            jobChoose?.code ?? '',
            statusCheck,
            ref.watch(dateSearchProvider),
          );
    }

    DropdownButtonHideUnderline dropJob() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            Keystring.SELECT.tr,
            style: textNormal,
          ),
          items: listJob
              .map((item) => DropdownMenuItem<JobDetail>(
                    value: item,
                    child: Text(item.name ?? '', style: textNormal),
                  ))
              .toList(),
          value: jobChoose,
          onChanged: (value) {
            jobChoose = value;
            setState(() {});
          },
          iconStyleData: IconStyleData(
              icon: jobChoose != null
                  ? InkWell(
                      onTap: () {
                        jobChoose = null;
                        setState(() {});
                      },
                      child: Icon(Icons.close),
                    )
                  : Icon(Icons.arrow_drop_down)),
          buttonStyleData: dropDownButtonStyle2,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      );
    }

    return StatefulBuilder(
      builder: (context, mSetState) {
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
                        child: dropJob(),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      DateCustomDialog().searchDate(context, ref),
                      SizedBox(
                        width: 8,
                      ),
                      AppButton(
                        onPressed: () {
                          searchDone();
                          mSetState(() {
                            focusCheck = false;
                            FocusScope.of(context).unfocus();
                          });
                        },
                        label: Keystring.SEARCH.tr,
                        width: sizePhone.width / 10,
                        bgColor: appPrimaryColor,
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
                            statusCheck = '';
                          } else {
                            statusCheck = 'waiting';
                          }
                          searchDone();
                          mSetState(() {
                            focusCheck = false;
                            FocusScope.of(context).unfocus();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 4),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
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
                            statusCheck = '';
                          } else {
                            statusCheck = 'approve';
                          }
                          searchDone();
                          mSetState(() {
                            focusCheck = false;
                            FocusScope.of(context).unfocus();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 4),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
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
                            statusCheck = '';
                          } else {
                            statusCheck = 'reject';
                          }
                          searchDone();
                          mSetState(() {
                            focusCheck = false;
                            FocusScope.of(context).unfocus();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 4),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
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
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        String avatarCandidate =
                            list[index].candidate!.avatarUrl ?? '';
                        String name = list[index].job!.name ?? '';
                        String candidate =
                            list[index].candidate!.fullName ?? '';
                        String approve = list[index].approve ?? '';
                        String sentTime = list[index].sendTime ?? '';
                        String interviewTime = list[index].interviewTime ?? '';
                        String time = approve.isEmpty
                            ? sentTime
                            : list[index].approveTime ?? '';

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
                            textColor:
                                approve == '' ? Colors.black : Colors.black38,
                            collapsedTextColor: Colors.black,
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
                                      child: avatarCandidate.isNotEmpty
                                          ? Image.network(avatarCandidate,
                                              fit: BoxFit.cover)
                                          : Icon(
                                              Icons.no_accounts,
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
                                              '${Keystring.CANDIDATE.tr}:',
                                              style: textNormal.copyWith(
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            Text(
                                              candidate.toUpperCase(),
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
                                        child: interviewTime.isNotEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${Keystring.INTERVIEW_TIME.tr}:',
                                                    style: textNormal.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    interviewTime.toUpperCase(),
                                                    style:
                                                        textNormalBold.copyWith(
                                                      color: Color.fromARGB(
                                                          255, 0, 150, 0),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : null,
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
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MessageScreen(
                                                                  Uid: list[index].candidate?.uid?? 'tùng nà')
                                                      ),
                                                    );
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
                                                  .state = list[index];
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ApplicationViewFullScreen(
                                                          recruiter: true,
                                                        )),
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
                      itemCount: list.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
