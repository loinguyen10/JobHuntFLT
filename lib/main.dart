import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/screen/edit_job.dart';
import 'package:jobhunt_ftl/screen/edit_profile.dart';
import 'package:jobhunt_ftl/firebase_options.dart';
import 'package:jobhunt_ftl/screen/edit_recuiter.dart';
import 'package:jobhunt_ftl/screen/login_sreen.dart';
import 'package:jobhunt_ftl/value/string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(ProviderScope(child: MyApp()));
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
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
      translations: LocaleString(),
      locale: Locale('en', 'US'),
      home: LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
