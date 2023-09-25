import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/edit_profile.dart';
import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../component/edittext.dart';
import '../value/style.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // return BlocConsumer<InsideBloc, InsideState>(
//     //   builder: (context, state) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("LOGIN"),
//         backgroundColor: Colors.black,
//       ),
//       body: ScreenLogin(),
//     );
//   },
//   listener: (context, state) {
// log('login: ${state.loginStatus}');
// if (state.loginStatus == LoginStatus.loading) {
//   Loader.show(context);
// }
// if (state.loginStatus == LoginStatus.success) {
//   Loader.hide();
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (context) => HomeScreen(),
//     ),
//   );
// } else {
//   Loader.hide();
// }
// },
// );
//   }
// }

// class ScreenLogin extends StatefulWidget {
//   const ScreenLogin({super.key});
//   @override
//   State<ScreenLogin> createState() => _ScreenLogin();
// }

// class _ScreenLogin extends State<ScreenLogin> {
//   final getXX = Get.put(InsideGetX());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 5),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 30.0),
//               EditTextForm(
//                 onChanged: ((value) {
//                   // BlocProvider.of<InsideBloc>(context)
//                   //     .add(LoginEmailChangedEvent(email: value));
//                   getXX.getEmailLoginString(value);
//                 }),
//                 textColor: Colors.black,
//                 borderSelected: Colors.orange,
//                 label: 'Username',
//                 hintText: 'Username',
//               ),
//               SizedBox(height: 30.0),
//               EditTextForm(
//                 obscureText: true,
//                 showEye: true,
//                 onChanged: ((value) {
//                   // BlocProvider.of<InsideBloc>(context)
//                   //     .add(LoginPasswordChangedEvent(password: value));
//                   getXX.getPasswordLoginString(value);
//                 }),
//                 textColor: Colors.black,
//                 borderSelected: Colors.orange,
//                 // controller: _passController,
//                 label: 'Password',
//                 hintText: 'Password',
//               ),
//               SizedBox(height: 50.0),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                     minimumSize: Size(double.infinity, 60)),
//                 onPressed: () async {
//                   log("click button dang nhap");
//                   // BlocProvider.of<InsideBloc>(context)
//                   //     .add(LoginButtonPressedEvent());
//                   await getXX.loginApp();
//                   if (getXX.loginCheck.value) {
//                     Get.off(() => HomeScreen());
//                   }
//                 },
//                 child: Text(
//                   'LOGIN',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is SignInErrorEvent) {
          Loader.hide();
          log('error');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('${state.error}'),
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

        if (state is SignInSuccessEvent) {
          Loader.hide();
          log('success');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }

        if (state is SignInMissingEvent) {
          Loader.hide();
          log('missing');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreenNew(),
              ));
        }

        if (state is SignInLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return SafeArea(
      child: Scaffold(
        //   appBar: AppBar(
        //     title: Text("LOGIN"),
        //     backgroundColor: Colors.black,
        //   ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.0),
                  Text(Keystring.APP_NAME.tr),
                  SizedBox(height: 50.0),
                  EditTextForm(
                    onChanged: ((value) {
                      ref.read(emailLoginProvider.notifier).state = value;
                    }),
                    textColor: Colors.black,
                    label: Keystring.EMAIL.tr,
                    hintText: Keystring.EMAIL.tr,
                  ),
                  SizedBox(height: 30.0),
                  EditTextForm(
                    obscureText: true,
                    showEye: true,
                    onChanged: ((value) {
                      ref.read(passwordLoginProvider.notifier).state = value;
                    }),
                    textColor: Colors.black,
                    label: Keystring.PASSWORD.tr,
                    hintText: Keystring.PASSWORD.tr,
                  ),
                  SizedBox(height: 50.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: appPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(double.infinity, 60)),
                    onPressed: () async {
                      log("click button dang nhap");
                      ref.read(LoginControllerProvider.notifier).login(
                            ref.watch(emailLoginProvider),
                            ref.watch(passwordLoginProvider),
                          );
                    },
                    child: Text(
                      Keystring.LOGIN.tr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
