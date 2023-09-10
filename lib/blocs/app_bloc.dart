import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import '../blocs/app_event.dart';

import '../repository/repository.dart';
import 'app_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc({
//     required AuthService authFirebase,
//   })  : _authFirebase = authFirebase,
//         super(const LoginState()) {
//     on<LoginButtonPressedEvent>(_handleLoginFirebaseEvent);
//     on<LoginDniChangedEvent>(_handleLoginDniChangedEvent);
//     on<LoginPasswordChangedEvent>(_handleLoginPasswordChangedEvent);
//     on<GetLoginEvent>(_handleGetLoginEvent);
//   }

//   // final AuthRepository _authService;
//   final AuthService _authFirebase;

//   Future<void> _handleLoginDniChangedEvent(
//     LoginDniChangedEvent event,
//     Emitter<LoginState> emit,
//   ) async {
//     emit(state.copyWith(dni: event.dni));
//   }

//   Future<void> _handleLoginPasswordChangedEvent(
//     LoginPasswordChangedEvent event,
//     Emitter<LoginState> emit,
//   ) async {
//     emit(state.copyWith(password: event.password));
//   }

//   Future<void> _handleLoginFirebaseEvent(
//     LoginButtonPressedEvent event,
//     Emitter<LoginState> emit,
//   ) async {
//     try {
//       emit(
//           state.copyWith(message: 'Loading', loginStatus: LoginStatus.loading));
//       final loginResult =
//           await _authFirebase.loginFirebase(state.dni, state.password);
//       log("KET QUA LOGIN:  ${loginResult}");
//       if (loginResult != null) {
//         emit(state.copyWith(
//           message: 'Success',
//           loginStatus: LoginStatus.success,
//           user: loginResult,
//         ));
//       } else {
//         emit(state.copyWith(
//             message: 'NOTHING', loginStatus: LoginStatus.failure));
//       }
//     } catch (e) {
//       emit(state.copyWith(
//           message: e.toString(), loginStatus: LoginStatus.failure));
//     }

//     await Future.delayed(Duration(milliseconds: 100));
//     emit(state.copyWith(message: 'Open', loginStatus: LoginStatus.open));
//   }

//   Future<void> _handleGetLoginEvent(
//     GetLoginEvent event,
//     Emitter<LoginState> emit,
//   ) async {
//     emit(state.copyWith(
//         message: 'Success', getLoginStatus: GetLoginStatus.success));
//     emit(state.copyWith(
//       message: 'Open',
//       getLoginStatus: GetLoginStatus.open,
//     ));
//   }
// }

class InsideBloc extends Bloc<InsideEvent, InsideState> {
  InsideBloc({
    required InsideService insideFirebase,
  })  : _insideFirebase = insideFirebase,
        super(const InsideState()) {
    on<LoginButtonPressedEvent>(_handleLoginFirebaseEvent);
    on<LoginEmailChangedEvent>(_handleLoginEmailChangedEvent);
    on<LoginPasswordChangedEvent>(_handleLoginPasswordChangedEvent);
    on<GetAllCompanyEvent>(_handleGetAllCompanyEvent);
    on<GetUserProfileEvent>(_handleGetUserProfileEvent);
    on<UserProfileAvatarChangedEvent>(_handleUserProfileAvatarChangedEvent);
    on<UserProfileCVChangedEvent>(_handleUserProfileCVChangedEvent);
    on<UserProfileEducationChangedEvent>(
        _handleUserProfileEducationChangedEvent);
    on<UserProfileMinSalaryChangedEvent>(
        _handleUserProfileMinSalaryChangedEvent);
    on<UserProfileMaxSalaryChangedEvent>(
        _handleUserProfileMaxSalaryChangedEvent);
    on<UserProfileProfessionChangedEvent>(
        _handleUserProfileProfessionChangedEvent);
    on<UserProfileTypeSalaryChangedEvent>(
        _handleUserProfileTypeSalaryChangedEvent);
    on<UploadProfileCVEvent>(_handleUploadProfileCVEvent);
    // on<UploadProfileAvatarEvent>(_handleUploadProfileAvatarEvent);
  }

  final InsideService _insideFirebase;

