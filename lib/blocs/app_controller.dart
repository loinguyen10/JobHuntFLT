import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:path/path.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';

final LoginControllerProvider =
    StateNotifierProvider<LoginController, InsideEvent>((ref) {
  return LoginController(ref);
});

final JobViewControllerProvider =
    StateNotifierProvider<LoginController, InsideEvent>((ref) {
  return LoginController(ref);
});

class LoginController extends StateNotifier<InsideEvent> {
  LoginController(this.ref) : super(const SignInStateEvent());

  final Ref ref;

  void login(String email, String password) async {
    ref.read(userLoginProvider.notifier).state = null;
    ref.read(userProfileProvider.notifier).state = null;
    ref.read(companyProfileProvider.notifier).state = null;
    ref.read(userDetailJobSettingProvider.notifier).state = null;
    state = const SignInLoadingEvent();
    log('$email + $password');
    try {
      final user =
          await ref.read(authRepositoryProvider).login(email, password);
      if (user != null) {
        ref.read(userLoginProvider.notifier).state = user;

        if (user.role != null && user.role != '') {
          if (user.role == 'candidate') {
            log('candidate');
            final profile =
                await ref.read(authRepositoryProvider).getProfile(user.uid);
            final setting = await ref
                .read(authRepositoryProvider)
                .getJobRecommendSetting(user.uid);
            log('pro: $profile');
            log('setting: ${setting.uid} ${setting.job}');
            ref.read(userProfileProvider.notifier).state = profile;
            ref.read(userDetailJobSettingProvider.notifier).state = setting;
          } else if (user.role == 'recuiter') {
            log('recuiter');
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
  ) async {
    state = const CreateThingLoadingEvent();
    try {
      if (avatar_url.isEmpty) {
        final result = await ref.read(authRepositoryProvider).createProfile(
              uid,
              full_name,
              '',
              email,
              phone,
              address,
              birthday,
            );

        if (result == 1) {
          final profile =
              await ref.read(authRepositoryProvider).getProfile(uid);
          log('pro: $profile');
          ref.read(userProfileProvider.notifier).state = profile;
          state = const CreateThingSuccessEvent();
        } else {
          state = const CreateThingErrorEvent(error: '');
        }
      } else {
        FormData formData = FormData.fromMap({
          "uploadedfile": await MultipartFile.fromFile(avatar_url,
              filename: "img_id${uid}_user_profile_avatar.jpg")
        });
        Response response = await Dio().post(
            "$BASE_URL/profile/upload_profile_avatar.php",
            data: formData);
        log('$response');
        if (jsonDecode(response.data)['success'] == 1) {
          final result = await ref.read(authRepositoryProvider).createProfile(
                uid,
                full_name,
                '${BASE_IMG_URL}profile/avatar/img_id${uid}_user_profile_avatar.jpg',
                email,
                phone,
                address,
                birthday,
              );

          if (result == 1) {
            final profile =
                await ref.read(authRepositoryProvider).getProfile(uid);
            log('pro: $profile');
            ref.read(userProfileProvider.notifier).state = profile;
            state = const CreateThingSuccessEvent();
          } else {
            state = const CreateThingErrorEvent(error: '');
          }
        } else {
          state = const CreateThingErrorEvent(error: '');
        }
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
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
    state = const CreateThingLoadingEvent();
    try {
      if (avatar_url.isEmpty) {
        final result = await ref.read(authRepositoryProvider).createCompany(
              uid,
              full_name,
              '',
              email,
              phone,
              address,
              website,
              description,
              job,
            );

        if (result == 1) {
          final company =
              await ref.read(authRepositoryProvider).getCompany(uid);
          log('company: $company');
          ref.read(companyProfileProvider.notifier).state = company;
          state = const CreateThingSuccessEvent();
        } else {
          state = const CreateThingErrorEvent(error: 'error');
        }
      } else {
        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(avatar_url,
              filename: "img_id${uid}_company_profile_avatar.jpg")
        });
        Response response = await Dio().post(
            "$BASE_URL/company/upload_company_avatar.php",
            data: formData);

        if (jsonDecode(response.data)['success'] == 1) {
          final result = await ref.read(authRepositoryProvider).createCompany(
                uid,
                full_name,
                '${BASE_IMG_URL}company/avatar/img_id${uid}_company_profile_avatar.jpg',
                email,
                phone,
                address,
                website,
                description,
                job,
              );

          if (result == 1) {
            final company =
                await ref.read(authRepositoryProvider).getCompany(uid);
            log('company: $company');
            ref.read(companyProfileProvider.notifier).state = company;
            state = const CreateThingSuccessEvent();
          } else {
            state = const CreateThingErrorEvent(error: 'error');
          }
        } else {
          state = const CreateThingErrorEvent(error: 'error');
        }
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void updateProfile(
    String uid,
    String full_name,
    String avatar_url,
    String email,
    String phone,
    String address,
    String birthday,
  ) async {
    state = const UpdateThingLoadingEvent();
    try {
      FormData formData = FormData.fromMap({
        "uploadedfile": await MultipartFile.fromFile(avatar_url,
            filename: "img_id${uid}_user_profile_avatar.jpg")
      });
      Response response = await Dio()
          .post("$BASE_URL/profile/upload_profile_avatar.php", data: formData);
      log('$response');
      if (jsonDecode(response.data)['success'] == 1) {
        final result = await ref.read(authRepositoryProvider).updateProfile(
              uid,
              full_name,
              '${BASE_IMG_URL}profile/avatar/img_id${uid}_user_profile_avatar.jpg',
              email,
              phone,
              address,
              birthday,
            );

        if (result == 1) {
          final profile =
              await ref.read(authRepositoryProvider).getProfile(uid);
          log('pro: $profile');
          ref.read(userProfileProvider.notifier).state = profile;
          state = const UpdateThingSuccessEvent();
        } else {
          state = const UpdateThingErrorEvent(error: '');
        }
      } else {
        state = const UpdateThingErrorEvent(error: '');
      }
    } catch (e) {
      state = UpdateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void updateCompany(
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
    state = const UpdateThingLoadingEvent();
    try {
      log('avatar: ${avatar_url}');
      FormData formData = FormData.fromMap({
        "uploadedfile": await MultipartFile.fromFile(avatar_url,
            filename: "img_id${uid}_company_profile_avatar.jpg")
      });
      Response response = await Dio()
          .post(BASE_URL + 'company/upload_company_avatar.php', data: formData);
      if (jsonDecode(response.data)['success'] == 1) {
        final result = await ref.read(authRepositoryProvider).updateCompany(
              uid,
              full_name,
              '${BASE_IMG_URL}company/avatar/img_id${uid}_company_profile_avatar.jpg',
              email,
              phone,
              address,
              website,
              description,
              job,
            );

        if (result == 1) {
          log('hello2');
          final company =
              await ref.read(authRepositoryProvider).getCompany(uid);
          log('company: $company');
          ref.read(companyProfileProvider.notifier).state = company;
          ref.refresh(avatarCompanyProvider);
          state = const UpdateThingSuccessEvent();
        } else {
          log('hello3');
          state = const UpdateThingErrorEvent(error: 'error');
        }
      } else {
        state = const UpdateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = UpdateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void createJob(
    String name,
    String companyId,
    int minSalary,
    int maxSalary,
    String currency,
    int yearExperience,
    int typeJob,
    int numberCandidate,
    String address,
    String description,
    String candidateRequirement,
    String jobBenefit,
    String tag,
    String deadline,
    int active,
  ) async {
    state = const CreateThingLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).createJob(
            name,
            companyId,
            minSalary,
            maxSalary,
            currency,
            yearExperience,
            typeJob,
            numberCandidate,
            address,
            description,
            candidateRequirement,
            jobBenefit,
            tag,
            deadline,
            active,
          );

      if (result == 1) {
        state = const CreateThingSuccessEvent();
      } else {
        state = const CreateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void updateJob(
    String code,
    String name,
    String companyId,
    int minSalary,
    int maxSalary,
    String currency,
    int yearExperience,
    int typeJob,
    int numberCandidate,
    String address,
    String description,
    String candidateRequirement,
    String jobBenefit,
    String tag,
    String deadline,
    int active,
  ) async {
    state = const UpdateThingLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).updateJob(
            code,
            name,
            companyId,
            minSalary,
            maxSalary,
            currency,
            yearExperience,
            typeJob,
            numberCandidate,
            address,
            description,
            candidateRequirement,
            jobBenefit,
            tag,
            deadline,
            active,
          );

      if (result == 1) {
        final job = await ref.read(authRepositoryProvider).getJob(code);
        log('job: $job');
        ref.read(jobDetailProvider.notifier).state = job;
        state = const UpdateThingSuccessEvent();
      } else {
        state = const UpdateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = UpdateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void uploadCV(String uid, String cv) async {
    state = const CreateThingLoadingEvent();
    log('$uid + $cv');
    try {
      final lastNumber = ref.watch(lastNumberCVProvider);
      FormData formData = FormData.fromMap({
        "uid": uid,
        "uploadedfile": await MultipartFile.fromFile(cv,
            filename: "cv_id${uid}_${lastNumber + 1}.pdf")
      });
      Response response =
          await Dio().post(BASE_URL + 'cv/upload_cv.php', data: formData);
      if (jsonDecode(response.data)['success'] == 1) {
        String url = '${BASE_CV_URL}/${uid}/cv_id${uid}_${lastNumber + 1}.pdf';
        final result =
            await ref.read(authRepositoryProvider).addCV(url, uid, 'upload');
        state = const CreateThingSuccessEvent();
      } else {
        state = const CreateThingErrorEvent(error: 'Failed');
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    ref.refresh(lastNumberCVProvider);
    state = const ThingStateEvent();
  }

  void addFavorive(
    String jobId,
    String userId,
  ) async {
    state = const CreateThingLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).addFavorite(
            jobId,
            userId,
          );

      if (result == 1) {
        ref.refresh(listYourFavoriteProvider);
        ref.refresh(turnBookmarkOn);
        state = const CreateThingSuccessEvent();
      } else {
        state = const CreateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void removeFavorive(
    String jobId,
    String userId,
  ) async {
    state = const CreateThingLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).removeFavorite(
            jobId,
            userId,
          );

      if (result == 1) {
        ref.refresh(listYourFavoriteProvider);
        ref.refresh(turnBookmarkOn);
        state = const CreateThingSuccessEvent();
      } else {
        state = const CreateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void createApplication(
    String cv_url,
    String jobId,
    String candidateId,
    String companyId,
  ) async {
    state = const ThingLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).createApplication(
            cv_url,
            jobId,
            candidateId,
            companyId,
          );

      if (result == 1) {
        Future.delayed(Duration(seconds: 3), () {
          state = const CreateThingSuccessEvent();
        });
      } else {
        state = const CreateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void removeApplication(
    String jobId,
    String userId,
  ) async {
    state = const CreateThingLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).removeFavorite(
            jobId,
            userId,
          );

      if (result == 1) {
        ref.refresh(listYourFavoriteProvider);
        ref.refresh(turnBookmarkOn);
        state = const CreateThingSuccessEvent();
      } else {
        state = const CreateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void apporveApplication(
    String code,
    String apporve,
  ) async {
    state = const ThingLoadingEvent();
    try {
      final result = await ref.read(authRepositoryProvider).apporveApplication(
            code,
            apporve,
          );

      if (result == 1) {
        Future.delayed(Duration(seconds: 3), () {
          ref.refresh(listRecuiterTodayApplicationProvider);
          state = const CreateThingSuccessEvent();
        });
      } else {
        state = const CreateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = CreateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }

  void createJobTitle(String title) async {
    state = const ThingLoadingEvent();
    try {
      final result =
          await ref.read(authRepositoryProvider).createJobTitle(title);
      if (result == 1) {
        log('${DateTime.now()} $result');
      } else {
        log('${DateTime.now()} $result');
        state = const AddTitleErrorEvent(error: 'error');
      }
    } catch (e) {
      state = AddTitleErrorEvent(error: e.toString());
    }

    ref.refresh(listAllTitleJobSettingProvider);

    // state = const ThingStateEvent();
  }

  void createJobRecommendSetting(
    String uid,
    String gender,
    String job,
    String educationId,
    int yearExperience,
    String workProvince,
    int minSalary,
    int maxSalary,
    String currency,
  ) async {
    if (state == AddTitleErrorEvent()) {
      state = const CreateThingErrorEvent(error: 'error');
    } else {
      state = const CreateThingLoadingEvent();
      try {
        final result =
            await ref.read(authRepositoryProvider).createJobRecommendSetting(
                  uid,
                  gender,
                  job,
                  educationId,
                  yearExperience,
                  workProvince,
                  minSalary,
                  maxSalary,
                  currency,
                );

        if (result == 1) {
          state = const CreateThingSuccessEvent();
          final setting = await ref
              .read(authRepositoryProvider)
              .getJobRecommendSetting(uid);
          ref.read(userDetailJobSettingProvider.notifier).state = setting;
        } else {
          state = const CreateThingErrorEvent(error: 'error');
        }
      } catch (e) {
        state = CreateThingErrorEvent(error: e.toString());
      }
    }
    state = const ThingStateEvent();
  }

  void updateJobRecommendSetting(
    String uid,
    String gender,
    String job,
    String educationId,
    int yearExperience,
    String workProvince,
    int minSalary,
    int maxSalary,
    String currency,
  ) async {
    state = const UpdateThingLoadingEvent();
    try {
      final result =
          await ref.read(authRepositoryProvider).updateJobRecommendSetting(
                uid,
                gender,
                job,
                educationId,
                yearExperience,
                workProvince,
                minSalary,
                maxSalary,
                currency,
              );

      if (result == 1) {
        final setting =
            await ref.read(authRepositoryProvider).getJobRecommendSetting(uid);
        log('setting: $setting');
        ref.read(userDetailJobSettingProvider.notifier).state = setting;
        state = const UpdateThingSuccessEvent();
      } else {
        state = const UpdateThingErrorEvent(error: 'error');
      }
    } catch (e) {
      state = UpdateThingErrorEvent(error: e.toString());
    }

    state = const ThingStateEvent();
  }
}
