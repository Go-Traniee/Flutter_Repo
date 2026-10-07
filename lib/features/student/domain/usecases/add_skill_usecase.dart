import '../repositories/student_skill_repository.dart';
import '../../data/models/student_skill_model.dart';
import '../../data/models/add_skill_request_model.dart';

class AddSkillUseCase {
  final StudentSkillRepository repository;
  AddSkillUseCase(this.repository);

  Future<StudentSkillModel> call(AddSkillRequestModel request) {
    return repository.addSkill(request);
  }
}