class GoogleAuthRequestModel {
  final String idToken;

  GoogleAuthRequestModel({required this.idToken});

  Map<String, dynamic> toJson() {
    return {
      'id_token': idToken,
    };
  }
}