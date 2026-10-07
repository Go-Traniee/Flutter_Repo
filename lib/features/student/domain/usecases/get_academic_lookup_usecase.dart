import '../repositories/academic_lookup_repository.dart';
import '../../data/models/university_model.dart';
import '../../data/models/major_model.dart';

class AcademicLookupResult {
  final List<UniversityModel> universities;
  final List<MajorModel> majors;
  AcademicLookupResult({required this.universities, required this.majors});
}

class GetAcademicLookupUseCase {
  final AcademicLookupRepository repository;
  GetAcademicLookupUseCase(this.repository);

  Future<AcademicLookupResult> call() async {
    final universities = await repository.getUniversities();
    final majors = await repository.getMajors();
    return AcademicLookupResult(universities: universities, majors: majors);
  }
}