import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// import 'package:jobhunt_ftl/blocs/app_bloc.dart';
// import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_getx.dart';
// import 'package:jobhunt_ftl/blocs/app_state.dart';
// import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
// import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:jobhunt_ftl/screen/edit_user_profile.dart';
// import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/screen/viewcv.dart';

import '../component/loader_overlay.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key, required this.loginUId});
  String loginUId;

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<InsideBloc, InsideState>(
    //   builder: (context, state) {
    //     log('profile: ${state.getUserProfileStatus}');
    //     if (state.getUserProfileStatus == GetUserProfileStatus.loading) {
    //       Loader.show(context);
    //     }

    //     if (state.getUserProfileStatus == GetUserProfileStatus.success ||
    //         state.getUserProfileStatus == GetUserProfileStatus.failure) {
    //       Loader.hide();
    //     }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("YOUR PROFILE"),
        backgroundColor: Colors.black,
      ),
      body: ScreenUserProfile(
        loginUId: loginUId,
        // profileDetail: state.userProfileDetail,
      ),
    ));
    //   },
    // );
  }
}

class ScreenUserProfile extends StatefulWidget {
  ScreenUserProfile({
    super.key,
    this.loginUId,
    // this.profileDetail,
  });
  String? loginUId;
  UserProfileDetail? profileDetail;

  @override
  State<ScreenUserProfile> createState() => _ScreenUserProfile();
}

class _ScreenUserProfile extends State<ScreenUserProfile> {
  final getXX = Get.put(InsideGetX());

  @override
  void initState() {
    super.initState();

    // BlocProvider.of<InsideBloc>(context).add(GetUserProfileEvent(uId: widget.loginUId ?? ''));

    getXX.getUserProfile(widget.loginUId ?? '');
  }

  AlertDialog dialogShow() {
    return AlertDialog(
      content: const Text('PROFILE IS BLANK'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Get.to(() => EditUserProfileScreen(
                profileDetail: getXX.userProfile?.value,
              )),
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => getXX.userProfile.value.id != null
          ? Scaffold(
              body: Center(
                  child: Column(
                children: [
                  Text('${getXX.userProfile.value.displayName}'),
                  Image.network(
                    getXX.userProfile.value.avatarUrl ?? '',
                    width: 256,
                    height: 256,
                  ),
                  Text('${getXX.userProfile.value.fullName}'),
                  Text('${getXX.userProfile.value.email}'),
                  Text('${getXX.userProfile.value.phone}'),
                  Text('${getXX.userProfile.value.birthday}'),
                  Text('${getXX.userProfile.value.address}'),
                  getXX.userProfile.value.cvUrl != null
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewCVScreen(
                                        cv: getXX.userProfile.value.cvUrl ?? '',
                                      )),
                            );
                          },
                          child: Text('View CV'))
                      : ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: Text('No CV')),

                  // Text('${getXX.userProfile.value.education}'),
                  // Text('${getXX.userProfile.value.profession}'),
                  Text(
                      '${getXX.userProfile.value.minSalary} - ${getXX.userProfile.value.maxSalary} ${getXX.userProfile.value.typeSalary}'),
                  //
                ],
              )
                  //
                  ),
              floatingActionButton: FloatingActionButton(
                  child: new Icon(Icons.edit),
                  onPressed: () {
                    //
                    Get.to(() => EditUserProfileScreen(
                          profileDetail: getXX.userProfile.value,
                        ));
                  }),
            )
          : dialogShow(),
    );
  }
}
