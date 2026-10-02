import 'package:gotraniee_flutter/features/student/domain/repositories/student_skill_repository.dart';

class DeleteSkillUseCase {
  final StudentSkillRepository repository;
  DeleteSkillUseCase(this.repository);

  Future<void> call(int studentSkillId) => repository.deleteSkill(studentSkillId);
}