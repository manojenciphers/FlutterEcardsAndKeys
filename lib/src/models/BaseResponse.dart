class BaseResponse {
  final String success;
  final String error;

  BaseResponse({this.success, this.error});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'],
      error: json['error'],
    );
  }
}