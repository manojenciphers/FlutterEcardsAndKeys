class LoginResponse {
  final String success;
  final String error;
  final String token;
  final String username;

  LoginResponse({this.success, this.error, this.token, this.username});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      error: json['error'],
      token: json['token'],
      username: json['username'],
    );
  }
}
