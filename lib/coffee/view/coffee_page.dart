import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/view/view.dart';
import 'package:coffee/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({super.key});

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? l10n.generateNavTitle : l10n.favoritesNavTitle,
        ),
        titleTextStyle: Theme.of(context).textTheme.headline5,
      ),
      body: const [
        HomeScreen(),
        FavoritesScreen(),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: l10n.generateBottomNav,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite),
            label: l10n.favoritesBottomNav,
          )
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
