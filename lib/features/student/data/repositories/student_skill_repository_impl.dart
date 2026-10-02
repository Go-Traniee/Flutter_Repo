// data/repositories/student_skill_repository_impl.dart
import 'package:dio/dio.dart';
import '../datasources/student_skill_remote_datasource.dart';
import '../../domain/repositories/student_skill_repository.dart';
import '../models/skill_model.dart';
import '../models/student_skill_model.dart';

class StudentSkillRepositoryImpl implements StudentSkillRepository {
  final StudentSkillRemoteDataSource remoteDataSource;
  StudentSkillRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<SkillModel>> getAvailableSkills() async {
    try {
      return await remoteDataSource.getAvailableSkills();
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<StudentSkillModel> addSkill({required int skillId, required String proficiency}) async {
    try {
      return await remoteDataSource.addSkill(skillId: skillId, proficiency: proficiency);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> deleteSkill(int studentSkillId) async {
    try {
      await remoteDataSource.deleteSkill(studentSkillId);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  String _extractErrorMessage(DioException e) {
    if (e.response?.statusCode == 422) {
      final errors = e.response?.data['errors'] as Map<String, dynamic>?;
      if (errors != null && errors.isNotEmpty) {
        final firstError = errors.values.first;
        return firstError is List ? firstError.first.toString() : firstError.toString();
      }
    }
    final serverMessage = e.response?.data is Map ? e.response?.data['message'] : null;
    return serverMessage ?? 'حدث خطأ أثناء الاتصال بالخادم';
  }
}