class SignupResponse {
  final String username;
  final String error;
  SignupResponse({this.username, this.error});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      username: json['username'],
      error: json['error'],
    );
  }
}