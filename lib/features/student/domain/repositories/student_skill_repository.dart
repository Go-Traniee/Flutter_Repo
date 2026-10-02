// domain/repositories/student_skill_repository.dart
import '../../data/models/skill_model.dart';
import '../../data/models/student_skill_model.dart';

abstract class StudentSkillRepository {
  Future<List<SkillModel>> getAvailableSkills();
  Future<StudentSkillModel> addSkill({required int skillId, required String proficiency});
  Future<void> deleteSkill(int studentSkillId);
}