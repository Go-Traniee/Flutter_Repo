import 'package:dartz/dartz.dart';

import 'package:google_sign_in/google_sign_in.dart';
import '../repositories/google_onboarding_repository.dart';
import '../../data/models/google_auth_request_model.dart';
import '../../data/models/google_auth_response_model.dart';
import '../../data/models/google_onboarding_request_model.dart';

class GoogleOnboardingUseCase {
  final GoogleOnboardingRepository repository;

  GoogleOnboardingUseCase({required this.repository});

  Future<Either<String, GoogleAuthResponseModel>> signInWithGoogle() async {
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken == null) {
        return const Left('لم يتم الحصول على idToken من Google');}

      return await repository.googleAuth(GoogleAuthRequestModel(idToken: idToken));
    } catch (e) {
      return Left('فشل تسجيل الدخول عبر Google: $e');
    }
  }

  Future<Either<String, Map<String, dynamic>>> executeCompleteOnboarding(
      GoogleOnboardingRequestModel request) async {
    return await repository.completeOnboarding(request);
  }
}