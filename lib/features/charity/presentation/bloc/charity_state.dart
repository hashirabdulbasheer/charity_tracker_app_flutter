part of 'charity_bloc.dart';

abstract class CharityState extends Equatable {
  const CharityState();
}

class CharityInitialState extends CharityState {
  @override
  List<Object> get props => [];
}

class CharityLoadingState extends CharityState {
  @override
  List<Object> get props => [];
}

class CharityLoadedState extends CharityState {
  final List<Charity> charities;
  final double totalAmount;
  final CharityType selectedType;

  const CharityLoadedState(
      {required this.charities, required this.totalAmount, required this.selectedType});

  @override
  List<Object> get props => [charities, selectedType, totalAmount];
}

class CharityErrorState extends CharityState {
  final String message;

  const CharityErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CharitySuccessState extends CharityState {
  final String message;

  const CharitySuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}
