import 'package:equatable/equatable.dart';

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

class SignInBannedEvent extends InsideEvent {
  const SignInBannedEvent();

  @override
  List<Object> get props => [];
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

class CreateOTPSuccessEvent extends InsideEvent {
  const CreateOTPSuccessEvent();

  @override
  List<Object> get props => [];
}

class ReCreateOTPEvent extends InsideEvent {
  const ReCreateOTPEvent();

  @override
  List<Object> get props => [];
}

class CreateOTPEmailExistEvent extends InsideEvent {
  const CreateOTPEmailExistEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class CreateOTPErrorEvent extends InsideEvent {
  const CreateOTPErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class RemoveCVSuccessEvent extends InsideEvent {
  const RemoveCVSuccessEvent();

  @override
  List<Object> get props => [];
}

class RemoveCVErrorEvent extends InsideEvent {
  const RemoveCVErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class GetCompanySuccessEvent extends InsideEvent {
  const GetCompanySuccessEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyErrorEvent extends InsideEvent {
  const GetCompanyErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class GetListSuccessEvent extends InsideEvent {
  const GetListSuccessEvent();

  @override
  List<Object> get props => [];
}

class GetListErrorEvent extends InsideEvent {
  const GetListErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class HistorypaymentLoadingEvent extends InsideEvent {
  const HistorypaymentLoadingEvent();

  @override
  List<Object> get props => [];
}

class HistorypaymentSuccessEvent extends InsideEvent {
  const HistorypaymentSuccessEvent();

  @override
  List<Object> get props => [];
}

class HistorypaymentErrorEvent extends InsideEvent {
  const HistorypaymentErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class CreateReportLoadingEvent extends InsideEvent {
  const CreateReportLoadingEvent();

  @override
  List<Object> get props => [];
}

class CreateReportSuccessEvent extends InsideEvent {
  const CreateReportSuccessEvent();

  @override
  List<Object> get props => [];
}

class CreateReportErrorEvent extends InsideEvent {
  const CreateReportErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class CheckCountSuccessEvent extends InsideEvent {
  const CheckCountSuccessEvent();

  @override
  List<Object> get props => [];
}

class AddMessageLoadingEvent extends InsideEvent {
  const AddMessageLoadingEvent();

  @override
  List<Object> get props => [];
}

class CheckCountOverwriteEvent extends InsideEvent {
  const CheckCountOverwriteEvent({this.messageOverwrite = ''});

  final String messageOverwrite;

  @override
  List<Object> get props => [messageOverwrite];
}

class CheckCountErrorEvent extends InsideEvent {
  const CheckCountErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class AddMessageSuccessEvent extends InsideEvent {
  const AddMessageSuccessEvent();

  @override
  List<Object> get props => [];
}

class AddMessageErrorEvent extends InsideEvent {
  const AddMessageErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class AddCountSuccessEvent extends InsideEvent {
  const AddCountSuccessEvent();

  @override
  List<Object> get props => [];
}

class AddConverstationLoadingEvent extends InsideEvent {
  const AddConverstationLoadingEvent();

  @override
  List<Object> get props => [];
}

class AddConverstationSuccessEvent extends InsideEvent {
  const AddConverstationSuccessEvent();

  @override
  List<Object> get props => [];
}

class AddCountErrorEvent extends InsideEvent {
  const AddCountErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}

class AddConverstationErrorEvent extends InsideEvent {
  const AddConverstationErrorEvent({this.error});

  final String? error;

  @override
  List<Object> get props => [error ?? ''];
}
