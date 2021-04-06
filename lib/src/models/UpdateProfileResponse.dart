class UpdateProfileResponse {
  final String success;
  final String error;

  UpdateProfileResponse({this.success, this.error});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
        success: json['success'],
        error: json['error']);
  }
}