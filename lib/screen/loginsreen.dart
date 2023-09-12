import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/blocs/app_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_getx.dart';
import 'package:jobhunt_ftl/blocs/app_state.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/home.dart';

import '../component/edittext.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<InsideBloc, InsideState>(
    //   builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
        backgroundColor: Colors.black,
      ),
      body: ScreenLogin(),
    );
    //   },
    //   listener: (context, state) {
    // log('login: ${state.loginStatus}');
    // if (state.loginStatus == LoginStatus.loading) {
    //   Loader.show(context);
    // }

    // if (state.loginStatus == LoginStatus.success) {
    //   Loader.hide();
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => HomeScreen(),
    //     ),
    //   );
    // } else {
    //   Loader.hide();
    // }
    // },
    // );
  }
}

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLogin();
}

class _ScreenLogin extends State<ScreenLogin> {
  final getXX = Get.put(InsideGetX());
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              EditTextForm(
                onChanged: ((value) {
                  // BlocProvider.of<InsideBloc>(context)
                  //     .add(LoginEmailChangedEvent(email: value));
                  getXX.getEmailLoginString(value);
                }),
                textColor: Colors.black,
                borderSelected: Colors.orange,
                label: 'Username',
                hintText: 'Username',
              ),
              SizedBox(height: 30.0),
              EditTextForm(
                obscureText: true,
                showEye: true,
                onChanged: ((value) {
                  // BlocProvider.of<InsideBloc>(context)
                  //     .add(LoginPasswordChangedEvent(password: value));
                  getXX.getPasswordLoginString(value);
                }),
                textColor: Colors.black,
                borderSelected: Colors.orange,
                // controller: _passController,
                label: 'Password',
                hintText: 'Password',
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: Size(double.infinity, 60)),
                onPressed: () async {
                  log("click button dang nhap");

                  // BlocProvider.of<InsideBloc>(context)
                  //     .add(LoginButtonPressedEvent());
                  await getXX.loginApp();
                  if (getXX.loginCheck.value) {
                    Get.off(() => HomeScreen());
                  }
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
