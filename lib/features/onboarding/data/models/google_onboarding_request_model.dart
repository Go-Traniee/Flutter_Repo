class GoogleOnboardingRequestModel {
  final String role; // 'student' أو 'organization'
  final String? phone;
  final String? bio;

  GoogleOnboardingRequestModel({
    required this.role,
    this.phone,
    this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      if (phone != null) 'phone': phone,
      if (bio != null) 'bio': bio,
    };
  }
}