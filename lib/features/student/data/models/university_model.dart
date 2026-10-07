class UniversityModel {
  final int id;
  final String name;
  UniversityModel({required this.id, required this.name});

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(id: json['id'] as int, name: json['name'] as String);
  }
}