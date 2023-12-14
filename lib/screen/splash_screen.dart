import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/screen/login_register/login_sreen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> skipSplash() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('splash', true);
    }

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.orange[300],
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.35,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                  image: AssetImage('assets/image/splash.png'),
                ),
              ),
            ),
            Positioned(
                bottom: 56,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Keystring.SPLASH_TITLE.tr.toUpperCase(),
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 20),
                      Text(
                        Keystring.SPLASH_TILE.tr.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32),
                      AppButton(
                        onPressed: () {
                          skipSplash();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        label: Keystring.GET_STARTED.tr,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
