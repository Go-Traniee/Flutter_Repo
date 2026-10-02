import '../repositories/student_skill_repository.dart';
import '../../data/models/student_skill_model.dart';

class AddSkillUseCase {
  final StudentSkillRepository repository;
  AddSkillUseCase(this.repository);

  Future<StudentSkillModel> call({required int skillId, required String proficiency}) {
    return repository.addSkill(skillId: skillId, proficiency: proficiency);
  }
}