import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.only(top: 10),
        children: [
          ListTile(
            title: Text('YOUR PROFILE'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => UserProfileScreen(
              //           // loginUId: user.uid ?? '',
              //           )),
              // );
            },
          ),
          ListTile(
            title: Text('FOLLOW CV'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('CHANGE PASSWORD'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('SETTING'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('ABOUT'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('EXIT'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('EXIT?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Loader.show(context);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => LoginScreen(),
                          //     ));
                          // ref.read(emailLoginProvider.notifier).state = '';
                          // ref.read(passwordLoginProvider.notifier).state = '';
                          // // ref.read(userLoginProvider.notifier).state = null;
                          // Loader.hide();
                        },
                        child: const Text('YES'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
