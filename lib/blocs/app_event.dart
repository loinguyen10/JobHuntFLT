import 'package:equatable/equatable.dart';
import 'package:jobhunt_ftl/model/user.dart';

abstract class InsideEvent extends Equatable {
  const InsideEvent();
  @override
  List<Object?> get props => [];
}

class LoginButtonPressedEvent extends InsideEvent {
  const LoginButtonPressedEvent();
}

class SignInStateEvent extends InsideEvent {
  const SignInStateEvent();

  @override
  List<Object> get props => [];
}

class SignInLoadingEvent extends InsideEvent {
  const SignInLoadingEvent();

  @override
  List<Object> get props => [];
}

class SignInSuccessEvent extends InsideEvent {
  const SignInSuccessEvent();

  @override
  List<Object> get props => [];
}

class SignInErrorEvent extends InsideEvent {
  const SignInErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

// class LoginEmailChangedEvent extends InsideEvent {
//   const LoginEmailChangedEvent({required this.email});

//   final String email;

//   @override
//   List<Object> get props => [email];
// }

// class LoginPasswordChangedEvent extends InsideEvent {
//   const LoginPasswordChangedEvent({required this.password});

//   final String password;

//   @override
//   List<Object> get props => [password];
// }

// class LoginCheckCodeChangedEvent extends InsideEvent {
//   const LoginCheckCodeChangedEvent({required this.checkCode});

//   final String checkCode;

//   @override
//   List<Object> get props => [checkCode];
// }

// class LoginTypeChangedEvent extends InsideEvent {
//   const LoginTypeChangedEvent({required this.type});

//   final String type;

//   @override
//   List<Object> get props => [type];
// }

// class ChangeSignatureEvent extends InsideEvent {
//   const ChangeSignatureEvent({this.signature = ''});
//   final String signature;

//   @override
//   List<Object> get props => [signature];
// }
