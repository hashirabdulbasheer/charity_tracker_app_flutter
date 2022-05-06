import 'package:charity_tracker/core/configs/charity_configs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_classes/failures.dart';
import '../../../../core/base_classes/use_cases.dart';
import '../../../../core/enums/charity_type.dart';
import '../../domain/entities/charity.dart';
import '../../domain/use_cases/create_charity_use_case.dart';
import '../../domain/use_cases/delete_charity_use_case.dart';
import '../../domain/use_cases/get_all_charities_use_case.dart';
import '../../domain/use_cases/update_charity_use_case.dart';

part 'charity_event.dart';

part 'charity_state.dart';

class CharityBloc extends Bloc<CharityEvent, CharityState> {
  final CharityCreateUseCase createUseCase;
  final CharityUpdateUseCase updateUseCase;
  final CharityDeleteUseCase deleteUseCase;
  final GetAllCharitiesUseCase getAllUseCase;

  CharityBloc(
      {required this.createUseCase,
      required this.updateUseCase,
      required this.deleteUseCase,
      required this.getAllUseCase})
      : super(CharityInitialState()) {
    on<CharityLoadEvent>((event, emit) async {
      emit(CharityLoadingState());
      final response = await getAllUseCase.call(NoParams());
      if (response.isRight) {
        List<Charity> charities = response.right;
        emit(CharityLoadedState(
            charities: charities,
            totalAmount: _totalAmount(charities),
            selectedType: CharityType.notAssigned));
      } else {
        GeneralFailure failure = response.left as GeneralFailure;
        emit(CharityErrorState(message: failure.message));
        emit(const CharityLoadedState(
            charities: [], totalAmount: 0, selectedType: CharityType.notAssigned));
      }
    });

    on<CharityAddEvent>((event, emit) async {
      emit(CharityLoadingState());
      final response = await createUseCase.call(event.charity);
      if (response.isLeft) {
        GeneralFailure failure = response.left as GeneralFailure;
        emit(CharityErrorState(message: failure.message));
      }
      add(CharityLoadEvent());
    });

    on<CharityUpdateEvent>((event, emit) async {
      emit(CharityLoadingState());
      final response = await updateUseCase.call(event.charity);
      if (response.isLeft) {
        GeneralFailure failure = response.left as GeneralFailure;
        emit(CharityErrorState(message: failure.message));
      }
      add(CharityLoadEvent());
    });

    on<CharityDeleteEvent>((event, emit) async {
      emit(CharityLoadingState());
      final response = await deleteUseCase.call(event.charity);
      if (response.isLeft) {
        GeneralFailure failure = response.left as GeneralFailure;
        emit(CharityErrorState(message: failure.message));
      }
      add(CharityLoadEvent());
    });
  }

  bool isEditAllowed(Charity charity) {
    // only allow edit if the entry was created by the logged in user
    if (CharityConfig.currentUser.toLowerCase() == charity.createdBy.toLowerCase()) {
      return true;
    }
    return false;
  }

  double _totalAmount(List<Charity> charities) {
    double amount = 0;
    for (Charity charity in charities) {
      amount = amount + charity.amount;
    }
    return amount;
  }
}
