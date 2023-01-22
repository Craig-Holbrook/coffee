import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/cubit/favorites_cubit.dart';
import 'package:coffee/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final favorites = context.select(
      (FavoritesCubit cubit) => cubit.state.idsForFavorites,
    );
    return favorites.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: Text(l10n.noFavoritesFeedback)),
            ],
          )
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final id = favorites[index];
              return CoffeeImageContainer(
                coffeeImage: Image.file(
                  context.read<FavoritesCubit>().getImgFromStorage(id),
                ),
                remove: true,
                index: index,
              );
            },
          );
  }
}


    // final width = MediaQuery.of(context).size.width;
 // FutureBuilder(
              //   future: context.read<FavoritesCubit>().getImgFromStorage(id),
              //   builder: (context, snapshot) {
              //     return snapshot.connectionState == ConnectionState.done
              //         ? CoffeeImageContainer(
              //             coffeeImage: Image.file(snapshot.data!),
              //             remove: true,
              //             index: index,
              //           )
              //         : SizedBox(
              //             width: width,
              //             height: width + 55,
              //             child: const Center(
              //               child: CircularProgressIndicator(),
              //             ),
              //           );
              //   },
              // );

