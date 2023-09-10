import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_state.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/repository/repository.dart';

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsideBloc, InsideState>(
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text("USER INFO"),
            backgroundColor: Colors.black,
          ),
          body: ScreenUserInfo(),
        ));
      },
    );
  }
}

class ScreenUserInfo extends StatefulWidget {
  ScreenUserInfo({
    super.key,
    // required this.loginUser,
  });
  // UserDetail? loginUser;

  @override
  State<ScreenUserInfo> createState() => _ScreenUserInfo();
}

class _ScreenUserInfo extends State<ScreenUserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text('Hello'),
          Text('USER INFO'),
        ],
      )),
    );
  }
}
