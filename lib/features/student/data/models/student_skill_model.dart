import 'skill_model.dart';

class StudentSkillModel {
  final int id; // ← id تبع StudentSkill نفسه، لازم للحذف والتعديل
  final SkillModel skill;
  final String proficiency;

  StudentSkillModel({
    required this.id,
    required this.skill,
    required this.proficiency,
  });

  factory StudentSkillModel.fromJson(Map<String, dynamic> json) {
    return StudentSkillModel(
      id: json['id'] as int,
      skill: SkillModel.fromJson(json['skill'] as Map<String, dynamic>),
      proficiency: json['proficiency'] as String,
    );
  }
}