  Future<void> _handleLoginEmailChangedEvent(
    LoginEmailChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(emailSign: event.email));
  }

  Future<void> _handleLoginPasswordChangedEvent(
    LoginPasswordChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(passwordSign: event.password));
  }

  Future<void> _handleLoginFirebaseEvent(
    LoginButtonPressedEvent event,
    Emitter<InsideState> emit,
  ) async {
    try {
      emit(
          state.copyWith(message: 'Loading', loginStatus: LoginStatus.loading));
      // final loginResult = await _insideFirebase.loginFirebase(
      final loginResult =
          await _insideFirebase.login(state.emailSign, state.passwordSign);
      log("KET QUA LOGIN:  ${loginResult}");
      if (loginResult != null) {
        emit(state.copyWith(
          message: 'Success',
          loginStatus: LoginStatus.success,
          userLogin: loginResult,
        ));
      } else {
        emit(state.copyWith(
            message: 'NOTHING', loginStatus: LoginStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), loginStatus: LoginStatus.failure));
    }

    await Future.delayed(Duration(milliseconds: 100));
    emit(state.copyWith(message: 'Open', loginStatus: LoginStatus.open));
  }

  Future<void> _handleGetAllCompanyEvent(
    GetAllCompanyEvent event,
    Emitter<InsideState> emit,
  ) async {
    List<CompanyInfo> listCompany = [];
    try {
      emit(state.copyWith(
          message: 'Loading', getCompanyStatus: GetCompanyStatus.loading));
      List<DocumentSnapshot> result =
          await _insideFirebase.getCollection('CompanyInfo');

      for (final doc in result) {
        final data = doc.data() as Map<String, dynamic>;
        final company = CompanyInfo(
          accountId: data['accountId'],
          address: data['companyAddress'],
          avatar: data['companyAvatar'],
          description: data['companyDescription'],
          industry: data['companyIndustry'],
          name: data['companyName'],
          phone: data['companyPhone'],
          scale: data['companyScale'],
          website: data['companyWebsite'],
        );

        log('${company}');

        listCompany.add(company);
      }

      log('${listCompany.length}');

      emit(state.copyWith(
        message: 'Success',
        getCompanyStatus: GetCompanyStatus.success,
        listCompany: listCompany,
      ));
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), getCompanyStatus: GetCompanyStatus.failure));
    }

    await Future.delayed(Duration(milliseconds: 100));
    emit(state.copyWith(
        message: 'Open', getCompanyStatus: GetCompanyStatus.open));
  }

  Future<void> _handleGetUserProfileEvent(
    GetUserProfileEvent event,
    Emitter<InsideState> emit,
  ) async {
    var profile = null;
    try {
      emit(state.copyWith(
          message: 'Loading',
          getUserProfileStatus: GetUserProfileStatus.loading));
      List<DocumentSnapshot> result =
          await _insideFirebase.getCollection('UserProfile');

      for (final doc in result) {
        if (doc.id == event.uId) {
          final data = doc.data() as Map<String, dynamic>;
          profile = UserProfileDetail(
            avatarUrl: data['avatar'],
            cvUrl: data['cv'],
            education: data['education'],
            maxSalary: data['maxSalary'],
            minSalary: data['minSalary'],
            profession: data['profession'],
            salary: data['salary'],
            skillList: [],
            typeSalary: data['typeSalary'],
          );
        }
      }

      emit(state.copyWith(
        message: 'Success',
        getUserProfileStatus: GetUserProfileStatus.success,
        userProfileDetail: profile,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          message: e.toString(),
          getUserProfileStatus: GetUserProfileStatus.failure));
    }

    await Future.delayed(Duration(milliseconds: 100));
    emit(state.copyWith(
        message: 'Open', getUserProfileStatus: GetUserProfileStatus.open));
  }

  Future<void> _handleUserProfileAvatarChangedEvent(
    UserProfileAvatarChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(
      message: 'Success',
      uploadProfileAvatarStatus: UploadProfileAvatarStatus.success,
      // profileAvatar: event.avatar,
    ));

    await Future.delayed(Duration(milliseconds: 100));
    emit(state.copyWith(
      message: 'Open',
      uploadProfileAvatarStatus: UploadProfileAvatarStatus.open,
    ));
  }

  Future<void> _handleUserProfileCVChangedEvent(
    UserProfileCVChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(
      message: 'Success',
      uploadProfileCVStatus: UploadProfileCVStatus.success,
      // profileCV: event.cv,
    ));

    emit(state.copyWith(
      message: 'Open',
      uploadProfileCVStatus: UploadProfileCVStatus.open,
    ));
  }

  Future<void> _handleUserProfileEducationChangedEvent(
    UserProfileEducationChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(profileEducation: event.education));
  }

  Future<void> _handleUserProfileMinSalaryChangedEvent(
    UserProfileMinSalaryChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(profileMinSalary: event.minSalary));
  }

  Future<void> _handleUserProfileMaxSalaryChangedEvent(
    UserProfileMaxSalaryChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(profileMaxSalary: event.maxSalary));
  }

  Future<void> _handleUserProfileProfessionChangedEvent(
    UserProfileProfessionChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(profileProfession: event.profession));
  }

  Future<void> _handleUserProfileTypeSalaryChangedEvent(
    UserProfileTypeSalaryChangedEvent event,
    Emitter<InsideState> emit,
  ) async {
    emit(state.copyWith(profileTypeSalary: event.typeSalary));
  }

  Future<void> _handleUploadProfileCVEvent(
    UploadProfileCVEvent event,
    Emitter<InsideState> emit,
  ) async {
    try {
      emit(state.copyWith(
          message: 'Loading',
          getUserProfileStatus: GetUserProfileStatus.loading));
      String result = await _insideFirebase.getCollection('UserProfile');

      emit(state.copyWith(
        message: 'Success',
        getUserProfileStatus: GetUserProfileStatus.success,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          message: e.toString(),
          getUserProfileStatus: GetUserProfileStatus.failure));
    }

    await Future.delayed(Duration(milliseconds: 100));
    emit(state.copyWith(
        message: 'Open', getUserProfileStatus: GetUserProfileStatus.open));
  }

  // Future<void> _handleUploadProfileAvatarEvent(
  //   UploadProfileAvatarEvent event,
  //   Emitter<InsideState> emit,
  // ) async {
  //   try {
  //     emit(state.copyWith(
  //         message: 'Loading',
  //         getUserProfileStatus: GetUserProfileStatus.loading));
  //     List<DocumentSnapshot> result =
  //         await _insideFirebase.getCollection('UserProfile');

  //     emit(state.copyWith(
  //       message: 'Success',
  //       getUserProfileStatus: GetUserProfileStatus.success,
  //     ));
  //   } catch (e) {
  //     log(e.toString());
  //     emit(state.copyWith(
  //         message: e.toString(),
  //         getUserProfileStatus: GetUserProfileStatus.failure));
  //   }

  //   await Future.delayed(Duration(milliseconds: 100));
  //   emit(state.copyWith(
  //       message: 'Open', getUserProfileStatus: GetUserProfileStatus.open));
  // }

  //
}
