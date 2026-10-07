class MajorModel {
  final int id;
  final String name;
  MajorModel({required this.id, required this.name});

  factory MajorModel.fromJson(Map<String, dynamic> json) {
    return MajorModel(id: json['id'] as int, name: json['name'] as String);
  }
}