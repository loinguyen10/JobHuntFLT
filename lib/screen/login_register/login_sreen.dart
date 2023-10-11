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
import 'package:jobhunt_ftl/screen/login_register/register_screen.dart';
import 'package:jobhunt_ftl/screen/login_register/select_role_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/app_riverpod_void.dart';
import '../../value/style.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailEditingController = TextEditingController();
    TextEditingController passwordEditingController = TextEditingController();

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

        if (state is SignInSuccessEvent) {
          Loader.hide();
          log('success');
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
      },
    );

    Future<void> saveEaP(String email, String password) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('saveEmail', ref.watch(emailLoginProvider));
      prefs.setString('savePassword', ref.watch(passwordLoginProvider));
    }

    Future<void> loadEaP() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      ref.read(emailLoginProvider.notifier).state =
          prefs.getString('saveEmail') ?? '';
      emailEditingController.text = prefs.getString('saveEmail') ?? '';
      ref.read(passwordLoginProvider.notifier).state =
          prefs.getString('savePassword') ?? '';
      passwordEditingController.text = prefs.getString('savePassword') ?? '';
    }

    // loadEaP();

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: bgGradientColor),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    // Text(
                    //   Keystring.APP_NAME.tr,
                    //   style: GoogleFonts.josefinSans(textStyle: textLogo),
                    // ),
                    Image.asset(
                      'assets/image/font_logo.png',
                      width: MediaQuery.of(context).size.width / 1.3,
                    ),
                    SizedBox(height: 50.0),
                    EditTextController(
                      onChanged: ((value) {
                        ref.read(emailLoginProvider.notifier).state = value;
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
                        ref.read(passwordLoginProvider.notifier).state = value;
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
                              checkColor: Colors.white,
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(Keystring.FORGET_PASS.tr),
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
                        if (ref.watch(checkboxRememberProvider)) {
                          saveEaP(ref.watch(emailLoginProvider),
                              ref.watch(passwordLoginProvider));
                        }

                        ref.read(LoginControllerProvider.notifier).login(
                              ref.watch(emailLoginProvider),
                              ref.watch(passwordLoginProvider),
                            );
                      },
                      child: Text(
                        Keystring.LOGIN.tr,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 2,
                          width: 80,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12),
                        Text(
                          Keystring.SIGN_IN_WITH.tr,
                          style: textNormal,
                        ),
                        SizedBox(width: 12),
                        Container(
                          height: 2,
                          width: 80,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('google'),
                        ));
                      },
                      child: ClipOval(
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(24), // Image radius
                            child:
                                // Image.network('https://pngimg.com/uploads/google/google_PNG19635.png',fit: BoxFit.cover,)),
                                Image.asset(
                              'assets/image/google_logo.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SizedBox(height: 32.0),
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
                        resetCall(ref);
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
