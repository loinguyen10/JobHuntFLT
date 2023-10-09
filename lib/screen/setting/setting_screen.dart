import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:jobhunt_ftl/value/style.dart';

import 'languague_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appHintColor,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: Text(Keystring.SETTING.tr),
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => LanguageSelectScreen()),
                      // );
                    },
                    child: Card(
                      shadowColor: Colors.grey,
                      shape: Border.all(color: Colors.white, width: 2),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.light_mode,
                              size: 32,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              Keystring.THEME.tr,
                              style: textMenu,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LanguageSelectScreen()),
                      );
                    },
                    child: Card(
                      shadowColor: Colors.grey,
                      shape: Border.all(color: Colors.white, width: 2),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.translate,
                              size: 32,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              Keystring.LANGUAGE.tr,
                              style: textMenu,
                            ),
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
