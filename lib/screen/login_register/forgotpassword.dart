import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/editcontroller.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/login_register/changepass.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:jobhunt_ftl/value/style.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int countdown = 90;
    final TextEditingController emailController = TextEditingController();
    // final TextEditingController otpController = TextEditingController();
    final email = ref.watch(emailsaveProvider);
    String otp = "";

    void _showOTPDialog() {
      TextEditingController otpController = TextEditingController();
      bool isResendButtonEnabled = true;
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(Keystring.Confirm_OTP.tr),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(Keystring.OTP_Mail.tr),
                    TextField(
                      controller: otpController,
                      decoration: InputDecoration(labelText: 'OTP'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appPrimaryColor,
                          ),
                          onPressed: isResendButtonEnabled
                              ? () {
                                  ref.read(emailsaveProvider.notifier).state =
                                      emailController.text;
                                  ref
                                      .read(LoginControllerProvider.notifier)
                                      .sendOTPtoMail(email);

                                  log('Resend OTP button pressed');
                                  setState(() {
                                    isResendButtonEnabled = false;
                                  });

                                  Future.delayed(Duration(seconds: countdown),
                                      () {
                                    setState(() {
                                      isResendButtonEnabled = true;
                                    });
                                  });
                                }
                              : null,
                          child: Text(Keystring.Resend_OTP.tr),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appPrimaryColor,
                          ),
                          onPressed: () {
                            otp = otpController.text;
                            log(otp + "otp");
                            log(email + "mail");
                            ref
                                .read(JobViewControllerProvider.notifier)
                                .checkOTP(otp, email);
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent) {
          Loader.hide();
          log('error');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(Keystring.Get_OTP_Fail.tr),
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

        if (state is CreateThingSuccessEvent) {
          Loader.hide();
          log('success');
          _showOTPDialog();
        }

        if (state is ThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    //getotp
    ref.listen<InsideEvent>(
      JobViewControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent) {
          Loader.hide();
          log('error');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(Keystring.OTP_fail.tr),
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

        if (state is CreateThingSuccessEvent) {
          Loader.hide();
          log('success');
          log('email1:${email}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePassword(email: email),
            ),
          );
        }

        if (state is ThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        title: Text(Keystring.FORGET_PASS.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EditTextController(
              onChanged: ((value) {
                // ref.read(emailLoginProvider.notifier).state = value;
              }),
              controller: emailController,
              textColor: Colors.black,
              label: Keystring.EMAIL.tr,
              hintText: Keystring.EMAIL.tr,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: () {
                // Kiểm tra tính hợp lệ của địa chỉ email trước khi gửi OTP
                if (emailController.text.trim().isEmpty ||
                    !RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(emailController.text)) {
                  // Hiển thị thông báo lỗi nếu địa chỉ email không hợp lệ
                  Fluttertoast.showToast(
                      msg: Keystring.EMAIL_VALIDATION.tr,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  // Gửi OTP khi địa chỉ email hợp lệ
                  ref.read(emailsaveProvider.notifier).state =
                      emailController.text;
                  log(email);
                  ref
                      .read(LoginControllerProvider.notifier)
                      .sendOTPtoMail(email);
                }
              },
              child: Text(Keystring.Get_OTP.tr),
            ),
          ],
        ),
      ),
    );
  }
}
