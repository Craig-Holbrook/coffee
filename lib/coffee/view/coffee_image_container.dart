import 'package:coffee/favorites/favorites.dart';
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
          if (remove)
            DeleteButton(index: index!)
          else
            BlocBuilder<FavoritesCubit, FavoritesState>(
              buildWhen: (previous, current) =>
                  previous.currentIsFavorited != current.currentIsFavorited,
              builder: (context, state) {
                if (state.currentIsFavorited) {
                  return const FavoritesLabel();
                }
                return FavoriteButton(coffeePicture: coffeePicture!);
              },
            )
        ],
      ),
    );
  }
}

class FavoritesLabel extends StatelessWidget {
  const FavoritesLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        l10n.favorited,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.coffeePicture,
  });

  final CoffeePicture coffeePicture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: IconButton(
        splashRadius: 24,
        constraints: const BoxConstraints(maxHeight: 36),
        icon: const Icon(
          Icons.favorite_border_outlined,
        ),
        onPressed: () {
          context.read<FavoritesCubit>().addFavorite(coffeePicture);
        },
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: IconButton(
        splashRadius: 24,
        constraints: const BoxConstraints(maxHeight: 36),
        icon: const Icon(
          Icons.delete_outline,
        ),
        onPressed: () {
          context.read<FavoritesCubit>().removeFavorite(index);
        },
      ),
    );
  }
}
