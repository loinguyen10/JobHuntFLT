import 'package:equatable/equatable.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';

enum LoginStatus { success, failure, loading, open }

enum GetLoginStatus { success, failure, loading, open }

// class LoginState extends Equatable {
//   const LoginState({
//     this.message = '',
//     this.loginStatus = LoginStatus.open,
//     this.getLoginStatus = GetLoginStatus.open,
//     this.dni = '',
//     this.password = '',
//     this.signature = '',
//     this.user,
//   });

//   final String message;
//   final LoginStatus loginStatus;
//   final GetLoginStatus getLoginStatus;
//   final String dni;
//   final String password;
//   final String signature;
//   final UserDetail? user;

//   LoginState copyWith({
//     String? dni,
//     String? password,
//     String? checkCode,
//     String? type,
//     LoginStatus? loginStatus,
//     GetLoginStatus? getLoginStatus,
//     String? message,
//     String? signature,
//     UserDetail? user,
//   }) {
//     return LoginState(
//       dni: dni ?? this.dni,
//       password: password ?? this.password,
//       loginStatus: loginStatus ?? this.loginStatus,
//       message: message ?? this.message,
//       signature: signature ?? this.signature,
//       getLoginStatus: getLoginStatus ?? this.getLoginStatus,
//       user: user ?? this.user,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         message,
//         loginStatus,
//         dni,
//         password,
//         signature,
//         getLoginStatus,
//         user,
//       ];
// }

//

enum GetUserStatus { success, failure, loading, open }

enum GetCompanyStatus { success, failure, loading, open }

enum GetUserProfileStatus { success, failure, loading, open }

enum UploadProfileAvatarStatus { success, failure, loading, open }

enum UploadProfileCVStatus { success, failure, loading, open }

class InsideState extends Equatable {
  const InsideState({
    this.message = '',
    this.loginStatus = LoginStatus.open,
    this.getLoginStatus = GetLoginStatus.open,
    this.emailSign = '',
    this.passwordSign = '',
    this.userLogin,
    this.userLoginStatus = GetUserStatus.open,
    this.getCompanyStatus = GetCompanyStatus.open,
    this.listCompany,
    this.getUserProfileStatus = GetUserProfileStatus.open,
    this.userProfileDetail,
    this.profileAvatar,
    this.profileCV,
    this.profileEducation,
    this.profileMinSalary,
    this.profileMaxSalary,
    this.profileProfession,
    this.profileTypeSalary,
    this.uploadProfileAvatarStatus = UploadProfileAvatarStatus.open,
    this.uploadProfileCVStatus = UploadProfileCVStatus.open,
    // this.profileAvatarEdit,
    // this.profileCVEdit,
    // this.profileEducationEdit,
    // this.profileMinSalaryEdit,
    // this.profileMaxSalaryEdit,
    // this.profileProfessionEdit,
    // this.profileTypeSalaryEdit,
  });

  final String message;
  final UserDetail? userLogin;
  final GetUserStatus userLoginStatus;
  final String emailSign;
  final String passwordSign;
  final LoginStatus loginStatus;
  final GetLoginStatus getLoginStatus;
  final GetCompanyStatus getCompanyStatus;
  final GetUserProfileStatus getUserProfileStatus;
  final List<CompanyInfo>? listCompany;
  final UserProfileDetail? userProfileDetail;
  final String? profileAvatar;
  final String? profileCV;
  final String? profileEducation;
  final String? profileMinSalary;
  final String? profileMaxSalary;
  final String? profileProfession;
  final String? profileTypeSalary;
  final UploadProfileAvatarStatus? uploadProfileAvatarStatus;
  final UploadProfileCVStatus? uploadProfileCVStatus;
  // final String? profileAvatarEdit;
  // final String? profileCVEdit;
  // final String? profileEducationEdit;
  // final String? profileMinSalaryEdit;
  // final String? profileMaxSalaryEdit;
  // final String? profileProfessionEdit;
  // final String? profileTypeSalaryEdit;

