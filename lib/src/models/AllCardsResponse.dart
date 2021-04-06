import 'package:flutter_ecards/src/models/CardInfo.dart';

class AllCardsResponse {
  final String message;
  final List<CardInfo> cards;

  AllCardsResponse({this.message, this.cards});

  factory AllCardsResponse.fromJson(Map<String, dynamic> json) {
    return AllCardsResponse(
      message: json['message'],
      cards: json['cards'],
    );
  }
}