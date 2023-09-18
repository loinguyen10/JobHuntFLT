import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/screen/edit_user_profile.dart';
import 'package:jobhunt_ftl/screen/viewcv.dart';

import '../blocs/app_riverpod.dart';
import '../component/loader_overlay.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({
    super.key,
    // required this.loginUId,
  });
  // String loginUId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("YOUR PROFILE"),
        backgroundColor: Colors.black,
      ),
      body: ScreenUserProfile(
          // loginUId: loginUId,
          ),
    ));
  }
}

class ScreenUserProfile extends ConsumerWidget {
  const ScreenUserProfile({
    super.key,
    // this.loginUId,
  });

  // final String? loginUId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AlertDialog dialogShow() {
      return AlertDialog(
        content: const Text('PROFILE IS BLANK'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => EditUserProfileScreen(
              //             profileDetail: getXX.userProfile.value,
              //           )),
              // );
            },
            child: const Text('OK'),
          ),
        ],
      );
    }

    final _data = ref.watch(userProfileProvider);

    return SafeArea(
      child: Scaffold(
        body: _data.when(
          data: (_data) {
            return Scaffold(
              body: Center(
                  child: Column(
                children: [
                  Text('${_data?.displayName}'),
                  Image.network(
                    _data?.avatarUrl ?? '',
                    width: 256,
                    height: 256,
                  ),
                  Text('${_data?.fullName}'),
                  Text('${_data?.email}'),
                  Text('${_data?.phone}'),
                  Text('${_data?.birthday}'),
                  Text('${_data?.address}'),
                  _data?.cvUrl != null
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewCVScreen(
                                        cv: _data?.cvUrl ?? '',
                                      )),
                            );
                          },
                          child: Text('View CV'))
                      : ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: Text('No CV')),

                  // Text('${_data?.education}'),
                  // Text('${_data?.profession}'),
                  Text(
                      '${_data?.minSalary} - ${_data?.maxSalary} ${_data?.typeSalary}'),
                  //
                ],
              )
                  //
                  ),
              floatingActionButton: FloatingActionButton(
                  child: new Icon(Icons.edit),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => EditUserProfileScreen(
                    //             profileDetail: getXX.userProfile.value,
                    //           )),
                    // );
                  }),
            );
          },
          error: (error, stackTrace) => dialogShow(),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
