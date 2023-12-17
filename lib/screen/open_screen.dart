import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/screen/login_register/login_sreen.dart';
import 'package:jobhunt_ftl/screen/splash_screen.dart';
import 'package:jobhunt_ftl/value/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class FirstScreen extends ConsumerWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> runJH() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var skipSplash = prefs.getBool('splash') ?? false;

      log('$skipSplash');

      if (skipSplash) {
        var emailTemp = prefs.getString('emailSaveNextTime') ?? '';
        var passTemp = prefs.getString('passwordSaveNextTime') ?? '';

        ref.read(LoginControllerProvider.notifier).login(emailTemp, passTemp);
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ));
      }
    }

    runJH();

    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is SignInErrorEvent || state is SignInMissingEvent) {
          log('error');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
        }

        if (state is SignInSuccessEvent) {
          log('success');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }

        if (previous is SignInLoadingEvent && state is ThingStateEvent) {
          runJH();
        }
      },
    );

    return Container(
      color: Colors.orange[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Image.asset(
              'assets/image/font_logo.png',
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width / 20,
            height: MediaQuery.of(context).size.width / 20,
            child: CircularProgressIndicator(
              color: appPrimaryColor,
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
