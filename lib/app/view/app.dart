import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/cubit/favorites_cubit.dart';
import 'package:coffee/l10n/l10n.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffee_storage_repository/coffee_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required CoffeeRepository coffeeRepository,
    required CoffeeStorageRepository coffeeStorageRepository,
  })  : _coffeeRepository = coffeeRepository,
        _coffeeStorageRepository = coffeeStorageRepository;

  final CoffeeRepository _coffeeRepository;
  final CoffeeStorageRepository _coffeeStorageRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CoffeeCubit(_coffeeRepository),
        ),
        BlocProvider(
          create: (_) => FavoritesCubit(_coffeeStorageRepository),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            color: Colors.white,
            elevation: 1,
          ),
          primarySwatch: Colors.brown,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const CoffeePage(),
      ),
    );
  }
}
