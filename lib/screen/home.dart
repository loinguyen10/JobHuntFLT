import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/screen/company.dart';
import 'package:jobhunt_ftl/screen/menu_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../value/style.dart';

class HomeScreen extends ConsumerWidget {
  // final getXX = Get.put(InsideGetX());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return BlocBuilder<InsideBloc, InsideState>(
    //   builder: (context, state) {
    final user = ref.watch(userLoginProvider);

    return
        // SafeArea(child:
        Scaffold(
      appBar: AppBar(
        // title: Text("HOME"),
        backgroundColor: appPrimaryColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: Row(
                children: [
                  Text(
                    "${Keystring.HELLO.tr}: ",
                    style: textCV,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(24), // Image radius
                      child: Image.network(
                        // _data?.avatarUrl ?? '',
                        'https://firebasestorage.googleapis.com/v0/b/jobhunt-97208.appspot.com/o/company_images%2FAHh8mEpAnFUfcImaHhOnZIr46s02.jpg?alt=media&token=be0ee9ba-7e50-481d-a027-f1e83281f966',
                        // width: 64,
                        // height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
            );
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: ScreenHome(loginUser: user!),
    );
    // );
  }
}

class ScreenHome extends ConsumerStatefulWidget {
  const ScreenHome({super.key, required this.loginUser});

  final UserDetail loginUser;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScreenHome();
}

class _ScreenHome extends ConsumerState<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: bgPrimaryColor,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  log('click search');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.search,
                          size: 30,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          Keystring.SEARCH,
                          style: textNormalHint,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Keystring.RECOMMEND_JOB.tr,
                        style: textJobHome,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Card(
                      shape: Border.all(color: Colors.white, width: 2),
                      // margin: EdgeInsets.all(8),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const CompanyManagerScreen(),
                      ),
                    ),
                  ],
                ),
              ),
              //
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Keystring.BEST_JOB.tr,
                        style: textJobHome,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Card(
                      shape: Border.all(color: Colors.white, width: 2),
                      // margin: EdgeInsets.all(8),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const CompanyManagerScreen(),
                      ),
                    ),
                  ],
                ),
              ),
              //
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Keystring.VERIFIED_COMPANIES.tr,
                        style: textJobHome,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Card(
                      shape: Border.all(color: Colors.white, width: 2),
                      // margin: EdgeInsets.all(8),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const CompanyManagerScreen(),
                      ),
                    ),
                  ],
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
