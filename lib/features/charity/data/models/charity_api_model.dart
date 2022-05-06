/// model used by the data sources
class CharityApiModel {
  final String description;
  final double amount;
  final String currency;
  final int date;
  final String createdBy;
  final String type;
  String? key;

  CharityApiModel(
      {required this.description,
      required this.amount,
      required this.currency,
      required this.date,
      required this.createdBy,
      required this.type,
      this.key});

  CharityApiModel.fromJson(Map<dynamic, dynamic> json)
      : description = json['description'] as String,
        amount = json['amount'].toDouble(),
        currency = json['currency'] as String,
        date = json['date'] as int,
        createdBy = json['createdBy'] as String,
        type = json['type'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'description': description,
        'amount': amount,
        'currency': currency,
        'date': date,
        'createdBy': createdBy,
        'type': type
      };
}
