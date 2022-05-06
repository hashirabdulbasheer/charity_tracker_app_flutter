part of 'charity_bloc.dart';

abstract class CharityEvent extends Equatable {
  const CharityEvent();
}

class CharityLoadEvent extends CharityEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CharityAddEvent extends CharityEvent {
  final Charity charity;

  const CharityAddEvent({required this.charity});

  @override
  List<Object?> get props => [charity];
}

class CharityUpdateEvent extends CharityEvent {
  final Charity charity;

  const CharityUpdateEvent({required this.charity});

  @override
  List<Object?> get props => [charity];
}

class CharityDeleteEvent extends CharityEvent {
  final Charity charity;

  const CharityDeleteEvent({required this.charity});

  @override
  List<Object?> get props => [charity];
}
