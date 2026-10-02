import '../../data/models/student_skill_model.dart';
import '../../data/models/skill_model.dart';

abstract class StudentSkillState {}

class StudentSkillInitial extends StudentSkillState {}

class StudentSkillLoading extends StudentSkillState {}

class StudentSkillLoaded extends StudentSkillState {
  final List<SkillModel> availableSkills;      // كل المهارات من /skills
  final List<StudentSkillModel> addedSkills;   // مهارات الطالب المضافة فعلياً
  final SkillModel? selectedSkill;             // الاختيار الحالي بالدروب داون

  StudentSkillLoaded({
    required this.availableSkills,
    required this.addedSkills,
    this.selectedSkill,
  });

  StudentSkillLoaded copyWith({
    List<SkillModel>? availableSkills,
    List<StudentSkillModel>? addedSkills,
    SkillModel? selectedSkill,
    bool clearSelected = false,
  }) {
    return StudentSkillLoaded(
      availableSkills: availableSkills ?? this.availableSkills,
      addedSkills: addedSkills ?? this.addedSkills,
      selectedSkill: clearSelected ? null : (selectedSkill ?? this.selectedSkill),
    );
  }
}

class StudentSkillError extends StudentSkillState {
  final String message;
  StudentSkillError(this.message);
}