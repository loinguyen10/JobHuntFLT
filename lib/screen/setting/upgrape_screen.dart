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
        color: Theme.of(context).colorScheme.secondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.UPGRADE.tr),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
