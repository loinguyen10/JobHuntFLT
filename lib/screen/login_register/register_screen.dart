import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/screen/login_register/select_role_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../component/edittext.dart';
import '../../value/style.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    String emailUp = ref.watch(emailRegisterProvider);
    // var passUp = '';
    // var passAgain = '';

    void showOTPDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return OTPScreen(emailUp: emailUp);
        },
      );
    }

    void showTermsAndConditions() {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 1.25),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 0.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ]),
                    child: SingleChildScrollView(
                      child: Text(Keystring.TERM.tr, style: textNormal),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 14.0,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateOTPErrorEvent) {
          Loader.hide();
          log('error');
          Fluttertoast.showToast(
              msg: Keystring.UNSUCCESSFUL.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        if (state is CreateOTPSuccessEvent) {
          Loader.hide();
          log('success');
          showOTPDialog();
        }

        if (state is ReCreateOTPEvent) {
          Loader.hide();
          log('recreate');
        }

        if (state is CreateOTPEmailExistEvent) {
          Loader.hide();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(Keystring.EMAIL_EXIST.tr),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(Keystring.YES.tr),
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
        }

        if (state is ThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return Container(
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
                  SizedBox(height: 104.0),
                  Text(
                    'Please enter your email address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30.0),
                  EditTextForm(
                    typeKeyboard: TextInputType.emailAddress,
                    onChanged: ((value) {
                      emailUp = value;
                      ref.read(emailRegisterProvider.notifier).state =
                          value.toLowerCase();
                    }),
                    textColor: Colors.black,
                    label: Keystring.EMAIL.tr,
                    hintText: Keystring.EMAIL.tr,
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: Theme.of(context).colorScheme.primary,
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
                        InkWell(
                          onTap: () => showTermsAndConditions(),
                          child: Text(
                            Keystring.Terms_Conditions.tr,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(double.infinity, 60)),
                    onPressed: () async {
                      log('yoo $emailUp');
                      if (emailUp.isNotEmpty &&
                          ref.watch(checkboxTermProvider)) {
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
                          ref
                              .read(LoginControllerProvider.notifier)
                              .sendOTPtoMail1(emailUp, true);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: Keystring.PLS_EMAIL_AND_CHECK.tr,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Text(
                      Keystring.CONTINUE.tr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 120.0),
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
    );
  }
}

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key, required this.emailUp});
  final String emailUp;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  late Timer _timer;
  int _start = 60;
  final otpUpController = TextEditingController();

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            log('time: $_start');
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        if (state is ReCreateOTPEvent) {
          Loader.hide();
          startTimer();
          log('recreate');
        }

        if (state is CreateThingErrorEvent) {
          Loader.hide();
          log('error');
          Fluttertoast.showToast(
              msg: Keystring.OTP_fail.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        if (state is CreateThingSuccessEvent) {
          Loader.hide();
          log('success');
          Navigator.pop(context);
          _timer.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PasswordRegisterScreen()),
          );
        }
      },
    );

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(Keystring.Confirm_OTP.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(Keystring.OTP_Mail.tr),
              SizedBox(height: 16),
              EditTextForm(
                onChanged: ((value) {
                  otpUpController.text = value;
                  log('${otpUpController.text} va $value');
                }),
                textColor: Colors.black,
                hintText: 'OTP',
                autoFocus: true,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _start == 0 ? appPrimaryColor : Colors.grey,
                    ),
                    onPressed: _start == 0
                        ? () {
                            ref
                                .read(LoginControllerProvider.notifier)
                                .sendOTPtoMail1(widget.emailUp, false);

                            log('Resend OTP button pressed');
                            setState(() {
                              _start = 60;
                            });
                          }
                        : null,
                    child: Text(_start == 0
                        ? Keystring.Resend_OTP.tr
                        : _start.toString()),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appPrimaryColor,
                    ),
                    onPressed: () {
                      ref
                          .read(LoginControllerProvider.notifier)
                          .checkOTP1(otpUpController.text, widget.emailUp);
                    },
                    child: Text(Keystring.OK.tr),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class PasswordRegisterScreen extends ConsumerStatefulWidget {
  const PasswordRegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PasswordRegisterScreenState();
}

class _PasswordRegisterScreenState
    extends ConsumerState<PasswordRegisterScreen> {
  final passUpController = TextEditingController();
  final passAgainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String emailUp = ref.watch(emailRegisterProvider);
    // String passUp = '';
    // String passAgain = '';

    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is SignUpErrorEvent) {
          Loader.hide();
          log('error');
          Fluttertoast.showToast(
              msg: Keystring.SIGN_IN_FAILED.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
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

    return Container(
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
                  SizedBox(height: 104.0),
                  Text(
                    'Please enter your password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30.0),
                  EditTextForm(
                    obscureText: true,
                    showEye: true,
                    onChanged: ((value) {
                      passUpController.text = value;
                      log(passUpController.text + '_' + value);
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
                      passAgainController.text = value;
                    }),
                    textColor: Colors.black,
                    label: Keystring.PASSWORD_AGAIN.tr,
                    hintText: Keystring.PASSWORD_AGAIN.tr,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(double.infinity, 60)),
                    onPressed: () async {
                      log('yoo1 $emailUp - ${passUpController.text}');
                      if (passUpController.text.isNotEmpty &&
                          passAgainController.text.isNotEmpty) {
                        if (passUpController.text != passAgainController.text) {
                          Fluttertoast.showToast(
                              msg: Keystring.NEED_SAME_PASS.tr,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          log('yoo1 $emailUp - ${passUpController.text}');
                          if (checkPassword(passUpController.text)) {
                            ref
                                .read(LoginControllerProvider.notifier)
                                .register(emailUp, passUpController.text);
                          }
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
                      Keystring.CONTINUE.tr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 156.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
