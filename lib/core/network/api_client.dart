/*import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ApiConstants {
  static const String baseUrl = "http://127.0.0.1:8000/api/";
  static const String login = "login";
  static const String register = "register";
  static const String googleAuth = "auth/google";
  static const String googleOnboarding = "auth/google/onboarding";
}

class ApiClient {
  final Dio dio;

  ApiClient(this.dio) {
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  // 1. تسجيل الدخول (Login)
  Future<AuthResponseModel> login({
    required String email,
    required String password,})
  async {
    final response = await dio.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  // 2. إنشاء حساب جديد (Register)
  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role, // تأكدي: "student" أو "organization"
  }) async {
    final response = await dio.post(
      ApiConstants.register,
      data: {
        'name': name,
        'email': email,
        'role': role,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  // 3. تسجيل الدخول بجوجل - الخطوة الأولى
  Future<Response> authenticateWithGoogle({
    required String googleToken,
  }) async {
    final response = await dio.post(
      ApiConstants.googleAuth,
      data: {
        'google_token': googleToken,
      },
    );
    return response;
  }

  // 4. إكمال بيانات تسجيل جوجل - الخطوة الثانية
  Future<AuthResponseModel> completeGoogleOnboarding({
    required String onboardingToken,
    required String role, // "student" أو "organization"
    Map<String, dynamic>? extraData,
  }) async {
    final Map<String, dynamic> requestData = {
      'onboarding_token': onboardingToken,
      'role': role,
    };

    if (extraData != null) {
      requestData.addAll(extraData);
    }

    final response = await dio.post(
      ApiConstants.googleOnboarding,
      data: requestData,
    );
    return AuthResponseModel.fromJson(response.data);
  }
}*/