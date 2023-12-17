import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../value/keystring.dart';
import '../../value/style.dart';

class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('${Get.locale}');

    Future<void> setLanguage(String language) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('language', language);
    }

    return Container(
      color: appHintColor,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: Text(Keystring.LANGUAGE.tr),
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              elevation: 0,
              foregroundColor: Theme.of(context).colorScheme.background,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Get.locale != 'vi') {
                        Get.updateLocale(Locale('vi'));
                        setLanguage('vi');
                      }
                    },
                    child: Card(
                      shadowColor: Colors.grey,
                      shape: Border.all(color: Colors.white, width: 2),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background),
                        padding: EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Keystring.VIETNAMESE.tr,
                              style: textMenu,
                            ),
                            Get.locale!.languageCode == 'vi'
                                ? Icon(Icons.done)
                                : SizedBox(width: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (Get.locale != 'en') {
                        Get.updateLocale(Locale('en'));
                        setLanguage('en');
                      }
                    },
                    child: Card(
                      shadowColor: Colors.grey,
                      shape: Border.all(color: Colors.white, width: 2),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background),
                        padding: EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Keystring.ENGLISH.tr,
                              style: textMenu,
                            ),
                            Get.locale!.languageCode == 'en'
                                ? Icon(Icons.done)
                                : SizedBox(width: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
