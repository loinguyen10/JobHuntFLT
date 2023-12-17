import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/app_small_button.dart';
import 'package:jobhunt_ftl/component/card.dart';
import 'package:jobhunt_ftl/screen/user/viewcv.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import '../job/job_view_screen.dart';
import '../setting/message_user_recruiter.dart';

class YourJobStatusScreen extends ConsumerStatefulWidget {
  const YourJobStatusScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _YourJobStatusScreenState();
}

class _YourJobStatusScreenState extends ConsumerState<YourJobStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final sizePhone = MediaQuery.of(context).size;

    var _data = ref.watch(listCandidateApplicationProvider);

    final statusCheck = ref.watch(StatusCheckProvider);

    if (statusCheck == '') _data = ref.watch(listCandidateApplicationProvider);
    if (statusCheck == 'waiting') {
      _data = ref.watch(listCandidateWaitingApplicationProvider);
    }
    if (statusCheck == 'approve') {
      _data = ref.watch(listCandidateApproveApplicationProvider);
    }
    if (statusCheck == 'reject') {
      _data = ref.watch(listCandidateRejectApplicationProvider);
    }

    return SafeArea(
      child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: Text(Keystring.YOUR_JOB_STATUS.tr),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
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
                          String interviewTime =
                              data[index].interviewTime ?? '';
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
                                  color: approve == ''
                                      ? Colors.grey
                                      : Colors.black,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${Keystring.STATUS.tr}:',
                                              style: textNormal.copyWith(
                                                color: Colors.grey.shade700,
                                              ),
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
                                            ),
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
                                                      style:
                                                          textNormal.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      interviewTime
                                                          .toUpperCase(),
                                                      style: textNormalBold
                                                          .copyWith(
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            approve == '1'
                                                ? AppSmallButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => MessageScreen(
                                                                Uid: data[index]
                                                                        .job!
                                                                        .company!
                                                                        .uid ??
                                                                    'tùng nà'),
                                                          ));
                                                    },
                                                    label: Keystring.CHAT.tr,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4),
                                                    width: sizePhone.width / 4,
                                                    bgColor: Colors
                                                        .blueAccent.shade100,
                                                    icon: Icon(
                                                        Icons.chat_outlined),
                                                  )
                                                : SizedBox(width: 0),
                                            AppSmallButton(
                                              onPressed: () {
                                                ref
                                                    .read(jobDetailProvider
                                                        .notifier)
                                                    .state = data[index].job!;
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          JobViewScreen()),
                                                );
                                              },
                                              label: Keystring.VIEW_JOB.tr,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              width: sizePhone.width / 4,
                                              icon: Icon(
                                                CupertinoIcons.briefcase,
                                                color: Colors.black,
                                              ),
                                              bgColor:
                                                  Colors.amberAccent.shade100,
                                              textColor: Colors.black,
                                            ),
                                            AppSmallButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewCVScreen(
                                                            cv: data[index]
                                                                    .cvUrl ??
                                                                '',
                                                          )),
                                                );
                                              },
                                              label: Keystring.VIEW_CV.tr,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              width: sizePhone.width / 4,
                                              icon: Icon(
                                                Icons.description_outlined,
                                              ),
                                              bgColor: Colors.grey.shade700,
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
          )),
    );
  }
}

class YourJobSavedScreen extends ConsumerWidget {
  const YourJobSavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listYourFavoriteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(Keystring.YOUR_JOB_SAVED.tr),
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
                _data.when(
                  data: (data) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        String avatar =
                            data[index].job!.company!.avatarUrl ?? '';
                        String name = data[index].job!.name ?? '';
                        String nameCompany =
                            data[index].job!.company!.fullname ?? '';
                        String? deadline = data[index].job!.deadline ?? '';
                        String? money = data[index].job!.maxSalary != -1
                            ? '${getReduceZeroMoney(data[index].job!.maxSalary ?? 0)} ${data[index].job!.currency}'
                            : Keystring.ARGEEMENT.tr;
                        bool active =
                            data[index].job!.active == 1 ? true : false;

                        return Card(
                          shadowColor: Colors.black,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          elevation: 5,
                          child: GestureDetector(
                            onTap: active
                                ? () {
                                    ref.read(jobDetailProvider.notifier).state =
                                        data[index].job!;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobViewScreen()));
                                  }
                                : null,
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
      ),
    );
  }
}
