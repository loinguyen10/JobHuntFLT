import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/login_register/changepass.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
     int countdown = 90;
    late Timer timer;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController otpController = TextEditingController();
    final email=         ref.      watch     (emailsaveProvider);
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
                      onPressed: isResendButtonEnabled
                          ? () {
                             
                             ref.read(emailsaveProvider.notifier).state=emailController.text;
                           ref.read(LoginControllerProvider.notifier).sendOTPtoMail(email);
                           
                              log('Resend OTP button pressed');
                              setState(() {
                                isResendButtonEnabled = false;
                              });

                              Future.delayed(Duration(seconds: 60), () {
                                setState(() {
                                  isResendButtonEnabled = true;
                                });
                              });
                            }
                          : null,
                      child: Text(Keystring.Resend_OTP.tr),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        otp = otpController.text;
                        log(otp + "otp");
                        log(email + "mail");
                        ref.read(JobViewControllerProvider.notifier).checkOTP(otp, email);
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
              ));
        }

        if (state is ThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref.read(emailsaveProvider.notifier).state=emailController.text;
           
              ref.read(LoginControllerProvider.notifier).sendOTPtoMail(email);
            },
            child: Text(Keystring.Get_OTP.tr),
          ),
        ],
      ),
    );
  }
}
