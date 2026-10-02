import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/login_request_model.dart';
import '../../data/repositories/login_repository_impl.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(LoginInitial());

  Future<void> login(LoginRequestModel requestModel) async {
    emit(LoginLoading());
    try {
      final response = await loginRepository.login(requestModel);
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}