import 'package:dio/dio.dart';
import '../datasources/academic_lookup_remote_datasource.dart';
import '../../domain/repositories/academic_lookup_repository.dart';
import '../models/university_model.dart';
import '../models/major_model.dart';

class AcademicLookupRepositoryImpl implements AcademicLookupRepository {
  final AcademicLookupRemoteDataSource remoteDataSource;
  AcademicLookupRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<UniversityModel>> getUniversities() async {
    try {
      return await remoteDataSource.getUniversities();
    } on DioException catch (e) {
      throw Exception(_extractError(e));
    }
  }

  @override
  Future<List<MajorModel>> getMajors() async {
    try {
      return await remoteDataSource.getMajors();
    } on DioException catch (e) {
      throw Exception(_extractError(e));
    }
  }

  String _extractError(DioException e) {
    final msg = e.response?.data is Map ? e.response?.data['message'] : null;
    return msg ?? 'تعذر تحميل البيانات، حاول مرة أخرى';
  }
}