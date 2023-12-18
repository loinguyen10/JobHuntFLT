import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/screen/login_register/login_sreen.dart';
import 'package:jobhunt_ftl/screen/user/edit_recuiter.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../../value/style.dart';
import '../user/edit_profile.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  @override
  Widget build(BuildContext context) {
    void confirmDialog(String role) {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: Text(
                "${Keystring.You_Are.tr} $role?".toUpperCase(),
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (role == Keystring.CANDIDATE.tr) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreenNew(),
                          ));
                    } else if (role == Keystring.RECRUITER.tr) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecuiterEditScreen(),
                          ));
                    }
                  },
                  child: Text(Keystring.ThatsRight.tr),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(Keystring.CANCEL.tr),
                ),
              ],
            ),
          );
        },
      );
    }

    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30.0),
          Text(
            "${Keystring.Welcome_to.tr} ${Keystring.APP_NAME.tr}",
            style: textTitleRole,
          ),
          SizedBox(height: 28.0),
          Text(
            Keystring.Please_Set_Role.tr,
            style: textTitleRole,
          ),
          SizedBox(height: 50.0),
          AppButton(
            onPressed: () {
              confirmDialog(Keystring.CANDIDATE.tr);
            },
            label: Keystring.CANDIDATE.tr,
            width: MediaQuery.of(context).size.width / 2,
            fontSize: 16,
            padding: EdgeInsets.symmetric(vertical: 12),
            margin: EdgeInsets.symmetric(vertical: 12),
          ),
          // SizedBox(
          //   width: 30,
          // ),
          AppButton(
            onPressed: () {
              confirmDialog(Keystring.RECRUITER.tr);
            },
            label: Keystring.RECRUITER.tr,
            width: MediaQuery.of(context).size.width / 2,
            fontSize: 16,
            padding: EdgeInsets.symmetric(vertical: 12),
            margin: EdgeInsets.symmetric(vertical: 12),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    ));
  }
}
