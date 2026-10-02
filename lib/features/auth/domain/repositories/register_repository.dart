import '../../data/models/register_request_model.dart';
import '../../../../core/models/user_model.dart';
////"لازم يكون في دالة register"
abstract class RegisterRepository {
  Future<AuthResponseModel> register(RegisterRequestModel requestModel);
}