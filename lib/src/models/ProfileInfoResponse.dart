class ProfileInfoResponse {
  final String email;
  final String username;
  final String message;

  ProfileInfoResponse({this.email, this.username, this.message});

  factory ProfileInfoResponse.fromJson(Map<String, dynamic> json) {
    return ProfileInfoResponse(
        email: json['email'],
        username: json['username'],
        message: json['message']);
  }
}