import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/screen/payment/payment_history.dart';
import 'package:jobhunt_ftl/screen/payment/payment_main_layout.dart';
import 'package:jobhunt_ftl/screen/setting/job_recommend_screen.dart';
import 'package:jobhunt_ftl/screen/setting/languague_screen.dart';
import 'package:jobhunt_ftl/screen/user/candidate_job_screen.dart';
import 'package:jobhunt_ftl/screen/user/cv_screen.dart';
import 'package:jobhunt_ftl/screen/user/edit_profile.dart';
import 'package:jobhunt_ftl/screen/user/edit_recuiter.dart';
import 'package:jobhunt_ftl/screen/user/follow_company_list.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/app_riverpod_object.dart';
import '../component/loader_overlay.dart';
import '../value/style.dart';
import 'job/recuiter_application_screen.dart';
import 'login_register/changepass_isloged.dart';
import 'login_register/login_sreen.dart';
import 'setting/message_user_recruiter.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final company = ref.watch(companyProfileProvider);

    // void showD() {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: Text('Please sign in.'),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: Text(Keystring.OK.tr),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    Future<void> deleteNextTime() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('emailSaveNextTime', '');
      await prefs.setString('passwordSaveNextTime', '');
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appHintColor,
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.background == Colors.white
                ? bgGradientColor2
                : bgGradientColor1),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                ),
                profile != null || company != null
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: profile?.level == 'Premium' ||
                                    company?.level == 'Premium'
                                ? Colors.yellow
                                : Colors.transparent,
                            width: 4.0,
                          ),
                        ),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(56), // Image radius
                            child: Container(
                              color: const Color.fromARGB(127, 255, 255, 255),
                              child: profile?.avatarUrl != null &&
                                      profile?.avatarUrl != ''
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
                                        ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(height: 0),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          profile == null && company == null
                              ? Keystring.GUEST.tr
                              : profile != null
                                  ? profile.fullName ?? ''
                                  : company?.fullname ?? '',
                          style: textNameMenu,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: profile == null && company == null ? 0 : 8,
                      ),
                      profile == null && company == null
                          ? SizedBox(height: 0)
                          : profile?.level == 'Premium' ||
                                  company?.level == 'Premium'
                              ? AppTagCard(
                                  child: Text(Keystring.PREMIUM.tr),
                                  bgColor: Colors.yellow,
                                  borderColor: Colors.grey,
                                )
                              : AppTagCard(
                                  child: Text(
                                    Keystring.BASIC.tr,
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  bgColor: Colors.grey.shade300,
                                  borderColor: Colors.black54,
                                ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                profile == null && company == null
                    ? SizedBox(
                        height: 0,
                      )
                    : Column(
                        children: [
                          InkWell(
                            onTap: () {
                              log('click profile');
                              if (profile != null) {
                                ref.invalidate(provinceChooseProvider);
                                ref.invalidate(districtChooseProvider);
                                ref.invalidate(wardChooseProvider);
                                ref.invalidate(avatarProfileProvider);
                                ref.invalidate(dateBirthProvider);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfileScreenNew(edit: true),
                                  ),
                                );
                              } else if (company != null) {
                                ref.invalidate(listJobTagCompanyProvider);
                                ref.invalidate(provinceCompanyProvider);
                                ref.invalidate(districtCompanyProvider);
                                ref.invalidate(wardCompanyProvider);
                                ref.invalidate(avatarCompanyProvider);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecuiterEditScreen(
                                            edit: true,
                                          )),
                                );
                              }
                            },
                            child: Card(
                              shadowColor: Colors.grey,
                              shape: Border.all(color: Colors.white, width: 2),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Conversation()),
                              );
                            },
                            child: Card(
                              shadowColor: Colors.grey,
                              shape: Border.all(color: Colors.white, width: 2),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
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
                          company == null
                              ? Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CVChooseScreen()),
                                      );
                                    },
                                    child: Card(
                                      shadowColor: Colors.grey,
                                      shape: Border.all(
                                          color: Colors.white, width: 2),
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
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
                                      ref.invalidate(StatusCheckProvider);
                                      ref.invalidate(
                                          listCandidateApplicationProvider);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                YourJobStatusScreen()),
                                      );
                                    },
                                    child: Card(
                                      shadowColor: Colors.grey,
                                      shape: Border.all(
                                          color: Colors.white, width: 2),
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
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
                                      ref.invalidate(listYourFavoriteProvider);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                YourJobSavedScreen()),
                                      );
                                    },
                                    child: Card(
                                      shadowColor: Colors.grey,
                                      shape: Border.all(
                                          color: Colors.white, width: 2),
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
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
                                      ref.invalidate(listYourFollowProvider);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FollowCompanyScreen()),
                                      );
                                    },
                                    child: Card(
                                      shadowColor: Colors.grey,
                                      shape: Border.all(
                                          color: Colors.white, width: 2),
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
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
                                              Keystring
                                                  .YOUR_FOLLOWING_COMPANY.tr,
                                              style: textMenu,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     ref.invalidate(listYourFollowProvider);
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               MessageScreen(companyUid: "6")),
                                  //     );
                                  //   },
                                  //   child: Card(
                                  //     shadowColor: Colors.grey,
                                  //     shape: Border.all(
                                  //         color: Colors.white, width: 2),
                                  //     margin: EdgeInsets.symmetric(vertical: 4),
                                  //     elevation: 2,
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: Theme.of(context)
                                  //               .colorScheme
                                  //               .background),
                                  //       padding: EdgeInsets.all(20),
                                  //       child: Row(
                                  //         children: [
                                  //           Icon(
                                  //             Icons.messenger,
                                  //             size: 32,
                                  //           ),
                                  //           SizedBox(
                                  //             width: 16,
                                  //           ),
                                  //           Text(
                                  //             Keystring
                                  //                 .MESSAGE.tr,
                                  //             style: textMenu,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      log('click profile');
                                      if (profile != null) {
                                        bool edit = false;
                                        ref.invalidate(
                                            listAllTitleJobSettingProvider);
                                        ref.invalidate(listJob2SettingProvider);
                                        if (ref.watch(userDetailJobSettingProvider)?.uid !=
                                            null) {
                                          edit = true;
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JobRecommendSettingScreen(
                                                    edit: edit,
                                                  )),
                                        );
                                      }
                                    },
                                    child: Card(
                                      shadowColor: Colors.grey,
                                      shape: Border.all(
                                          color: Colors.white, width: 2),
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
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
                                              Keystring
                                                  .JOB_RECOMMEND_SETTING.tr,
                                              style: textMenu,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ])
                              : GestureDetector(
                                  onTap: () {
                                    ref.invalidate(
                                        getListRecuiterApplicationProvider);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllAppicationRecuiterScreen()),
                                    );
                                  },
                                  child: Card(
                                    shadowColor: Colors.grey,
                                    shape: Border.all(
                                        color: Colors.white, width: 2),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    elevation: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
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
                                            Keystring.ALL_APPLICATIONS.tr,
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
                                MaterialPageRoute(
                                    builder: (context) =>
                                        payment_main_layout()),
                              );
                            },
                            child: Card(
                              shadowColor: Colors.grey,
                              shape: Border.all(color: Colors.white, width: 2),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.upgrade,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      Keystring.UPGRADE.tr,
                                      style: textMenu,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ref.invalidate(listYourFavoriteProvider);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentHistoryScreen()),
                              );
                            },
                            child: Card(
                              shadowColor: Colors.grey,
                              shape: Border.all(color: Colors.white, width: 2),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.history,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      Keystring.PAYMENT_HISTORY.tr,
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
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePassword_isloged()),
                              );
                            },
                            child: Card(
                              shadowColor: Colors.grey,
                              shape: Border.all(color: Colors.white, width: 2),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.password,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      Keystring.Changepass.tr,
                                      style: textMenu,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageSelectScreen()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.grey,
                    shape: Border.all(color: Colors.white, width: 2),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.translate,
                            size: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            Keystring.LANGUAGE.tr,
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
                          content: Text(Keystring.WANT_EXIT.tr),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                resetCall(ref);
                                if (profile != null || company != null) {
                                  Loader.show(context);
                                  // ref.read(emailLoginProvider.notifier).state = '';
                                  // ref.read(passwordLoginProvider.notifier).state = '';
                                  deleteNextTime();
                                  Loader.hide();
                                }
                                Get.offAll(() => const LoginScreen());
                              },
                              child: Text(Keystring.EXIT.tr),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(Keystring.CANCEL.tr),
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
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
