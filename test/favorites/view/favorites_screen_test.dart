import 'package:bloc_test/bloc_test.dart';
import 'package:coffee/favorites/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../helpers/helpers.dart';

class _MockFavoritesCubit extends Mock implements FavoritesCubit {}

void main() {
  group('FavoritesScreen', () {
    late FavoritesCubit favoritesCubit;

    setUp(() {
      favoritesCubit = _MockFavoritesCubit();
      whenListen(
        favoritesCubit,
        Stream.fromIterable(<FavoritesState>[]),
        initialState: const FavoritesState(),
      );
    });
    testWidgets(
      'renders NoFavoritesFeedback',
      (tester) async {
        await tester.pumpApp(
          widget: const FavoritesScreen(),
          favoritesCubit: favoritesCubit,
        );
        expect(find.byType(NoFavoritesFeedback), findsOneWidget);
      },
    );

    testWidgets(
      'renders Listview containing images',
      (tester) async {
        when(() => favoritesCubit.state)
            .thenReturn(const FavoritesState(idsForFavorites: ['id1', 'id2']));
        await tester.pumpApp(
          widget: const FavoritesScreen(),
          favoritesCubit: favoritesCubit,
        );
        expect(find.byType(ListView), findsOneWidget);
      },
    );

    testWidgets(
      'renders error if cubit returns null file',
      (tester) async {
        when(() => favoritesCubit.state).thenReturn(
          const FavoritesState(idsForFavorites: ['id1']),
        );
        when(() => favoritesCubit.getImgFromStorage('id1')).thenReturn(null);
        await tester.pumpApp(
          widget: const FavoritesScreen(),
          favoritesCubit: favoritesCubit,
        );
        expect(find.byType(ErrorLoadingImageFeedback), findsOneWidget);
      },
    );
  });
}
