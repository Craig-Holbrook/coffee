import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/favorites.dart';
import 'package:coffee/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCoffeeCubit extends Mock implements CoffeeCubit {}

class _MockFavoritesCubit extends Mock implements FavoritesCubit {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required Widget widget,
    CoffeeCubit? coffeeCubit,
    FavoritesCubit? favoritesCubit,
  }) {
    return runAsync(() {
      return pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: coffeeCubit ?? _MockCoffeeCubit(),
            ),
            BlocProvider.value(
              value: favoritesCubit ?? _MockFavoritesCubit(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: widget,
          ),
        ),
      );
    });
  }
}
