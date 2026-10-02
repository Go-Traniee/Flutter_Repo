import 'package:dio/dio.dart';
import '../models/login_request_model.dart';

abstract class LoginRemoteDataSource {
  Future<Map<String, dynamic>> login(LoginRequestModel requestModel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> login(LoginRequestModel requestModel) async {
    final response = await dio.post(
      'login',
      data: requestModel.toJson(),
    );
    return response.data;
  }
}