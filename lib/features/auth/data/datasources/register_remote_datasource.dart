//بيتصل بالإنترنت ويرسل الطلب
import 'package:dio/dio.dart';
import '../models/register_request_model.dart';
import '../../../../core/models/user_model.dart';

abstract class RegisterRemoteDataSource {
  Future<AuthResponseModel> register(RegisterRequestModel requestModel);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final Dio dio;

  RegisterRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthResponseModel> register(RegisterRequestModel requestModel) async {
    final response = await dio.post(
      '/register',
      data: requestModel.toJson(),
    );
    return AuthResponseModel.fromJson(response.data);
  }
}