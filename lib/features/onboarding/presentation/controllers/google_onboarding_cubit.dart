import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/google_onboarding_usecase.dart';
import '../../data/models/google_onboarding_request_model.dart';
import 'google_onboarding_state.dart';

class GoogleOnboardingCubit extends Cubit<GoogleOnboardingState> {
  final GoogleOnboardingUseCase googleOnboardingUseCase;

  GoogleOnboardingCubit(this.googleOnboardingUseCase)
      : super(GoogleOnboardingInitial());

  Future<void> submitOnboarding(GoogleOnboardingRequestModel requestModel) async {
    emit(GoogleOnboardingLoading());

    final result = await googleOnboardingUseCase.executeCompleteOnboarding(requestModel);

    result.fold(
          (failure) => emit(GoogleOnboardingFailure(failure)),
          (data) => emit(GoogleOnboardingSuccess(data)),
    );
  }
}