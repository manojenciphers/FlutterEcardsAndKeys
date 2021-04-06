class AddCardResponse {
  final String message;

  AddCardResponse({this.message});

  factory AddCardResponse.fromJson(Map<String, dynamic> json) {
    return AddCardResponse(
      message: json['message'],
    );
  }
}