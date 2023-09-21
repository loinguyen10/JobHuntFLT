import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/screen/edit_profile.dart';
import 'package:jobhunt_ftl/firebase_options.dart';
import 'package:jobhunt_ftl/screen/loginsreen.dart';
import 'package:jobhunt_ftl/value/string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
      translations: LocaleString(),
      locale: Locale('en', 'US'),
      // home: LoginScreen(),
      home: EditProfileScreenNew(),
      builder: EasyLoading.init(),
    );
  }
}
