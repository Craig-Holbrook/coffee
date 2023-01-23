import 'package:coffee/app/app.dart';
import 'package:coffee/coffee/coffee.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffee_storage_repository/coffee_storage_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCoffeeRepository extends Mock implements CoffeeRepository {}

// ignore: lines_longer_than_80_chars
class _MockCoffeeStorageRepository extends Mock implements CoffeeStorageRepository {}

void main() {
  group('App', () {
    late CoffeeRepository coffeeRepository;
    late CoffeeStorageRepository coffeeStorageRepository;

    setUp(() {
      coffeeRepository = _MockCoffeeRepository();
      coffeeStorageRepository = _MockCoffeeStorageRepository();
    });
    testWidgets('renders CoffeePage', (tester) async {
      await tester.pumpWidget(
        App(
          coffeeRepository: coffeeRepository,
          coffeeStorageRepository: coffeeStorageRepository,
        ),
      );
      expect(find.byType(CoffeePage), findsOneWidget);
    });
  });
}
