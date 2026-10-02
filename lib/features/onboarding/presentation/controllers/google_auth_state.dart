import '../../data/models/google_auth_response_model.dart';

abstract class GoogleAuthState {}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthSuccess extends GoogleAuthState {
  final GoogleAuthResponseModel response;
  GoogleAuthSuccess(this.response);
}

class GoogleAuthFailure extends GoogleAuthState {
  final String errorMessage;
  GoogleAuthFailure(this.errorMessage);
}