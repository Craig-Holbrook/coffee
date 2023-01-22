import 'dart:io';
import 'dart:typed_data';

import 'package:coffee_storage_api/coffee_storage_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockCoffeeStorageApi extends Mock implements CoffeeStorageApi {}

void main() {
  group('coffee storage api abstract class', () {
    late CoffeeStorageApi coffeeStorageApi;
    late String id;
    late Uint8List bytes;

    setUp(() {
      coffeeStorageApi = _MockCoffeeStorageApi();
      id = '123';
      bytes = Uint8List.fromList([1, 2, 3]);
    });
    test('can be implemented', () {
      expect(coffeeStorageApi, isNotNull);
      expect(coffeeStorageApi, isA<CoffeeStorageApi>());
    });

    test('saveImage', () {
      when(() => coffeeStorageApi.saveImage(id, bytes)).thenAnswer((_) => Future.value());
      expect(coffeeStorageApi.saveImage(id, bytes), completes);
    });
    test('removeImage', () {
      when(() => coffeeStorageApi.removeImage(id)).thenAnswer((_) => Future.value());
      expect(coffeeStorageApi.removeImage(id), completes);
    });
    test('getImage', () {
      when(() => coffeeStorageApi.getImage(id)).thenReturn(File(''));
      expect(coffeeStorageApi.getImage(id), isA<File>());
    });
  });

  group('CoffeeImageNotFoundException', () {
    test('can be instantiated', () {
      expect(CoffeeImageNotFoundException(), isNotNull);
      expect(CoffeeImageNotFoundException(), isA<Exception>());
    });
  });
}
