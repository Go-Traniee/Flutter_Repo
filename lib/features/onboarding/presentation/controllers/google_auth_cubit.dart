import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/google_onboarding_usecase.dart';
import 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final GoogleOnboardingUseCase googleOnboardingUseCase;

  GoogleAuthCubit(this.googleOnboardingUseCase) : super(GoogleAuthInitial());

  Future<void> loginWithGoogle() async {
    emit(GoogleAuthLoading());

    final result = await googleOnboardingUseCase.signInWithGoogle();

    result.fold(
          (failure) => emit(GoogleAuthFailure(failure)),
          (responseModel) => emit(GoogleAuthSuccess(responseModel)),
    );
  }
}