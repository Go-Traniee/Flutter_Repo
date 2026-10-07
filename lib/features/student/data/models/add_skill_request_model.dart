class AddSkillRequestModel {
  final int skillId;
  final String? proficiency; // ⚠️ nullable لحد ما يتأكد قرار الباك اند النهائي

  AddSkillRequestModel({
    required this.skillId,
    this.proficiency,
  });

  Map<String, dynamic> toJson() {
    return {
      'skill_id': skillId,
      if (proficiency != null) 'proficiency': proficiency,
    };
  }
}