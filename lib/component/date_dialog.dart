import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
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

  Widget jobDate(BuildContext context, WidgetRef ref, String? text) {
    return ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          deadlineDatePickerShow(context, ref);
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

  //

  void defaultDatePickerShow(BuildContext context, WidgetRef ref) async {
    //final dateChoose = ref.watch(dateBirthProvider);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2099, 12, 31),
    );
    if (picked != null) {
      log('${dateFormat.format(picked)}');
      //
    }
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
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 15, 12, 31),
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
