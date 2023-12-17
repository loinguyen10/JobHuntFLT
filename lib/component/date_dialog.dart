import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/value/style.dart';

import '../value/keystring.dart';

class DateCustomDialog {
  // String? _date;
  final dateFormat = DateFormat('dd/MM/yyyy');

  Widget dobDate(BuildContext context, WidgetRef ref, String? text) {
    return ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          birthPickerShow(context, ref);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (text == null || text == '') ? Keystring.SELECT.tr : text ?? '',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            Icon(
              Icons.access_time,
              color: appPrimaryColor,
            ),
          ],
        ),
        style: dalDateStyle);
  }

  Widget jobDate(
      BuildContext context, WidgetRef ref, String? text, bool readOnly) {
    return ElevatedButton(
        onPressed: () {
          if (readOnly) {
            null;
          } else {
            FocusManager.instance.primaryFocus?.unfocus();
            deadlineDatePickerShow(context, ref);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (text == null || text == '') ? Keystring.SELECT.tr : text ?? '',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Icon(
              Icons.access_time,
              color: appPrimaryColor,
            ),
          ],
        ),
        style: dalDateStyle);
  }

  Widget searchDate(BuildContext context, WidgetRef ref) {
    String text = ref.watch(dateSearchProvider);

    return ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          defaultDatePickerShow(context, ref, dateSearchProvider);
        },
        style: dalDateStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.isEmpty ? Keystring.SELECT.tr : text,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            SizedBox(width: 4),
            text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      ref.invalidate(dateSearchProvider);
                    },
                    child: Icon(
                      Icons.close,
                      color: appPrimaryColor,
                      size: 20,
                    ),
                  )
                : Icon(
                    Icons.access_time,
                    color: appPrimaryColor,
                    size: 20,
                  ),
          ],
        ));
  }

  Widget setDateInterview(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        defaultDatePickerShow(
            context, ref, dateTimeInterviewApplicationProvider);
      },
      style: dalDateStyle.copyWith(
          backgroundColor: MaterialStatePropertyAll(appPrimaryColor)),
      child: Icon(
        Icons.edit,
        size: 16,
      ),
    );
  }

  Widget setTimeInterview(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        defaultTimeCupertinoPickerShow(
            context, ref, timeTimeInterviewApplicationProvider);
      },
      style: dalDateStyle.copyWith(
          backgroundColor: MaterialStatePropertyAll(appPrimaryColor)),
      child: Icon(
        Icons.edit,
        size: 16,
      ),
    );
  }

  //

  void defaultDatePickerShow(
    BuildContext context,
    WidgetRef ref,
    AutoDisposeStateProvider<String> provider,
  ) async {
    final dateChoose = ref.watch(provider);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateChoose != ''
          ? DateTime(
              int.parse(dateChoose.substring(6)), //year
              int.parse(dateChoose.substring(3, 5)), //month
              int.parse(dateChoose.substring(0, 2)), //day
            )
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2099, 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null) {
      log('${dateFormat.format(picked)}');
      ref.read(provider.notifier).state = dateFormat.format(picked);
    }
  }

  void defaultTimePickerShow(
    BuildContext context,
    WidgetRef ref,
    AutoDisposeStateProvider<String> provider,
  ) async {
    final timeChoose = ref.watch(provider);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeChoose != ''
          ? TimeOfDay(
              hour: int.parse(
                  timeChoose.substring(0, timeChoose.indexOf(':'))), //hour
              minute: int.parse(timeChoose.substring(3)), //minute
            )
          : TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (picked != null) {
      log('$picked');
      String hour =
          picked.hour >= 10 ? picked.hour.toString() : '0${picked.hour}';
      String minute =
          picked.minute >= 10 ? picked.minute.toString() : '0${picked.minute}';
      ref.read(provider.notifier).state = '$hour:$minute';
    }
  }

  void defaultTimeCupertinoPickerShow(
    BuildContext context,
    WidgetRef ref,
    AutoDisposeStateProvider<String> provider,
  ) async {
    String timeChoose = ref.watch(provider);

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 280,
                  child: CupertinoDatePicker(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    initialDateTime: timeChoose.isNotEmpty
                        ? DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            int.parse(timeChoose.substring(0, 2)),
                            int.parse(timeChoose.substring(3)),
                          )
                        : DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime newTime) {
                      String hour = newTime.hour >= 10
                          ? newTime.hour.toString()
                          : '0${newTime.hour}';
                      String minute = newTime.minute >= 10
                          ? newTime.minute.toString()
                          : '0${newTime.minute}';
                      timeChoose = '$hour:$minute';
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: AppButton(
                    onPressed: () {
                      log('time: $timeChoose');
                      ref.read(provider.notifier).state = timeChoose;
                      Get.back();
                    },
                    label: Keystring.CONFIRM.tr,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    bgColor: Colors.grey,
                    textColor: Colors.black,
                    colorBorder: Colors.black,
                    borderRadius: 16,
                    height: 56,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void birthPickerShow(BuildContext context, WidgetRef ref) async {
    final dateChoose = ref.watch(dateBirthProvider);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateChoose != ''
          ? DateTime(
              int.parse(dateChoose.substring(6)), //year
              int.parse(dateChoose.substring(3, 5)), //month
              int.parse(dateChoose.substring(0, 2)), //day
            )
          : DateTime(DateTime.now().year - 16),
      firstDate: DateTime(1945),
      lastDate: DateTime(DateTime.now().year - 15, 12, 31),
      // lastDate: DateTime(DateTime.now().year + 15, 12, 31),
    );
    if (picked != null) {
      log('${dateFormat.format(picked)}');
      ref.read(dateBirthProvider.notifier).state = dateFormat.format(picked);
    }
  }

  void deadlineDatePickerShow(BuildContext context, WidgetRef ref) async {
    final dateChoose = ref.watch(jobDeadlineProvider);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateChoose != ''
          ? DateTime(
              int.parse(dateChoose.substring(6)), //year
              int.parse(dateChoose.substring(3, 5)), //month
              int.parse(dateChoose.substring(0, 2)), //day
            )
          : DateTime.now(),
      firstDate: dateChoose != ''
          ? DateTime(
              int.parse(dateChoose.substring(6)), //year
              int.parse(dateChoose.substring(3, 5)), //month
              int.parse(dateChoose.substring(0, 2)), //day
            )
          : DateTime(2016),
      lastDate: DateTime(DateTime.now().year + 15, 12, 31),
    );
    if (picked != null) {
      log('${dateFormat.format(picked)}');
      ref.read(jobDeadlineProvider.notifier).state = dateFormat.format(picked);
    }
  }
}
