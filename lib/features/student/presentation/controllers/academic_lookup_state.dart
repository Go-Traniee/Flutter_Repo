import '../../data/models/university_model.dart';
import '../../data/models/major_model.dart';

abstract class AcademicLookupState {}
class AcademicLookupInitial extends AcademicLookupState {}
class AcademicLookupLoading extends AcademicLookupState {}
class AcademicLookupLoaded extends AcademicLookupState {
  final List<UniversityModel> universities;
  final List<MajorModel> majors;
  AcademicLookupLoaded({required this.universities, required this.majors});
}
class AcademicLookupError extends AcademicLookupState {
  final String message;
  AcademicLookupError(this.message);
}