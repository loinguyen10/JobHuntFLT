import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/user/edit_profile.dart';
import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/screen/login_register/select_role_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../../blocs/app_riverpod_void.dart';
import '../../component/edittext.dart';
import '../../value/style.dart';

class RegisterScreen extends ConsumerWidget {
  var emailUp = '';
  var passUp = '';
  var passAgain = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is SignUpErrorEvent) {
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

        if (state is SignUpSuccessEvent) {
          Loader.hide();
          log('success');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RoleScreen(),
              ));
        }

        if (state is SignUpLoadingEvent) {
          Loader.show(context);
        }
      },
    );

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
                    Text(
                      Keystring.APP_NAME.tr,
                      style: GoogleFonts.josefinSans(textStyle: textLogo),
                    ),
                    SizedBox(height: 50.0),
                    EditTextForm(
                      typeKeyboard: TextInputType.emailAddress,
                      onChanged: ((value) {
                        emailUp = value;
                      }),
                      textColor: Colors.black,
                      label: Keystring.EMAIL.tr,
                      hintText: Keystring.EMAIL.tr,
                    ),
                    SizedBox(height: 30.0),
                    EditTextForm(
                      obscureText: true,
                      showEye: true,
                      onChanged: ((value) {
                        passUp = value;
                      }),
                      textColor: Colors.black,
                      label: Keystring.PASSWORD.tr,
                      hintText: Keystring.PASSWORD.tr,
                    ),
                    SizedBox(height: 30.0),
                    EditTextForm(
                      obscureText: true,
                      showEye: true,
                      onChanged: ((value) {
                        passAgain = value;
                      }),
                      textColor: Colors.black,
                      label: Keystring.PASSWORD_AGAIN.tr,
                      hintText: Keystring.PASSWORD_AGAIN.tr,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          // fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: ref.watch(checkboxTermProvider),
                          onChanged: (bool? value) {
                            ref.read(checkboxTermProvider.notifier).state =
                                value!;
                          },
                        ),
                        Text(
                          Keystring.READ_ACCEPTED.tr,
                        ),
                        SizedBox(width: 2),
                        Text(
                          Keystring.Terms_Conditions.tr,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          minimumSize: Size(double.infinity, 60)),
                      onPressed: () async {
                        log("$emailUp + $passUp + $passAgain");
                        if (emailUp.isNotEmpty &&
                            passUp.isNotEmpty &&
                            passAgain.isNotEmpty &&
                            ref.watch(checkboxTermProvider)) {
                          if (passUp != passAgain) {
                            Fluttertoast.showToast(
                                msg: Keystring.NEED_SAME_PASS.tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          if (!emailUp.contains('@') ||
                              !(emailUp.substring(emailUp.indexOf('@')))
                                  .contains('.') ||
                              emailUp.lastIndexOf('.') == emailUp.length - 1) {
                            Fluttertoast.showToast(
                                msg: Keystring.EMAIL_VALIDATION.tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            ref.read(emailLoginProvider.notifier).state =
                                emailUp;
                            ref.read(LoginControllerProvider.notifier).register(
                                  emailUp,
                                  passUp,
                                );
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: Keystring.NOT_FULL_DATA.tr,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Text(
                        Keystring.REGISTER.tr,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 80.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Keystring.HAVE_ACC.tr,
                          style: textNormal,
                        ),
                        SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            Keystring.SIGN_IN_NOW.tr,
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
