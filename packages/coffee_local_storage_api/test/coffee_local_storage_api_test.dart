import 'dart:io';

import 'package:coffee_local_storage_api/coffee_local_storage_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockDirectory extends Mock implements Directory {}

class _MockFile extends Mock implements File {}

void main() {
  group('CoffeeLocalStorageApi', () {
    late Directory dir;
    late CoffeeLocalStorageApi coffeeLocalStorageApi;
    late File file;
    late String id;

    setUp(() {
      dir = _MockDirectory();
      coffeeLocalStorageApi = CoffeeLocalStorageApi(dir);
      file = _MockFile();
      id = '123';
    });

    test('constructor', () {
      expect(CoffeeLocalStorageApi(dir), isNotNull);
    });

    test('getImage', () {
      when(() => file.existsSync()).thenReturn(true);
      expect(coffeeLocalStorageApi.getImage(id), isA<File>());
    });
    test('removeImage', () {});
    test('saveImage', () {});
  });
}
