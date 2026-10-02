//عالجة النجاح/الفشل وحفظ التوكن
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../datasources/register_remote_datasource.dart';
import '../../domain/repositories/register_repository.dart';
import '../models/register_request_model.dart';
import '../../../../core/models/user_model.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  RegisterRepositoryImpl(this.remoteDataSource, this.secureStorage);

  @override
  Future<AuthResponseModel> register(RegisterRequestModel requestModel) async {
    try {
      final response = await remoteDataSource.register(requestModel);

      // ✅ جديد: حفظ التوكن بنفس طريقة سندس بالضبط، عشان الاتساق بالمشروع
      await secureStorage.write(key: 'auth_token', value: response.token);

      return response;
    } on DioException catch (e) {
      final serverMessage = e.response?.data is Map
          ? e.response?.data['message']
          : null;
      throw Exception(serverMessage ?? 'حدث خطأ أثناء الاتصال بالخادم');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع، حاولي مرة أخرى');
    }
  }
}