import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffee/favorites/cubit/favorites_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffee_storage_repository/coffee_storage_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

// ignore: lines_longer_than_80_chars
class _MockCoffeeStorageRepository extends Mock implements CoffeeStorageRepository {}

class _MockStorage extends Mock implements Storage {}

void main() {
  group('FavoritesCubit', () {
    late CoffeeStorageRepository coffeeStorageRepository;
    late Storage storage;

    setUp(() {
      coffeeStorageRepository = _MockCoffeeStorageRepository();
      storage = _MockStorage();
      when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
      HydratedBloc.storage = storage;
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(FavoritesCubit(coffeeStorageRepository), isNotNull);
      });

      test('initial state is correct', () {
        expect(
          FavoritesCubit(coffeeStorageRepository).state,
          const FavoritesState(),
        );
      });
    });

    group('addFavorite', () {
      late CoffeePicture coffeePicture;

      setUp(() {
        coffeePicture = CoffeePicture(Uint8List.fromList([1, 2, 3]));
      });

      blocTest<FavoritesCubit, FavoritesState>(
        'coffeeStorageRepository.saveImg is called once',
        setUp: () {
          when(
            () => coffeeStorageRepository.saveImage(any(), coffeePicture.bytes),
          ).thenAnswer((_) => Future.value());
        },
        build: () => FavoritesCubit(coffeeStorageRepository),
        act: (cubit) => cubit.addFavorite(coffeePicture),
        verify: (_) => verify(
          () => coffeeStorageRepository.saveImage(
            any(),
            Uint8List.fromList([1, 2, 3]),
          ),
        ).called(1),
      );

      group('resetCurrentFavorited', () {
        blocTest<FavoritesCubit, FavoritesState>(
          'tests currentFavorited is reset to false',
          build: () => FavoritesCubit(coffeeStorageRepository),
          seed: () => const FavoritesState(
            idsForFavorites: ['123'],
            currentIsFavorited: true,
          ),
          act: (cubit) => cubit.resetCurrentFavorited(),
          expect: () => <FavoritesState>[
            const FavoritesState(idsForFavorites: ['123']),
          ],
        );
      });

      test('emits state with new id', () {
        when(
          () => coffeeStorageRepository.saveImage(any(), coffeePicture.bytes),
        ).thenAnswer((_) => Future.value());

        final cubit = FavoritesCubit(coffeeStorageRepository)
          ..addFavorite(
            coffeePicture,
          );
        expect(cubit.state.idsForFavorites.length, 1);
      });
    });

    group('removeFavorite', () {
      blocTest<FavoritesCubit, FavoritesState>(
        'coffeeStorageRepository.removeImage is called once',
        setUp: () {
          when(() => coffeeStorageRepository.removeImage('123')).thenAnswer(
            (_) => Future.value(),
          );
        },
        build: () => FavoritesCubit(coffeeStorageRepository),
        seed: () => const FavoritesState(idsForFavorites: ['123']),
        act: (cubit) => cubit.removeFavorite(0),
        verify: (_) => verify(
          () => coffeeStorageRepository.removeImage('123'),
        ).called(1),
      );
      blocTest<FavoritesCubit, FavoritesState>(
        'new state is emitted without the removed id',
        setUp: () {
          when(() => coffeeStorageRepository.removeImage('123')).thenAnswer(
            (_) => Future.value(),
          );
        },
        build: () => FavoritesCubit(coffeeStorageRepository),
        seed: () => const FavoritesState(
          idsForFavorites: ['123', '324'],
          currentIsFavorited: true,
        ),
        act: (cubit) => cubit.removeFavorite(0),
        expect: () => <FavoritesState>[
          const FavoritesState(
            idsForFavorites: ['324'],
            currentIsFavorited: true,
          ),
        ],
      );

      blocTest<FavoritesCubit, FavoritesState>(
        '''
new state is emitted without the removed id but it was the
last image so user should be able to go back and re favorite it''',
        setUp: () {
          when(() => coffeeStorageRepository.removeImage('324')).thenAnswer(
            (_) => Future.value(),
          );
        },
        build: () => FavoritesCubit(coffeeStorageRepository),
        seed: () => const FavoritesState(
          idsForFavorites: ['123', '324'],
          currentIsFavorited: true,
        ),
        act: (cubit) => cubit.removeFavorite(1),
        expect: () => <FavoritesState>[
          const FavoritesState(
            idsForFavorites: ['123'],
          ),
        ],
      );
    });

    group('getImgFromStorage', () {
      blocTest<FavoritesCubit, FavoritesState>(
        'coffeeStorageRepository.getImage is called once',
        setUp: () {
          when(() => coffeeStorageRepository.getImage('123')).thenReturn(
            File(''),
          );
        },
        build: () => FavoritesCubit(coffeeStorageRepository),
        act: (cubit) => cubit.getImgFromStorage('123'),
        verify: (_) => verify(
          () => coffeeStorageRepository.getImage('123'),
        ).called(1),
      );
    });

    group('fromJson/toJson', () {
      test('fromJson converts correctly', () {
        final cubit = FavoritesCubit(coffeeStorageRepository);
        expect(
          cubit.fromJson({
            'idsForFavorites': ['123']
          }),
          const FavoritesState(idsForFavorites: ['123']),
        );
      });
      test('toJson converts correctly', () {
        final cubit = FavoritesCubit(coffeeStorageRepository);
        expect(
          cubit.toJson(const FavoritesState(idsForFavorites: ['123'])),
          {
            'idsForFavorites': ['123']
          },
        );
      });
    });
  });
}
