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

  Widget dalDate(BuildContext context, WidgetRef ref, String? text) {
    return ElevatedButton(
        onPressed: () {
          datePickerShow(context, ref);
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

  void datePickerShow(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.numberWithOptions(),
    );
    if (picked != null) {
      log('${dateFormat.format(picked)}');
      ref.read(dateBirthProvider.notifier).state = dateFormat.format(picked);
      // picked.toString().split(' ')[0];
    }
  }
}
