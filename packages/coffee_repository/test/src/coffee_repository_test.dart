import 'dart:typed_data';

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockCoffeeApi extends Mock implements CoffeeApi {}

void main() {
  group('coffeeRepository', () {
    late CoffeeApi coffeeApi;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeApi = _MockCoffeeApi();
      coffeeRepository = CoffeeRepository(coffeeApi: coffeeApi);
    });

    group('constructor', () {
      test('can be instantiated without injected api', () {
        expect(CoffeeRepository(), isNotNull);
      });
      test('can be instantiated with injected api', () {
        expect(CoffeeRepository(coffeeApi: coffeeApi), isNotNull);
      });
    });

    group('getCoffeePicture', () {
      test('coffeeApi.getCoffeeImgBytes is called once', () async {
        when(() => coffeeApi.getCoffeeImgBytes()).thenAnswer(
          (_) async => Uint8List.fromList([1, 2, 3]),
        );
        await coffeeRepository.getCoffeePicture();
        verify(() => coffeeApi.getCoffeeImgBytes()).called(1);
      });

      test('returns CoffeePicture', () async {
        when(() => coffeeApi.getCoffeeImgBytes()).thenAnswer(
          (_) async => Uint8List.fromList([1, 2, 3]),
        );
        final result = await coffeeRepository.getCoffeePicture();
        expect(result, isA<CoffeePicture>());
      });
    });
  });
}
