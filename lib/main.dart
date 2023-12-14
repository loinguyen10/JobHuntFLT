import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/firebase_options.dart';
import 'package:jobhunt_ftl/screen/login_register/login_sreen.dart';
import 'package:jobhunt_ftl/screen/splash_screen.dart';
import 'package:jobhunt_ftl/value/string.dart';
import 'package:jobhunt_ftl/value/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var languagueSeleted =
      prefs.getString('language') ?? Get.deviceLocale!.languageCode;

  if (Get.deviceLocale!.languageCode != 'vi' &&
      Get.deviceLocale!.languageCode != 'en') {
    languagueSeleted = 'en';
  }

  var skipSplash = prefs.getBool('splash') ?? false;
  // var emailTemp = prefs.getString('emailTemp') ?? '';
  // var passTemp = prefs.getString('passTemp') ?? '';

  runApp(ProviderScope(
      child: MyApp(
    language: languagueSeleted,
    skipSplash: skipSplash,
  )));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.language, required this.skipSplash});
  final String language;
  final bool skipSplash;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'),
        Locale('en'),
      ],
      translations: LocaleString(),
      locale: Locale(language),
      home: skipSplash ? const LoginScreen() : const SplashScreen(),
      builder: EasyLoading.init(),
      theme: appLightTheme,
    );
  }
}
