import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/login_register/login_sreen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
class ChangePassword extends ConsumerStatefulWidget {
  const  ChangePassword ( {super.key,required this.email});

final String email;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {

  bool isPasswordHidden = true;
  bool _isCheckboxChecked = false;
 final TextEditingController _emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String password= "";
  @override
  Widget build(BuildContext context) {

    ref.listen<InsideEvent>(
      ChangePassControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent) {
          Loader.hide();
          log('error');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(Keystring.password_fail.tr),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Keystring.Changepass_SuccessNotfication.tr),
          
        ),
      );
       
        }

        if (state is ThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(Keystring.Changepass.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPasswordField(Keystring.NewPass.tr, _emailController),
            SizedBox(height: 16.0),
            buildPasswordField(Keystring.Confirmpass.tr, confirmPasswordController),
            SizedBox(height: 16.0),
            buildCheckbox(),
            SizedBox(height: 16.0),
            buildChangePasswordButton(),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isPasswordHidden,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(isPasswordHidden ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordHidden = !isPasswordHidden;
            });
          },
        ),
      ),
    );
  }

  Widget buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: isCheckboxChecked,
          onChanged: (value) {
            setState(() {
              isCheckboxChecked = value!;
            });
          },
        ),
        Text(Keystring.ConfirmCheckbox.tr),
      ],
    );
  }

 Widget buildChangePasswordButton() {
    return ElevatedButton(
      onPressed: isCheckboxChecked ? () => changePassword() : null,
      child: Text(Keystring.Changepass.tr),
    );
  }

  bool get isPasswordsMatch =>
      _emailController.text == confirmPasswordController.text;

  bool get isCheckboxChecked => _isCheckboxChecked;
  set isCheckboxChecked(bool value) {
    setState(() {
      _isCheckboxChecked = value;
    });
  }

  void changePassword() {
  if (isPasswordsMatch) {
    password = _emailController.text;
    ref.read(ChangePassControllerProvider.notifier).newPass(password, widget.email);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Keystring.Changepass_FailNotification.tr),
      ),
    );
  }
}


}