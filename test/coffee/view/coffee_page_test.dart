import 'package:bloc_test/bloc_test.dart';
import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../helpers/helpers.dart';
import '../../helpers/hydrated_bloc.dart';

class _MockCoffeeCubit extends Mock implements CoffeeCubit {}

class _MockFavoritesCubit extends Mock implements FavoritesCubit {}

void main() {
  initHydratedStorage();
  group('CoffeePage', () {
    late CoffeeCubit coffeeCubit;
    late FavoritesCubit favoritesCubit;

    setUp(() {
      coffeeCubit = _MockCoffeeCubit();
      favoritesCubit = _MockFavoritesCubit();

      whenListen(
        coffeeCubit,
        Stream.fromIterable(<CoffeeState>[]),
        initialState: const CoffeeState(status: CoffeeRequestStatus.initial),
      );

      whenListen(
        favoritesCubit,
        Stream.fromIterable(<FavoritesState>[]),
        initialState: const FavoritesState(),
      );
    });
    testWidgets('renders HomeScreen', (tester) async {
      await tester.pumpApp(
        widget: const CoffeePage(),
        coffeeCubit: coffeeCubit,
      );
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('renders FavoritesScreen', (tester) async {
      await tester.pumpApp(
        widget: const CoffeePage(),
        coffeeCubit: coffeeCubit,
        favoritesCubit: favoritesCubit,
      );
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();
      expect(find.byType(FavoritesScreen), findsOneWidget);
    });
  });
}
