import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/login_register/login_sreen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../../component/edittext.dart';
import '../../value/style.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key, required this.email});

  final String email;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  bool isPasswordHidden = true;
  bool _isCheckboxChecked = false;
  final TextEditingController _emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String password = "";
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
                content: Text(Keystring.Something_Wrong.tr),
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
          Fluttertoast.showToast(
              msg: Keystring.Changepass_SuccessNotfication.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
          Loader.hide();
        }

        if (state is ThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(Keystring.Changepass.tr),
        backgroundColor: appPrimaryColor,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EditTextForm(
              obscureText: true,
              showEye: true,
              onChanged: ((value) {
                _emailController.text = value;
              }),
              textColor: Colors.black,
              label: Keystring.NewPass.tr,
              hintText: Keystring.NewPass.tr,
            ),
            SizedBox(height: 16.0),
            EditTextForm(
              obscureText: true,
              showEye: true,
              onChanged: ((value) {
                confirmPasswordController.text = value;
              }),
              textColor: Colors.black,
              label: Keystring.Confirmpass.tr,
              hintText: Keystring.Confirmpass.tr,
            ),
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
    return TextFormField(
      controller: controller,
      obscureText: isPasswordHidden,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon:
              Icon(isPasswordHidden ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordHidden = !isPasswordHidden;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null; // return null if the input is valid
      },
    );
  }

  Widget buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          checkColor: Theme.of(context).colorScheme.primary,
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
      style: ElevatedButton.styleFrom(
        backgroundColor: appPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(double.infinity, 60),
      ),
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
      if (checkPassword(password)) {
        ref
            .read(ChangePassControllerProvider.notifier)
            .newPass(password, widget.email);
      }
    } else {
      Fluttertoast.showToast(
          msg: Keystring.NEED_SAME_PASS.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
