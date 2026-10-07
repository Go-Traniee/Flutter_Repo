import '../repositories/student_skill_repository.dart';
import '../../data/models/skill_model.dart';

class GetAvailableSkillsUseCase {
  final StudentSkillRepository repository;
  GetAvailableSkillsUseCase(this.repository);

  Future<List<SkillModel>> call() => repository.getAvailableSkills();
}