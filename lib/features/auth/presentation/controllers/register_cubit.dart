//إدارة الحالة (Loading/Success/Failure)
//المدير: يستقبل الطلب، يبث الحالة المناسبة
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/register_request_model.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register(RegisterRequestModel requestModel) async {
    emit(RegisterLoading());
    try {
      final response = await registerUseCase(requestModel);
      emit(RegisterSuccess(response));
    } catch (e) {
      emit(RegisterFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}