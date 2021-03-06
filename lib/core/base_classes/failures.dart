import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure() : super();
}

class GeneralFailure extends Failure {
  final String message;

  const GeneralFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
