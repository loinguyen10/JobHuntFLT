import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/value/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../value/keystring.dart';
import '../../value/style.dart';

class ThemeSelectScreen extends StatefulWidget {
  const ThemeSelectScreen({super.key});

  @override
  State<ThemeSelectScreen> createState() => _ThemeSelectScreenState();
}

class _ThemeSelectScreenState extends State<ThemeSelectScreen> {
// class ThemeSelectScreen extends StatelessWidget {
//   const ThemeSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> setTheme(bool theme) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('theme', theme);
    }

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: Text(Keystring.THEME.tr),
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Theme.of(context).colorScheme.background !=
                          Colors.white) {
                        setTheme(true);
                        Get.changeTheme(appLightTheme);
                        setState(() {});
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
                            Row(
                              children: [
                                Icon(
                                  Icons.light_mode,
                                  size: 32,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  Keystring.LIGHT.tr,
                                  style: textMenu,
                                ),
                              ],
                            ),
                            Theme.of(context).colorScheme.background ==
                                    Colors.white
                                ? Icon(Icons.done)
                                : SizedBox(width: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (Theme.of(context).colorScheme.background !=
                          Colors.black) {
                        setTheme(false);
                        Get.changeTheme(appDarkTheme);
                        setState(() {});
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
                            Row(
                              children: [
                                Icon(
                                  Icons.dark_mode,
                                  size: 32,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  Keystring.DARK.tr,
                                  style: textMenu,
                                ),
                              ],
                            ),
                            Theme.of(context).colorScheme.background ==
                                    Colors.black
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
