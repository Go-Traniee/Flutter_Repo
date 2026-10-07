import '../../data/models/skill_model.dart';
import '../../data/models/student_skill_model.dart';
import '../../data/models/add_skill_request_model.dart';

abstract class StudentSkillRepository {
  Future<List<SkillModel>> getAvailableSkills();
  Future<StudentSkillModel> addSkill(AddSkillRequestModel request);
  Future<void> deleteSkill(int studentSkillId);
}