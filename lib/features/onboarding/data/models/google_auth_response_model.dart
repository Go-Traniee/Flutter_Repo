class GoogleAuthResponseModel {
  final String? token;
  final bool requiresOnboarding;
  final Map<String, dynamic>? userData;

  GoogleAuthResponseModel({
    this.token,
    required this.requiresOnboarding,
    this.userData,
  });

  factory GoogleAuthResponseModel.fromJson(Map<String, dynamic> json) {
    return GoogleAuthResponseModel(
      token: json['token'] as String?,
      requiresOnboarding: json['requires_onboarding'] ?? false,
      userData: json['user'] as Map<String, dynamic>?,
    );
  }
}