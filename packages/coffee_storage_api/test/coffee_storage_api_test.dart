import 'package:coffee_storage_api/coffee_storage_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockCoffeeStorageApi extends Mock implements CoffeeStorageApi {}

void main() {
  group('coffee storage api abstract class', () {
    late CoffeeStorageApi coffeeStorageApi;

    setUp(() {
      coffeeStorageApi = _MockCoffeeStorageApi();
    });
    test('can be implemented', () {
      expect(coffeeStorageApi, isNotNull);
      expect(coffeeStorageApi, isA<CoffeeStorageApi>());
    });

    test('saveImage', () {});
    test('removeImage', () {});
    test('getImage', () {});
  });
}
