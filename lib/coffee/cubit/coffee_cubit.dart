import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit(this._coffeeRepository)
      : super(const CoffeeState(status: CoffeeRequestStatus.initial));

  final CoffeeRepository _coffeeRepository;

  Future<void> getCoffee() async {
    emit(const CoffeeState(status: CoffeeRequestStatus.loading));

    try {
      final coffeePicture = await _coffeeRepository.getCoffeePicture();
      emit(
        CoffeeState(
          status: CoffeeRequestStatus.successful,
          coffeePicture: coffeePicture,
        ),
      );
    } catch (e) {
      log('error : $e');
      emit(const CoffeeState(status: CoffeeRequestStatus.failed));
    }
  }

  void reset() {
    emit(const CoffeeState(status: CoffeeRequestStatus.initial));
  }
}
