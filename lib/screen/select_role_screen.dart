import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../value/style.dart';
import 'edit_profile.dart';

class RoleScreen extends ConsumerWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: bgGradientColor),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: AppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreenNew(),
                      ));
                },
                content: Keystring.CANDIDATE.tr),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: AppButton(
                onPressed: () {
                  //
                },
                content: Keystring.RECUITER.tr),
          ),
        ],
      ),
    ));
  }
}
