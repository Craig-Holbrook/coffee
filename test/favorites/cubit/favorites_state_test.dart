import 'package:coffee/favorites/cubit/favorites_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('favorites state', () {
    test('can be instantiated', () {
      expect(
        const FavoritesState(),
        isNotNull,
      );
      expect(
        const FavoritesState(idsForFavorites: ['123']),
        isNotNull,
      );
    });

    test('supports value equality', () {
      expect(
        const FavoritesState(),
        const FavoritesState(),
      );
      expect(
        const FavoritesState(idsForFavorites: ['321']),
        const FavoritesState(idsForFavorites: ['321']),
      );
    });

    test('toString functionality', () {
      expect(
        const FavoritesState(idsForFavorites: ['456']).toString(),
        'FavoritesState(idsForFavorites: [456])',
      );
    });
  });
}
