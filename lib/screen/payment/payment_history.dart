import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../value/keystring.dart';

class PaymentHistoryScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentHistoryScreen();
}

class _PaymentHistoryScreen extends ConsumerState<PaymentHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text(Keystring.JOB_RECOMMEND_SETTING.tr),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
