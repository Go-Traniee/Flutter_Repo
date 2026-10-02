//فصل المنطق عن التفاصيل
//	وسيط بسيط بين الكيوبت والريبوزيتوري

import '../repositories/register_repository.dart';
import '../../data/models/register_request_model.dart';
import '../../../../core/models/user_model.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<AuthResponseModel> call(RegisterRequestModel requestModel) {
    return repository.register(requestModel);
  }
}