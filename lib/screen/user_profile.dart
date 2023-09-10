import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_state.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:jobhunt_ftl/screen/edit_user_profile.dart';
import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/screen/viewcv.dart';

import '../component/loader_overlay.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key, required this.loginUId});
  String loginUId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsideBloc, InsideState>(
      builder: (context, state) {
        log('profile: ${state.getUserProfileStatus}');
        if (state.getUserProfileStatus == GetUserProfileStatus.loading) {
          Loader.show(context);
        }

        if (state.getUserProfileStatus == GetUserProfileStatus.success ||
            state.getUserProfileStatus == GetUserProfileStatus.failure) {
          Loader.hide();
        }

        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text("USER PROFILE"),
            backgroundColor: Colors.black,
          ),
          body: ScreenUserProfile(
            loginUId: loginUId,
            profileDetail: state.userProfileDetail,
          ),
        ));
      },
    );
  }
}

class ScreenUserProfile extends StatefulWidget {
  ScreenUserProfile({
    super.key,
    this.loginUId,
    this.profileDetail,
  });
  String? loginUId;
  UserProfileDetail? profileDetail;

  @override
  State<ScreenUserProfile> createState() => _ScreenUserProfile();
}

class _ScreenUserProfile extends State<ScreenUserProfile> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<InsideBloc>(context)
        .add(GetUserProfileEvent(uId: widget.loginUId ?? ''));
  }

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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditUserProfileScreen(
                      profileDetail: widget.profileDetail,
                    )),
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.profileDetail != null
        ? Scaffold(
            body: Center(
                child: Column(
              children: [
                Image.network(
                  widget.profileDetail?.avatarUrl ?? '',
                  width: 256,
                  height: 256,
                ),
                widget.profileDetail?.cvUrl != null
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCVScreen(
                                      cv: widget.profileDetail?.cvUrl ?? '',
                                    )),
                          );
                        },
                        child: Text('View CV'))
                    : ElevatedButton(
                        onPressed: () {
                          //
                        },
                        child: Text('No CV')),
                Text('${widget.profileDetail?.education}'),
                Text('${widget.profileDetail?.profession}'),
                Text(
                    '${widget.profileDetail?.minSalary} - ${widget.profileDetail?.maxSalary} ${widget.profileDetail?.typeSalary}'),
                //
              ],
            )
                //
                ),
            floatingActionButton: FloatingActionButton(
                child: new Icon(Icons.edit),
                onPressed: () {
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUserProfileScreen(
                              profileDetail: widget.profileDetail,
                            )),
                  );
                }),
          )
        :
        // SizedBox(
        //     height: 10,
        //   )

        dialogShow();
  }
}
