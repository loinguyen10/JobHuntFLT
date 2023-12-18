import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/editcontroller.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/screen/login_register/forgotpassword.dart';
import 'package:jobhunt_ftl/screen/login_register/register_screen.dart';
import 'package:jobhunt_ftl/screen/login_register/select_role_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../value/style.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  void initState() {
    loadEaP();
    super.initState();
  }

  Future<void> loadEaP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ref.read(emailLoginProvider.notifier).state = prefs.getString('saveEmail') ?? '';
    emailEditingController.text = prefs.getString('saveEmail') ?? '';
    // ref.read(passwordLoginProvider.notifier).state = prefs.getString('savePassword') ?? '';
    passwordEditingController.text = prefs.getString('savePassword') ?? '';
  }

  Future<void> saveNextTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'emailSaveNextTime', emailEditingController.text.toLowerCase());
    await prefs.setString(
        'passwordSaveNextTime', passwordEditingController.text);
  }

  Future<void> saveEaP(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saveEmail', emailEditingController.text.toLowerCase());
    prefs.setString('savePassword', passwordEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is SignInErrorEvent) {
          Loader.hide();
          log('error');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('${state.error}'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        if (state is SignInBannedEvent) {
          Loader.hide();
          log('banned');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(Keystring.This_Acc_Banned.tr),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        if (state is SignInSuccessEvent) {
          Loader.hide();
          log('success');
          if (ref.watch(checkboxRememberProvider)) {
            saveEaP(
                emailEditingController.text, passwordEditingController.text);
            saveNextTime();
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }

        if (state is SignInMissingEvent) {
          Loader.hide();
          log('missing');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoleScreen(),
              ));
        }

        if (state is SignInLoadingEvent) {
          Loader.show(context);
        }

        if (previous is SignInLoadingEvent && state is ThingStateEvent) {
          //
        }
      },
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.background == Colors.white
                ? bgGradientColor0
                : bgGradientColor1),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Image.asset(
                      'assets/image/font_logo.png',
                      width: MediaQuery.of(context).size.width / 1.3,
                    ),
                    SizedBox(height: 64.0),
                    EditTextController(
                      onChanged: ((value) {
                        // ref.read(emailLoginProvider.notifier).state = value;
                      }),
                      controller: emailEditingController,
                      textColor: Colors.black,
                      label: Keystring.EMAIL.tr,
                      hintText: Keystring.EMAIL.tr,
                    ),
                    SizedBox(height: 30.0),
                    EditTextController(
                      obscureText: true,
                      showEye: true,
                      onChanged: ((value) {
                        // ref.read(passwordLoginProvider.notifier).state = value;
                      }),
                      controller: passwordEditingController,
                      textColor: Colors.black,
                      label: Keystring.PASSWORD.tr,
                      hintText: Keystring.PASSWORD.tr,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Theme.of(context).colorScheme.primary,
                              value: ref.watch(checkboxRememberProvider),
                              onChanged: (bool? value) {
                                setState(() {
                                  ref
                                      .read(checkboxRememberProvider.notifier)
                                      .state = value!;
                                });
                              },
                            ),
                            Text(
                              Keystring.REMEMBER.tr,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ));
                          },
                          child: Text(
                            Keystring.FORGET_PASS.tr,
                            style: textNormal,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          minimumSize: Size(double.infinity, 60)),
                      onPressed: () async {
                        log("click button dang nhap");
                        ref.read(LoginControllerProvider.notifier).login(
                              emailEditingController.text,
                              passwordEditingController.text,
                            );
                      },
                      child: Text(
                        Keystring.LOGIN.tr,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 88.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Keystring.DONT_HAVE_ACC.tr,
                          style: textNormal,
                        ),
                        SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ));
                          },
                          child: Text(
                            Keystring.SIGN_UP_NOW.tr,
                            style: textJobHome,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(Keystring.OR.tr),
                    SizedBox(height: 8.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      },
                      child: Text(
                        Keystring.USING_APP_WITHOUT.tr,
                        style: textCV,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
