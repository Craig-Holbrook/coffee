import 'dart:io';
import 'dart:typed_data';

import 'package:coffee_storage_api/coffee_storage_api.dart';
import 'package:coffee_storage_repository/coffee_storage_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockCoffeeStorageApi extends Mock implements CoffeeStorageApi {}

void main() {
  group('CoffeeStorageRepository', () {
    late CoffeeStorageRepository coffeeStorageRepository;
    late CoffeeStorageApi coffeeStorageApi;
    late String id;
    late Uint8List bytes;

    setUp(() {
      coffeeStorageApi = _MockCoffeeStorageApi();
      coffeeStorageRepository = CoffeeStorageRepository(coffeeStorageApi);
      id = '123';
      bytes = Uint8List.fromList([1, 2, 3]);
    });

    test('constructor', () {
      expect(CoffeeStorageRepository(coffeeStorageApi), isNotNull);
    });

    test('saveImage calls coffeeStorageApi.saveImage once and completes', () {
      when(() => coffeeStorageApi.saveImage(id, bytes)).thenAnswer((_) => Future.value());
      expect(coffeeStorageRepository.saveImage(id, bytes), completes);
      verify(() => coffeeStorageApi.saveImage(id, bytes)).called(1);
    });
    test('removeImage calls coffeeStorageApi.removeImage once and completes', () {
      when(() => coffeeStorageApi.removeImage(id)).thenAnswer((_) => Future.value());
      expect(coffeeStorageRepository.removeImage(id), completes);
      verify(() => coffeeStorageApi.removeImage(id)).called(1);
    });
    test('getImage calls cofeeStorageApi.getImage once and returns a file', () {
      when(() => coffeeStorageApi.getImage(id)).thenAnswer((_) => File('path'));
      expect(coffeeStorageRepository.getImage(id), isA<File>());
      verify(() => coffeeStorageApi.getImage(id)).called(1);
    });
  });
}
