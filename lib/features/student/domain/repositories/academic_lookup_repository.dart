import '../../data/models/university_model.dart';
import '../../data/models/major_model.dart';

abstract class AcademicLookupRepository {
  Future<List<UniversityModel>> getUniversities();
  Future<List<MajorModel>> getMajors();
}