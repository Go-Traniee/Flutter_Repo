import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_available_skills_usecase.dart';
import '../../domain/usecases/add_skill_usecase.dart';
import '../../domain/usecases/delete_skill_usecase.dart';
import '../../data/models/skill_model.dart';
import 'student_skill_state.dart';

class StudentSkillCubit extends Cubit<StudentSkillState> {
  final GetAvailableSkillsUseCase getAvailableSkillsUseCase;
  final AddSkillUseCase addSkillUseCase;
  final DeleteSkillUseCase deleteSkillUseCase;

  StudentSkillCubit({
    required this.getAvailableSkillsUseCase,
    required this.addSkillUseCase,
    required this.deleteSkillUseCase,
  }) : super(StudentSkillInitial());

  Future<void> loadSkills() async {
    emit(StudentSkillLoading());
    try {
      final availableSkills = await getAvailableSkillsUseCase();
      emit(StudentSkillLoaded(availableSkills: availableSkills, addedSkills: []));
    } catch (e) {
      emit(StudentSkillError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void selectSkill(SkillModel skill) {
    final currentState = state;
    if (currentState is StudentSkillLoaded) {
      emit(currentState.copyWith(selectedSkill: skill));
    }
  }

  Future<void> addSelectedSkill({String proficiency = 'beginner'}) async {
    final currentState = state;
    if (currentState is! StudentSkillLoaded || currentState.selectedSkill == null) return;

    final skillToAdd = currentState.selectedSkill!;

    // منع تكرار محلي قبل الإرسال (الباك اند أيضاً بيرفض، هاد تحسين تجربة فقط)
    final alreadyAdded = currentState.addedSkills.any((s) => s.skill.id == skillToAdd.id);
    if (alreadyAdded) return;

    try {
      final newStudentSkill = await addSkillUseCase(
        skillId: skillToAdd.id,
        proficiency: proficiency,
      );
      emit(currentState.copyWith(
        addedSkills: [...currentState.addedSkills, newStudentSkill],
        clearSelected: true,
      ));
    } catch (e) {
      emit(StudentSkillError(e.toString().replaceFirst('Exception: ', '')));
      emit(currentState); // نرجع للحالة السابقة بعد إظهار الخطأ، عشان القائمة ما تختفي
    }
  }

  Future<void> deleteSkill(int studentSkillId) async {
    final currentState = state;
    if (currentState is! StudentSkillLoaded) return;

    try {
      await deleteSkillUseCase(studentSkillId);
      emit(currentState.copyWith(
        addedSkills: currentState.addedSkills.where((s) => s.id != studentSkillId).toList(),
      ));
    } catch (e) {
      emit(StudentSkillError(e.toString().replaceFirst('Exception: ', '')));
      emit(currentState);
    }
  }
}