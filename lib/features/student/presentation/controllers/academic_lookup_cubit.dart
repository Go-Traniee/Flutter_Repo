import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_academic_lookup_usecase.dart';
import 'academic_lookup_state.dart';

class AcademicLookupCubit extends Cubit<AcademicLookupState> {
  final GetAcademicLookupUseCase getAcademicLookupUseCase;
  AcademicLookupCubit(this.getAcademicLookupUseCase) : super(AcademicLookupInitial());

  Future<void> load() async {
    emit(AcademicLookupLoading());
    try {
      final result = await getAcademicLookupUseCase();
      emit(AcademicLookupLoaded(universities: result.universities, majors: result.majors));
    } catch (e) {
      emit(AcademicLookupError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}