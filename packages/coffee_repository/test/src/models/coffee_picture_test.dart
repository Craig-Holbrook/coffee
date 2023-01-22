import 'dart:typed_data';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:test/test.dart';

void main() {
  late CoffeePicture coffeePicture;

  group('CoffeePicture model tests', () {
    setUp(() {
      coffeePicture = CoffeePicture(Uint8List.fromList([1, 2, 3]));
    });
    test('can be instantiated', () {
      expect(coffeePicture, isNotNull);
    });
  });
}
