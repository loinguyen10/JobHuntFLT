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
import '../../value/style.dart';
import '../home.dart';

class ShowProfileScreen extends ConsumerStatefulWidget {
  const ShowProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowProfileScreen();
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
                title: Text(Keystring.YOUR_PROFILE.tr),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              SizedBox(
                height: 24,
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(64), // Image radius
                  child: avatarProfile != ''
                      ? avatarProfile.substring(0, 8) == 'https://'
                      ? Image.network(
                    avatarProfile,
                    fit: BoxFit.cover,
                  )
                      : Image.file(
                    File(avatarProfile),
                    fit: BoxFit.cover,
                  )
                      : Icon(
                    Icons.no_accounts_outlined,
                    size: 256,
                  ),
                ),
              ),
              SizedBox(height: 32),
              EditTextForm(
                onChanged: ((value) {
                  ref.read(fullNameProfileProvider.notifier).state = value;
                  log(value);
                }),
                label: Keystring.FULLNAME.tr,
                // hintText: Keystring.FULLNAME.tr,
                content: profile?.fullName ?? '',
              ),
              // SizedBox(height: 24),
              // EditTextForm(
              //   onChanged: ((value) {
              //     //
              //   }),
              //   label: Keystring.DISPLAY_NAME.tr,
              // ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  // ref.read(emailProfileProvider.notifier).state = value;
                }),
                label: Keystring.EMAIL.tr,
                content:
                    profile?.email ?? ref.watch(emailProfileProvider) ?? '',
                readOnly: true,
                typeKeyboard: TextInputType.emailAddress,
              ),
              SizedBox(height: 24),
              EditTextForm(
                onChanged: ((value) {
                  if (value.length >= 11) {
                    Fluttertoast.showToast(
                        msg: Keystring.PHONE_LESS_11.tr,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }

                  ref.read(phoneProfileProvider.notifier).state = value;
                }),
                label: Keystring.PHONE.tr,
                content: profile?.phone ?? '',
                maxLines: 1,
                maxLength: 11,
                typeKeyboard: TextInputType.phone,
              ),
              SizedBox(height: 24),

              SizedBox(height: 24),
              AppBorderFrame(
                labelText: Keystring.BIRTHDAY.tr,
                child:
                    DateCustomDialog().dobDate(context, ref, birthdayProfile),
              ),
              SizedBox(
                  height: profile?.premiumExpiry != null &&
                          profile?.premiumExpiry != ''
                      ? 24
                      : 0),
              profile?.premiumExpiry != null && profile?.premiumExpiry != ''
                  ? EditTextForm(
                      onChanged: ((value) {
                        ref.read(premiumExpireProfileProvider.notifier).state =
                            value;
                      }),
                      label: Keystring.PREMIUM_EXPIRY_DATE.tr,
                      content: profile?.premiumExpiry ?? '',
                      maxLines: 1,
                      readOnly: true,
                    )
                  : SizedBox(height: 0),
              SizedBox(height: 32),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
