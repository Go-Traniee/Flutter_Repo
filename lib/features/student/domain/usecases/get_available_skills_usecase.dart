import 'package:gotraniee_flutter/features/student/data/models/skill_model.dart';
import 'package:gotraniee_flutter/features/student/domain/repositories/student_skill_repository.dart';

class GetAvailableSkillsUseCase {
  final StudentSkillRepository repository;
  GetAvailableSkillsUseCase(this.repository);

  Future<List<SkillModel>> call() => repository.getAvailableSkills();
}
