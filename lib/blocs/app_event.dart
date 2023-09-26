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

class SignInMissingEvent extends InsideEvent {
  const SignInMissingEvent();

  @override
  List<Object> get props => [];
}

class SignInErrorEvent extends InsideEvent {
  const SignInErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class SignUpStateEvent extends InsideEvent {
  const SignUpStateEvent();

  @override
  List<Object> get props => [];
}

class SignUpLoadingEvent extends InsideEvent {
  const SignUpLoadingEvent();

  @override
  List<Object> get props => [];
}

class SignUpSuccessEvent extends InsideEvent {
  const SignUpSuccessEvent();

  @override
  List<Object> get props => [];
}

class SignUpErrorEvent extends InsideEvent {
  const SignUpErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class CreateProfileStateEvent extends InsideEvent {
  const CreateProfileStateEvent();

  @override
  List<Object> get props => [];
}

class CreateProfileLoadingEvent extends InsideEvent {
  const CreateProfileLoadingEvent();

  @override
  List<Object> get props => [];
}

class CreateProfileSuccessEvent extends InsideEvent {
  const CreateProfileSuccessEvent();

  @override
  List<Object> get props => [];
}

class CreateProfileErrorEvent extends InsideEvent {
  const CreateProfileErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class UpdateProfileStateEvent extends InsideEvent {
  const UpdateProfileStateEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileLoadingEvent extends InsideEvent {
  const UpdateProfileLoadingEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileSuccessEvent extends InsideEvent {
  const UpdateProfileSuccessEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileErrorEvent extends InsideEvent {
  const UpdateProfileErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}
