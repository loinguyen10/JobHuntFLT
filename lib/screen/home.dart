import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_state.dart';
import 'package:jobhunt_ftl/component/edittext.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:jobhunt_ftl/screen/company.dart';
import 'package:jobhunt_ftl/screen/loginsreen.dart';
import 'package:jobhunt_ftl/screen/menu_screen.dart';
import 'package:jobhunt_ftl/screen/user_info.dart';
import 'package:jobhunt_ftl/screen/user_profile.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../value/style.dart';

class HomeScreen extends ConsumerWidget {
  // final getXX = Get.put(InsideGetX());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return BlocBuilder<InsideBloc, InsideState>(
    //   builder: (context, state) {
    final user = ref.watch(userLoginProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text("HOME"),
          backgroundColor: appPrimaryColor,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Center(
                child: Row(
                  children: [
                    Text("${Keystring.HELLO.tr}: "),
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
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ),
        body: ScreenHome(loginUser: user!),
      ),
    );
    //   },
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
        child: Column(
          children: [
            // Card(
            //   elevation: 2,
            //   margin: EdgeInsets.only(top: 10),
            //   child: InkWell(
            //     onTap: () {
            //       log('ccc');
            //       //
            //       // BlocProvider.of<InsideBloc>(context).add(GetAllCompanyEvent());
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => CompanyManagerScreen()),
            //       );
            //     },
            //     child: Container(
            //       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Icon(
            //             Icons.edit_document,
            //             size: 30,
            //             color: Colors.brown,
            //           ),
            //           Container(
            //             width: MediaQuery.of(context).size.width - 150,
            //             child: Text(
            //               'COMPANY',
            //               style: TextStyle(
            //                 color: Colors.brown,
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w900,
            //               ),
            //             ),
            //           ),
            //           Icon(
            //             Icons.arrow_forward_ios,
            //             color: Colors.brown,
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            //
            CompanyManagerScreen(),
          ],
        ),
      ),
    );
  }
}
