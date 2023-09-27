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

        if (user.role != null && user.role != '') {
          if (user.role == 'candidate') {
            final profile =
                await ref.read(authRepositoryProvider).getProfile(user.uid);
            log('pro: $profile');
            ref.read(userProfileProvider.notifier).state = profile;
          } else if (user.role == 'recuiter') {
            final company =
                await ref.read(authRepositoryProvider).getCompany(user.uid);
            log('company: $company');
            ref.read(companyProfileProvider.notifier).state = company;
          }
          state = const SignInSuccessEvent();
        } else {
          ref.read(userProfileProvider.notifier).state = null;
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

  void register(String email, String password) async {
    state = const SignUpLoadingEvent();
    log('$email + $password');
    try {
      final result =
          await ref.read(authRepositoryProvider).register(email, password);
      if (result == 1) {
        final user =
            await ref.read(authRepositoryProvider).login(email, password);
        ref.read(userLoginProvider.notifier).state = user;
        // ref.read(userProfileProvider.notifier).state = null;
        // ref.read(companyProfileProvider.notifier).state = null;
        state = const SignUpSuccessEvent();
      } else {
        state = const SignUpErrorEvent(error: 'Register Failed');
      }
    } catch (e) {
      state = SignUpErrorEvent(error: e.toString());
    }

    state = const SignUpStateEvent();
  }

  void createProfile(
    String uid,
    String full_name,
    String avatar_url,
    String email,
    String phone,
    String address,
    String birthday,
    String educationId,
    String job,
    int minSalary,
    int maxSalary,
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
            educationId,
            job,
            minSalary,
            maxSalary,
            currency,
          );

      if (result == 1) {
        final profile = await ref.read(authRepositoryProvider).getProfile(uid);
        log('pro: $profile');
        ref.read(userProfileProvider.notifier).state = profile;
        state = const CreateProfileSuccessEvent();
      } else {
        state = const CreateProfileErrorEvent(error: '');
      }
    } catch (e) {
      state = CreateProfileErrorEvent(error: e.toString());
    }

    state = const CreateProfileStateEvent();
  }

  void createCompany(
    String uid,
    String full_name,
    String avatar_url,
    String email,
    String phone,
    String address,
    String website,
    String description,
    String job,
  ) async {
    state = const CreateProfileLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).createCompany(
            uid,
            full_name,
            avatar_url,
            email,
            phone,
            address,
            website,
            description,
            job,
          );

      if (result == 1) {
        final company = await ref.read(authRepositoryProvider).getCompany(uid);
        log('company: $company');
        ref.read(companyProfileProvider.notifier).state = company;
        state = const CreateProfileSuccessEvent();
      } else {
        state = const CreateProfileErrorEvent(error: 'error');
      }
    } catch (e) {
      state = CreateProfileErrorEvent(error: e.toString());
    }

    state = const CreateProfileStateEvent();
  }
}
