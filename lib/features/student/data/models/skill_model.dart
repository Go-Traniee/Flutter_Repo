class SkillModel {
  final int id;
  final String name;

  SkillModel({required this.id, required this.name});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}