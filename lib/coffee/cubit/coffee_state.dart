part of 'coffee_cubit.dart';

enum CoffeeRequestStatus { initial, loading, successful, failed }

class CoffeeState extends Equatable {
  const CoffeeState({
    required this.status,
    this.coffeePicture,
  });

  final CoffeeRequestStatus status;
  final CoffeePicture? coffeePicture;

  @override
  String toString() => 'CoffeeState(status: $status, activity: $coffeePicture)';

  @override
  List<Object?> get props => [status, coffeePicture];
}
