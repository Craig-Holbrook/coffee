import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/cubit/favorites_cubit.dart';
import 'package:coffee/l10n/l10n.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeImageContainer extends StatelessWidget {
  const CoffeeImageContainer({
    super.key,
    required this.coffeeImage,
    this.coffeePicture,
    this.index,
    this.remove = false,
  });

  final Image coffeeImage;
  final CoffeePicture? coffeePicture;
  final int? index;
  final bool remove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              color: Colors.black,
              width: double.infinity,
              child: coffeeImage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, top: 10),
            child: IconButton(
              splashRadius: 24,
              constraints: const BoxConstraints(maxHeight: 36),
              icon: Icon(
                remove ? Icons.delete_outline : Icons.favorite_border_outlined,
              ),
              onPressed: () {
                if (remove) {
                  context.read<FavoritesCubit>().removeFavorite(index!);
                } else {
                  context.read<FavoritesCubit>().addFavorite(coffeePicture!);
                  context.read<CoffeeCubit>().reset();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.addedToFavoritesSnackBar),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
