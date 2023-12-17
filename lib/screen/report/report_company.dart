import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_riverpod_object.dart';

class ReportScreen extends ConsumerStatefulWidget {
  ReportScreen({required this.job, Key? key}) : super(key: key);
  JobDetail job;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReportScreen();
}

class _ReportScreen extends ConsumerState<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool checkOtherReasons = ref.watch(OtherReasonProvider);
    String _reason = ref.watch(ReportingReasonProvider);
    String _otherReportingReason = ref.watch(OtherReportingReasonProvider);
    final user = ref.watch(userLoginProvider);
    return (Scaffold(
      appBar: AppBar(
        title: Text(Keystring.REPORT.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 220, 220, 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Keystring.REPORT_COMPANY_REMINDER.tr)),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                  width: screenWidth, child: Text(Keystring.Name_Job.tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                  width: screenWidth, child: Text(widget.job.name ?? '')),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                  width: screenWidth, child: Text(Keystring.RECRUITER.tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                  width: screenWidth,
                  child: Text(widget.job.company!.fullname ?? '')),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              color: Color.fromRGBO(220, 220, 220, 1.0),
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                  width: screenWidth,
                  child: Text(Keystring.REPORTING_REASON.tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))),
            ),
            ListTile(
              title: Text(Keystring.ONE_REASON.tr),
              leading: Radio(
                activeColor: Theme.of(context).colorScheme.primary,
                value: 'The employer shows signs of fraud',
                groupValue: _reason,
                onChanged: (value) {
                  ref.read(ReportingReasonProvider.notifier).state = value!;
                  ref.read(OtherReasonProvider.notifier).state = false;
                },
              ),
            ),
            ListTile(
              title: Text(Keystring.TWO_REASON.tr),
              leading: Radio(
                activeColor: Theme.of(context).colorScheme.primary,
                value: 'Incorrect information',
                groupValue: _reason,
                onChanged: (value) {
                  ref.read(ReportingReasonProvider.notifier).state = value!;
                  ref.read(OtherReasonProvider.notifier).state = false;
                  ref.read(OtherReportingReasonProvider.notifier).state = '';
                },
              ),
            ),
            ListTile(
              title: Text(Keystring.OTHER_REASONS.tr),
              leading: Radio(
                activeColor: Theme.of(context).colorScheme.primary,
                value: 'Other reasons',
                groupValue: _reason,
                onChanged: (value) {
                  ref.read(ReportingReasonProvider.notifier).state = value!;
                  ref.read(OtherReasonProvider.notifier).state = true;
                  ref.read(OtherReportingReasonProvider.notifier).state = '';
                },
              ),
            ),
            checkOtherReasons
                ? Container(
                    height: 100,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: Keystring.THREE_REASON.tr,
                          border: InputBorder.none,
                        ),
                        onChanged: ((value) {
                          ref
                              .read(OtherReportingReasonProvider.notifier)
                              .state = value;
                          log(value);
                        }),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  minimumSize: Size(screenWidth, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if (_reason == 'Other reasons' &&
                      _otherReportingReason == '') {
                  } else {
                    ref.read(LoginControllerProvider.notifier).createReport(
                        user?.uid ?? '',
                        widget.job.company!.uid ?? '',
                        _reason,
                        _otherReportingReason);
                    showSuccessDialog(context);
                  }
                },
                child: Text(Keystring.REPORT.tr),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(Keystring.SUCCESSFUL.tr),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(220, 220, 220, 1.0),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(Keystring.CANCEL.tr),
          ),
        ],
      );
    },
  );
}
