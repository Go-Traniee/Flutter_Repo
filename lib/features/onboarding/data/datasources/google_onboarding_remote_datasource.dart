import 'package:dio/dio.dart';
import '../models/google_auth_request_model.dart';
import '../models/google_auth_response_model.dart';
import '../models/google_onboarding_request_model.dart';

abstract class GoogleOnboardingRemoteDataSource {
  Future<GoogleAuthResponseModel> googleAuth(GoogleAuthRequestModel request);
  Future<Map<String, dynamic>> completeOnboarding(GoogleOnboardingRequestModel request);
}

class GoogleOnboardingRemoteDataSourceImpl implements GoogleOnboardingRemoteDataSource {
  final Dio dio;

  GoogleOnboardingRemoteDataSourceImpl({required this.dio});

  @override
  Future<GoogleAuthResponseModel> googleAuth(GoogleAuthRequestModel request) async {
    final response = await dio.post('auth/google', data: request.toJson());
    return GoogleAuthResponseModel.fromJson(response.data);
  }

  @override
  Future<Map<String, dynamic>> completeOnboarding(GoogleOnboardingRequestModel request) async {
    final response = await dio.post('auth/google/onboarding', data: request.toJson());
    return response.data as Map<String, dynamic>;
  }
}