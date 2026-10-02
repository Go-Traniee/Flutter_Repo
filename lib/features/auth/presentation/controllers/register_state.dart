import '../../../../core/models/user_model.dart';
//قائمة كل الحالات الممكنة (تحميل/نجاح/فشل)
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final AuthResponseModel response;
  RegisterSuccess(this.response);
}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure(this.message);
}