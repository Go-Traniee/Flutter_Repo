// availability_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/update_availability_usecase.dart';
import '../../data/models/availability_request_model.dart';
import 'availability_state.dart';

class AvailabilityCubit extends Cubit<AvailabilityState> {
  final UpdateAvailabilityUseCase updateAvailabilityUseCase;
  AvailabilityCubit(this.updateAvailabilityUseCase) : super(AvailabilityInitial());

  Future<void> save(AvailabilityRequestModel request) async {
    emit(AvailabilityLoading());
    try {
      await updateAvailabilityUseCase(request);
      emit(AvailabilitySaved());
    } catch (e) {
      emit(AvailabilityError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}