import 'dart:convert';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';

final LoginControllerProvider =
    StateNotifierProvider<LoginController, InsideEvent>((ref) {
  return LoginController(ref);
});

class LoginController extends StateNotifier<InsideEvent> {
  LoginController(this.ref) : super(const SignInStateEvent());

  final Ref ref;

  void login(String email, String password) async {
    state = const SignInLoadingEvent();
    log('$email + $password');
    try {
      final user =
          await ref.read(authRepositoryProvider).login(email, password);
      if (user != null) {
        ref.read(userLoginProvider.notifier).state = user;
        final profile =
            await ref.read(authRepositoryProvider).getProfile(user.uid);
        log('pro: $profile');
        ref.read(userProfileProvider.notifier).state = profile;
        if (profile != null) {
          state = const SignInSuccessEvent();
        } else {
          state = const SignInMissingEvent();
        }
      } else {
        state = const SignInErrorEvent(error: 'Login Failed');
      }
    } catch (e) {
      state = SignInErrorEvent(error: e.toString());
    }

    state = const SignInStateEvent();
  }

  void createProfile(
    String uid,
    String full_name,
    String avatar_url,
    String email,
    String phone,
    String address,
    String birthday,
    String education,
    String job,
    String minSalary,
    String maxSalary,
    String currency,
  ) async {
    state = const CreateProfileLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).createProfile(
            uid,
            full_name,
            avatar_url,
            email,
            phone,
            address,
            birthday,
            education,
            job,
            minSalary,
            maxSalary,
            currency,
          );

      if (jsonDecode(result.body)['success'] == 1) {
        state = const CreateProfileSuccessEvent();
      } else {
        final x = jsonDecode(result.body)['message'];
        log('$x');
        state = const CreateProfileErrorEvent(error: 'Error: haha');
      }
    } catch (e) {
      state = CreateProfileErrorEvent(error: e.toString());
    }

    state = const CreateProfileStateEvent();
  }
}
