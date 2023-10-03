import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/screen/user/candidate_job_screen.dart';
import 'package:jobhunt_ftl/screen/user/cv_screen.dart';
import 'package:jobhunt_ftl/screen/user/edit_profile.dart';
import 'package:jobhunt_ftl/screen/user/edit_recuiter.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../blocs/app_riverpod_object.dart';
import '../component/loader_overlay.dart';
import '../value/style.dart';
import 'login_register/login_sreen.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final company = ref.watch(companyProfileProvider);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appHintColor,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: bgPrimaryColor,
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                ),
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(56), // Image radius
                    child: profile != null || company != null
                        ? profile?.avatarUrl != null && profile?.avatarUrl != ''
                            ? Image.network(
                                profile?.avatarUrl ?? '',
                                fit: BoxFit.cover,
                              )
                            : company?.avatarUrl != null &&
                                    company?.avatarUrl != ''
                                ? Image.network(
                                    company?.avatarUrl ?? '',
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.no_accounts_outlined,
                                    size: 112,
                                  )
                        : Icon(
                            Icons.no_accounts_outlined,
                            size: 112,
                          ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  profile == null && company == null
                      ? Keystring.GUEST.tr
                      : profile != null
                          ? profile.fullName ?? ''
                          : company?.fullname ?? '',
                  style: textNameMenu,
                ),
                SizedBox(
                  height: 32,
                ),
                ////
                InkWell(
                  onTap: () {
                    log('click profile');
                    if (profile != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreenNew(
                                  edit: true,
                                )),
                      );
                    } else if (company != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecuiterEditScreen(
                                  edit: true,
                                )),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Please sign in.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(Keystring.OK.tr),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.YOUR_PROFILE.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(uilder: (context) => // ),);
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.markunread_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.YOUR_INBOX.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CVChooseScreen()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.YOUR_CV.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(uilder: (context) => // ),);
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.briefcase,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.YOUR_JOB_STATUS.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.refresh(listYourFavoriteProvider);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YourJobSavedScreen()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.save_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.YOUR_JOB_SAVED.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(uilder: (context) => // ),);
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.apartment_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.YOUR_FOLLOWING_COMPANY.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(uilder: (context) => // ),);
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.JOB_RECOMMEND_SETTING.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(uilder: (context) => // ),);
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.bell,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.NOTIFICATION.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(uilder: (context) => // ),);
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.tune_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.SETTING.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('EXIT?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (profile == null && company == null) {
                                  // SystemChannels.platform.invokeMethod<void>(
                                  //     'SystemNavigator.pop');
                                  Get.offAll(LoginScreen());
                                } else {
                                  Loader.show(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                  ref.read(emailLoginProvider.notifier).state =
                                      '';
                                  ref
                                      .read(passwordLoginProvider.notifier)
                                      .state = '';
                                  ref.read(userLoginProvider.notifier).state =
                                      null;
                                  Loader.hide();
                                }
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.EXIT.tr,
                            style: textMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ////
                SizedBox(
                  height: 32,
                ),
                // Text(Keystring.APP_NAME.tr),
                // SizedBox(
                //   height: 32,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
