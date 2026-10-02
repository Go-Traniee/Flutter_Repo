import 'package:dio/dio.dart';
import '../models/skill_model.dart';
import '../models/student_skill_model.dart';

abstract class StudentSkillRemoteDataSource {
  Future<List<SkillModel>> getAvailableSkills();
  Future<StudentSkillModel> addSkill({required int skillId, required String proficiency});
  Future<void> deleteSkill(int studentSkillId);
}

class StudentSkillRemoteDataSourceImpl implements StudentSkillRemoteDataSource {
  final Dio dio;
  StudentSkillRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SkillModel>> getAvailableSkills() async {
    final response = await dio.get('skills');
    final List data = response.data['data'] as List;
    return data.map((json) => SkillModel.fromJson(json)).toList();
  }

  @override
  Future<StudentSkillModel> addSkill({required int skillId, required String proficiency}) async {
    final response = await dio.post('student/skills', data: {
      'skill_id': skillId,
      'proficiency': proficiency,
    });
    return StudentSkillModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<void> deleteSkill(int studentSkillId) async {
    await dio.delete('student/skills/$studentSkillId');
  }
}