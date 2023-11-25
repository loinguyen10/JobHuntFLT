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

class ThingStateEvent extends InsideEvent {
  const ThingStateEvent();

  @override
  List<Object> get props => [];
}

class ThingLoadingEvent extends InsideEvent {
  const ThingLoadingEvent();

  @override
  List<Object> get props => [];
}

class CreateThingLoadingEvent extends InsideEvent {
  const CreateThingLoadingEvent();

  @override
  List<Object> get props => [];
}

class CreateThingSuccessEvent extends InsideEvent {
  const CreateThingSuccessEvent();

  @override
  List<Object> get props => [];
}

class CreateThingErrorEvent extends InsideEvent {
  const CreateThingErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class UpdateThingLoadingEvent extends InsideEvent {
  const UpdateThingLoadingEvent();

  @override
  List<Object> get props => [];
}

class UpdateThingSuccessEvent extends InsideEvent {
  const UpdateThingSuccessEvent();

  @override
  List<Object> get props => [];
}

class UpdateThingErrorEvent extends InsideEvent {
  const UpdateThingErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class AddTitleErrorEvent extends InsideEvent {
  const AddTitleErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class FavoriteLoadingEvent extends InsideEvent {
  const FavoriteLoadingEvent();

  @override
  List<Object> get props => [];
}

class FavoriteSuccessEvent extends InsideEvent {
  const FavoriteSuccessEvent();

  @override
  List<Object> get props => [];
}

class FavoriteErrorEvent extends InsideEvent {
  const FavoriteErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}
