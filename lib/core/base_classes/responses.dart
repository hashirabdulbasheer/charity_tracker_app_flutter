import 'package:equatable/equatable.dart';

abstract class Response extends Equatable {
  const Response() : super();
}

class CharityResponse extends Response {
  final bool isSuccessful;
  final String? errorMessage;
  final dynamic successObject;

  const CharityResponse({required this.isSuccessful, this.errorMessage, this.successObject});

  @override
  List<Object?> get props => [isSuccessful, errorMessage, successObject];
}
