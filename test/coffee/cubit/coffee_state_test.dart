import 'package:coffee/coffee/cubit/coffee_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('coffee state', () {
    test('can be instantiated', () {
      expect(
        const CoffeeState(status: CoffeeRequestStatus.initial),
        isNotNull,
      );
    });

    test('supports value equality', () {
      expect(
        const CoffeeState(status: CoffeeRequestStatus.initial),
        const CoffeeState(status: CoffeeRequestStatus.initial),
      );
    });

    test('toString functionality', () {
      expect(
        const CoffeeState(status: CoffeeRequestStatus.initial).toString(),
        'CoffeeState(status: CoffeeRequestStatus.initial, activity: null)',
      );
    });
  });
}
