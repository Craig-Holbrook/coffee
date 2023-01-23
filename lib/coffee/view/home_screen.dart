// ignore_for_file: lines_longer_than_80_chars

import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/favorites/favorites.dart';
import 'package:coffee/l10n/l10n.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: BlocBuilder<CoffeeCubit, CoffeeState>(
            builder: (_, state) {
              if (state.status == CoffeeRequestStatus.loading) {
                return const CircularProgressIndicator();
              } else {
                return Column(
                  children: <Widget>[
                    if (state.status == CoffeeRequestStatus.initial) const CoffeeInitial(),
                    if (state.status == CoffeeRequestStatus.successful)
                      CoffeeSuccess(coffeePicture: state.coffeePicture!),
                    if (state.status == CoffeeRequestStatus.failed) const CoffeeFailed(),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class CoffeeInitial extends StatelessWidget {
  const CoffeeInitial({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Text(
          l10n.initialGenerateTitle,
          style: textTheme.titleLarge,
        ),
        Text(
          l10n.initialGenerateSubtitle,
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        const LoadCoffeeButton(),
      ],
    );
  }
}

class CoffeeSuccess extends StatelessWidget {
  const CoffeeSuccess({
    super.key,
    required this.coffeePicture,
  });

  final CoffeePicture coffeePicture;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CoffeeImageContainer(
          coffeeImage: Image.memory(coffeePicture.bytes),
          coffeePicture: coffeePicture,
        ),
        const RefreshCoffeeButton(),
      ],
    );
  }
}

class CoffeeFailed extends StatelessWidget {
  const CoffeeFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Text(
          l10n.generateErrorMsgFeedback,
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        const LoadCoffeeButton(),
      ],
    );
  }
}

class RefreshCoffeeButton extends StatelessWidget {
  const RefreshCoffeeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.brown,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: const Icon(Icons.refresh),
        color: Colors.white,
        onPressed: () {
          context.read<FavoritesCubit>().resetCurrentFavorited();
          context.read<CoffeeCubit>().getCoffee();
        },
      ),
    );
  }
}

class LoadCoffeeButton extends StatelessWidget {
  const LoadCoffeeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          context.read<FavoritesCubit>().resetCurrentFavorited();
          context.read<CoffeeCubit>().getCoffee();
        },
        child: Text(l10n.generateButtonTitle),
      ),
    );
  }
}
