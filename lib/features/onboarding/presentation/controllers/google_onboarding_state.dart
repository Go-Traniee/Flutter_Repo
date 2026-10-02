abstract class GoogleOnboardingState {}

class GoogleOnboardingInitial extends GoogleOnboardingState {}

class GoogleOnboardingLoading extends GoogleOnboardingState {}

class GoogleOnboardingSuccess extends GoogleOnboardingState {
  final Map<String, dynamic> responseData;
  GoogleOnboardingSuccess(this.responseData);
}

class GoogleOnboardingFailure extends GoogleOnboardingState {
  final String errorMessage;
  GoogleOnboardingFailure(this.errorMessage);
}