  InsideState copyWith({
    String? message,
    UserDetail? userLogin,
    GetUserStatus? userLoginStatus,
    String? emailSign,
    String? passwordSign,
    LoginStatus? loginStatus,
    GetLoginStatus? getLoginStatus,
    GetCompanyStatus? getCompanyStatus,
    GetUserProfileStatus? getUserProfileStatus,
    List<CompanyInfo>? listCompany,
    UserProfileDetail? userProfileDetail,
    String? profileAvatar,
    String? profileCV,
    String? profileEducation,
    String? profileMinSalary,
    String? profileMaxSalary,
    String? profileProfession,
    String? profileTypeSalary,
    UploadProfileAvatarStatus? uploadProfileAvatarStatus,
    UploadProfileCVStatus? uploadProfileCVStatus,
    // String? profileAvatarEdit,
    // String? profileCVEdit,
    // String? profileEducationEdit,
    // String? profileMinSalaryEdit,
    // String? profileMaxSalaryEdit,
    // String? profileProfessionEdit,
    // String? profileTypeSalaryEdit,
  }) {
    return InsideState(
      message: message ?? this.message,
      userLogin: userLogin ?? this.userLogin,
      userLoginStatus: userLoginStatus ?? this.userLoginStatus,
      emailSign: emailSign ?? this.emailSign,
      passwordSign: passwordSign ?? this.passwordSign,
      getLoginStatus: getLoginStatus ?? this.getLoginStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      getCompanyStatus: getCompanyStatus ?? this.getCompanyStatus,
      listCompany: listCompany ?? this.listCompany,
      getUserProfileStatus: getUserProfileStatus ?? this.getUserProfileStatus,
      userProfileDetail: userProfileDetail ?? this.userProfileDetail,
      profileAvatar: profileAvatar ?? this.profileAvatar,
      profileCV: profileCV ?? this.profileCV,
      profileEducation: profileEducation ?? this.profileEducation,
      profileMinSalary: profileMinSalary ?? this.profileMinSalary,
      profileMaxSalary: profileMaxSalary ?? this.profileMaxSalary,
      profileProfession: profileProfession ?? this.profileProfession,
      profileTypeSalary: profileTypeSalary ?? this.profileTypeSalary,
      uploadProfileAvatarStatus:
          uploadProfileAvatarStatus ?? this.uploadProfileAvatarStatus,
      uploadProfileCVStatus:
          uploadProfileCVStatus ?? this.uploadProfileCVStatus,
      // profileAvatarEdit: profileAvatarEdit ?? this.profileAvatarEdit,
      // profileCVEdit: profileCVEdit ?? this.profileCVEdit,
      // profileEducationEdit: profileEducationEdit ?? this.profileEducationEdit,
      // profileMinSalaryEdit: profileMinSalaryEdit ?? this.profileMinSalaryEdit,
      // profileMaxSalaryEdit: profileMaxSalaryEdit ?? this.profileMaxSalaryEdit,
      // profileProfessionEdit:
      //     profileProfessionEdit ?? this.profileProfessionEdit,
      // profileTypeSalaryEdit:
      //     profileTypeSalaryEdit ?? this.profileTypeSalaryEdit,
    );
  }

  @override
  List<Object?> get props => [
        message,
        userLogin,
        userLoginStatus,
        emailSign,
        passwordSign,
        getLoginStatus,
        loginStatus,
        getCompanyStatus,
        listCompany,
        getUserProfileStatus,
        userProfileDetail,
        profileAvatar,
        profileCV,
        profileEducation,
        profileMinSalary,
        profileMaxSalary,
        profileProfession,
        profileTypeSalary,
        uploadProfileAvatarStatus,
        uploadProfileCVStatus,
        // profileAvatarEdit,
        // profileCVEdit,
        // profileEducationEdit,
        // profileMinSalaryEdit,
        // profileMaxSalaryEdit,
        // profileProfessionEdit,
        // profileTypeSalaryEdit,
      ];
}
