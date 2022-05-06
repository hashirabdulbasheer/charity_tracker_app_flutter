import 'package:equatable/equatable.dart';

import '../../data/models/charity_api_model.dart';
import '../../data/models/mappers/charity_mappers.dart';

/// Domain model
class Charity extends Equatable {
  final String description;
  final double amount;
  final String currency;
  final int date;
  final String createdBy;
  final String type;
  final String key;

  const Charity(
      {required this.description,
      required this.amount,
      required this.currency,
      required this.date,
      required this.createdBy,
      required this.type,
      required this.key});

  /// returns amounts in currency format
  String get formattedAmount {
    return amount.toStringAsFixed(2);
  }

  /// use this method to change any final values
  Charity copyWith(
      {String? description,
      double? amount,
      String? currency,
      int? date,
      String? createdBy,
      String? type,
      String? key}) {
    return Charity(
        description: description ?? this.description,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        date: date ?? this.date,
        createdBy: createdBy ?? this.createdBy,
        key: key ?? this.key,
        type: type ?? this.type);
  }

  static Charity fromJson(Map<dynamic, dynamic> json) {
    return CharityMapper.apiModelToCharity(CharityApiModel.fromJson(json));
  }

  @override
  List<Object> get props => [description, amount, currency, date, createdBy, type, key];
}
