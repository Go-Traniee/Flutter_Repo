class LoginRequestModel {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isStudent;

  LoginRequestModel({
    required this.email,
    required this.password,
    this.rememberMe = false,
    this.isStudent = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email.trim().toLowerCase(),
      'password': password,
    };
  }
}