import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/cubit/favorites_cubit.dart';
import 'package:coffee/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    final favorites = context.select(
      (FavoritesCubit cubit) => cubit.state.idsForFavorites,
    );
    return favorites.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  l10n.noFavoritesFeedback,
                  style: textTheme.bodyLarge,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final id = favorites[index];
              final file = context.read<FavoritesCubit>().getImgFromStorage(id);
              return file != null
                  ? CoffeeImageContainer(
                      coffeeImage: Image.file(file),
                      remove: true,
                      index: index,
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Center(child: Text(l10n.errorLoadingImg)),
                    );
            },
          );
  }
}
