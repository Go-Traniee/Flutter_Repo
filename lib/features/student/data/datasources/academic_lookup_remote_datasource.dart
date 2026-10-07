import 'package:dio/dio.dart';
import '../models/university_model.dart';
import '../models/major_model.dart';

abstract class AcademicLookupRemoteDataSource {
  Future<List<UniversityModel>> getUniversities();
  Future<List<MajorModel>> getMajors();
}

class AcademicLookupRemoteDataSourceImpl implements AcademicLookupRemoteDataSource {
  final Dio dio;
  AcademicLookupRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UniversityModel>> getUniversities() async {
    final response = await dio.get('universities'); // ⚠️ تأكدي من الاسم الصحيح مع الليدر
    final List data = response.data['data'] as List;
    return data.map((json) => UniversityModel.fromJson(json)).toList();
  }

  @override
  Future<List<MajorModel>> getMajors() async {
    final response = await dio.get('majors'); // ⚠️ تأكدي من الاسم الصحيح مع الليدر
    final List data = response.data['data'] as List;
    return data.map((json) => MajorModel.fromJson(json)).toList();
  }
}