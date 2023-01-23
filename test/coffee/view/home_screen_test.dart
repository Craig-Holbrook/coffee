import 'package:bloc_test/bloc_test.dart';
import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/favorites.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../helpers/helpers.dart';

class _MockCoffeeCubit extends Mock implements CoffeeCubit {}

class _MockFavoritesCubit extends Mock implements FavoritesCubit {}

void main() {
  group('HomeScreen', () {
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
    testWidgets(
      'renders CoffeeInitial before any actions',
      (tester) async {
        await tester.pumpApp(
          widget: const HomeScreen(),
          coffeeCubit: coffeeCubit,
        );
        expect(find.byType(CoffeeInitial), findsOneWidget);
      },
    );

    testWidgets(
      'renders CoffeeFailed if coffee request fails',
      (tester) async {
        when(() => coffeeCubit.state)
            .thenReturn(const CoffeeState(status: CoffeeRequestStatus.failed));
        await tester.pumpApp(
          widget: const HomeScreen(),
          coffeeCubit: coffeeCubit,
        );
        expect(find.byType(CoffeeFailed), findsOneWidget);
      },
    );
  });
}
