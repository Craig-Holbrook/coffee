import 'package:coffee/coffee/coffee.dart';
import 'package:coffee/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateCoffee extends StatelessWidget {
  const GenerateCoffee({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: BlocBuilder<CoffeeCubit, CoffeeState>(
            builder: (ctx, state) {
              if (state.status == CoffeeRequestStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.status == CoffeeRequestStatus.initial ||
                  state.status == CoffeeRequestStatus.successful) {
                final success = state.status == CoffeeRequestStatus.successful;
                return Column(
                  children: <Widget>[
                    if (success)
                      CoffeeImageContainer(
                        coffeeImage: Image.memory(state.coffeePicture!.bytes),
                        coffeePicture: state.coffeePicture,
                      )
                    else
                      Text(
                        l10n.initialGenerateString,
                        style: textTheme.titleLarge,
                      ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () => ctx.read<CoffeeCubit>().getCoffee(),
                        child: Text(l10n.generateButtonTitle),
                      ),
                    )
                  ],
                );
              } else {
                return Text(l10n.generateErrorMsgFeedback);
              }
            },
          ),
        ),
      ],
    );
  }
}
