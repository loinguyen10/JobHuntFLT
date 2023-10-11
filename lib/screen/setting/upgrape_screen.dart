import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../value/keystring.dart';
import '../../value/style.dart';

class UpgrapePremiumScreen extends ConsumerWidget {
  const UpgrapePremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        color: bgPrimaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.UPGRAPE.tr),
                backgroundColor: bgPrimaryColor,
                elevation: 0,
                foregroundColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
