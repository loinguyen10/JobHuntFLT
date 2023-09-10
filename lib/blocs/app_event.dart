import 'package:equatable/equatable.dart';
import 'package:jobhunt_ftl/model/user.dart';

// abstract class LoginEvent extends Equatable {
//   const LoginEvent();
//   @override
//   List<Object?> get props => [];
// }

abstract class InsideEvent extends Equatable {
  const InsideEvent();
  @override
  List<Object?> get props => [];
}

class LoginButtonPressedEvent extends InsideEvent {
  const LoginButtonPressedEvent();
}

class LoginEmailChangedEvent extends InsideEvent {
  const LoginEmailChangedEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChangedEvent extends InsideEvent {
  const LoginPasswordChangedEvent({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginCheckCodeChangedEvent extends InsideEvent {
  const LoginCheckCodeChangedEvent({required this.checkCode});

  final String checkCode;

  @override
  List<Object> get props => [checkCode];
}

class LoginTypeChangedEvent extends InsideEvent {
  const LoginTypeChangedEvent({required this.type});

  final String type;

  @override
  List<Object> get props => [type];
}

class ChangeSignatureEvent extends InsideEvent {
  const ChangeSignatureEvent({this.signature = ''});
  final String signature;

  @override
  List<Object> get props => [signature];
}

class SaveSignatureEvent extends InsideEvent {
  const SaveSignatureEvent();
}

class GetLoginEvent extends InsideEvent {
  const GetLoginEvent();
}

class GetAllCompanyEvent extends InsideEvent {
  const GetAllCompanyEvent();
}

class GetUserProfileEvent extends InsideEvent {
  const GetUserProfileEvent({required this.uId});

  final String uId;

  @override
  List<Object> get props => [uId];
}

class UserProfileAvatarChangedEvent extends InsideEvent {
  const UserProfileAvatarChangedEvent(
      // {this.avatar}
      );

  // final String? avatar;

  // @override
  // List<Object> get props => [avatar ?? ''];
}

class UserProfileCVChangedEvent extends InsideEvent {
  const UserProfileCVChangedEvent({this.cv});

  final String? cv;

  @override
  List<Object> get props => [cv ?? ''];
}

class UserProfileEducationChangedEvent extends InsideEvent {
  const UserProfileEducationChangedEvent({this.education});

  final String? education;

  @override
  List<Object> get props => [education ?? ''];
}

class UserProfileMinSalaryChangedEvent extends InsideEvent {
  const UserProfileMinSalaryChangedEvent({this.minSalary});

  final String? minSalary;

  @override
  List<Object> get props => [minSalary ?? ''];
}

class UserProfileMaxSalaryChangedEvent extends InsideEvent {
  const UserProfileMaxSalaryChangedEvent({this.maxSalary});

  final String? maxSalary;

  @override
  List<Object> get props => [maxSalary ?? ''];
}

class UserProfileProfessionChangedEvent extends InsideEvent {
  const UserProfileProfessionChangedEvent({this.profession});

  final String? profession;

  @override
  List<Object> get props => [profession ?? ''];
}

class UserProfileTypeSalaryChangedEvent extends InsideEvent {
  const UserProfileTypeSalaryChangedEvent({this.typeSalary});

  final String? typeSalary;

  @override
  List<Object> get props => [typeSalary ?? ''];
}

class UploadProfileCVEvent extends InsideEvent {
  const UploadProfileCVEvent();
}

class UploadProfileAvatarEvent extends InsideEvent {
  const UploadProfileAvatarEvent();
}
//

