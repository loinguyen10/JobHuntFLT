import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/screen/user/edit_profile.dart';
import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/screen/login_register/register_screen.dart';
import 'package:jobhunt_ftl/screen/login_register/select_role_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/app_riverpod_void.dart';
import '../../component/edittext.dart';
import '../../value/style.dart';

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
  var check = false;

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
                builder: (context) => RoleScreen(),
              ));
        }

        if (state is SignInLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: bgGradientColor),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      Keystring.APP_NAME.tr,
                      style: GoogleFonts.josefinSans(textStyle: textLogo),
                    ),
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
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: check,
                              onChanged: (bool? value) {
                                check = value!;
                              },
                            ),
                            Text(
                              Keystring.REMEMBER.tr,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(Keystring.FORGET_PASS.tr),
                            ));
                          },
                          child: Text(
                            Keystring.FORGET_PASS.tr,
                            style: textNormal,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30.0),
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
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 2,
                          width: 80,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12),
                        Text(
                          Keystring.SIGN_IN_WITH.tr,
                          style: textNormal,
                        ),
                        SizedBox(width: 12),
                        Container(
                          height: 2,
                          width: 80,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('google'),
                        ));
                      },
                      child: ClipOval(
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(24), // Image radius
                            child: Image.network(
                              'https://pngimg.com/uploads/google/google_PNG19635.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Keystring.DONT_HAVE_ACC.tr,
                          style: textNormal,
                        ),
                        SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ));
                          },
                          child: Text(
                            Keystring.SIGN_UP_NOW.tr,
                            style: textJobHome,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(Keystring.OR.tr),
                    SizedBox(height: 8.0),
                    InkWell(
                      onTap: () {
                        resetCall(ref);
                      },
                      child: Text(
                        Keystring.USING_APP_WITHOUT.tr,
                        style: textCV,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
