import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_state.dart';
import 'package:jobhunt_ftl/component/edittext.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:jobhunt_ftl/screen/company.dart';
import 'package:jobhunt_ftl/screen/user_info.dart';
import 'package:jobhunt_ftl/screen/user_profile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsideBloc, InsideState>(
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text("HOME"),
            backgroundColor: Colors.black,
          ),
          body: ScreenHome(loginUser: state.userLogin),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.only(top: 10),
              children: [
                ListTile(
                  title: Text('USER INFO'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserInfoScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text('USER PROFILE'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                                loginUId: state.userLogin!.uid ?? '',
                              )),
                    );
                  },
                ),
                ListTile(
                  title: Text('FOLLOW CV'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('CHANGE PASSWORD'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('ABOUT'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('EXIT'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key, required this.loginUser});
  UserDetail? loginUser;

  @override
  State<ScreenHome> createState() => _ScreenHome();
}

class _ScreenHome extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Card(
            elevation: 2,
            margin: EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                log('ccc');
                //
                // BlocProvider.of<InsideBloc>(context).add(GetAllCompanyEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyManagerScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.edit_document,
                      size: 30,
                      color: Colors.brown,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Text(
                        'COMPANY',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.brown,
                    )
                  ],
                ),
              ),
            ),
          ),
          //
        ],
      )),
    );
  }
}
