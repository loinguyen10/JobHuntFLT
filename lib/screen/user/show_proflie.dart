import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/component/date_dialog.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_event.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/edittext.dart';
import '../../component/outline_text.dart';
import '../../value/style.dart';
import '../home.dart';

class ShowProfileScreen extends ConsumerStatefulWidget {
  const ShowProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowProfileScreen();
}

class _ShowProfileScreen extends ConsumerState<ShowProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userLoginProvider);
    final profile = ref.watch(userProfileProvider);

    final avatarProfile = ref.watch(avatarProfileProvider);
    final birthdayProfile = ref.watch(dateBirthProvider);

    return Container(
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
              ),
              Row(
                children: [
                  SizedBox(width: 24),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(64), // Image radius
                      child: avatarProfile != ''
                          ? Image.network(avatarProfile, fit: BoxFit.cover)
                          : Icon(
                        Icons.no_accounts_outlined,
                        size: 256,
                      ),
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppOutlineText(
                            text: profile?.fullName ?? '',
                            fontSize: 22,
                            strokeWidth: 2,
                          ),
                          Text(
                            '${Keystring.BIRTHDAY.tr}: ${profile?.birthday ?? ''}',
                            style: textNormal,
                          )
                        ],
                      )),
                  SizedBox(width: 24),
                ],
              ),
              SizedBox(height: 32),
              EditTextForm(
                onChanged: (value) => (),
                label: Keystring.EMAIL.tr,
                content:
                profile?.email ?? ref.watch(emailProfileProvider) ?? '',
                readOnly: true,
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: (value) => (),
                label: Keystring.PHONE.tr,
                content: profile?.phone ?? '',
                readOnly: true,
              ),
              SizedBox(height: 24),
              AppBorderFrame(
                  labelText: Keystring.ADDRESS.tr,
                  child: Expanded(
                    child: Text('${getWardName(profile!.address!.substring(profile!.address!.indexOf(',') + 1,
                        profile!.address!.indexOf(',', profile!.address!.indexOf(',') + 1)), ref)},'
                        '${getDistrictName(profile!.address!.substring(
                        profile!.address!.lastIndexOf(',', profile!.address!.lastIndexOf(',') - 1) + 1,
                        profile!.address!.lastIndexOf(',')), ref)},'
                        '${getProvinceName(profile!.address!.substring(profile.address!.lastIndexOf(',') + 1), ref)}',style: textNormal,),
                  )
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
