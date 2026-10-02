import 'package:dartz/dartz.dart';
import '../../data/models/google_auth_request_model.dart';
import '../../data/models/google_auth_response_model.dart';
import '../../data/models/google_onboarding_request_model.dart';

abstract class GoogleOnboardingRepository {
  Future<Either<String, GoogleAuthResponseModel>> googleAuth(GoogleAuthRequestModel request);
  Future<Either<String, Map<String, dynamic>>> completeOnboarding(GoogleOnboardingRequestModel request);
}