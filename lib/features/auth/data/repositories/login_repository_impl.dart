import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_request_model.dart';

abstract class LoginRepository {
  Future<Map<String, dynamic>> login(LoginRequestModel requestModel);
}

class LoginRepositoryImpl implements LoginRepository {
  final Dio dio;
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  LoginRepositoryImpl({
    required this.dio,
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<Map<String, dynamic>> login(LoginRequestModel requestModel) async {
    try {
      final response = await dio.post(
        'login',
        data: requestModel.toJson(),
      );

      final responseData = response.data as Map<String, dynamic>;

      if (responseData.containsKey('token') && responseData['token'] != null) {
        await secureStorage.write(
          key: 'auth_token',
          value: responseData['token'].toString(),
        );
      }

      // ✅ حفظ/مسح الإيميل حسب "تذكرني"، بمفتاح مختلف للطالب والمؤسسة
      final rememberKey =
      requestModel.isStudent ? 'remembered_email' : 'company_remembered_email';

      if (requestModel.rememberMe) {
        await sharedPreferences.setString(rememberKey, requestModel.email);
      } else {
        await sharedPreferences.remove(rememberKey);
      }

      return responseData;
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'] as Map<String, dynamic>?;
        if (errors != null && errors.isNotEmpty) {
          final firstError = errors.values.first;
          final message =
          firstError is List ? firstError.first.toString() : firstError.toString();
          throw Exception(message);
        }
      }
      final serverMessage =
      e.response?.data is Map ? e.response?.data['message'] : null;
      throw Exception(
          serverMessage ?? 'البريد الإلكتروني أو كلمة المرور غير صحيحة');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً');
    }
  }
}