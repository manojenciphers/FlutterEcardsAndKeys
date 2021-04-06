class CardInfo {
  final String id;
  final String card_number;
  final String card_name;
  final String card_expiration;
  final String card_cvv;

  CardInfo({this.id, this.card_number, this.card_name, this.card_expiration, this.card_cvv});

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      id: json['id'],
      card_number: json['card_number'],
      card_name: json['card_name'],
      card_expiration: json['card_expiration'],
      card_cvv: json['card_cvv'],
    );
  }
}