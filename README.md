# Very Good Coffee

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]

## Getting Started

- Build with very_good_cli
- Can be launched with: flutter run --flavor development  
  or through IDE (vscode run shortcut, etc.)

## Architecture

Taking inspiration from Very Good Ventures's open source material, the app uses bloc state management and
the code is layered in presentation, domain, and data layers.

- Coffee feature  
  UI <--> CoffeeCubit <--> CoffeeRepository <--> CoffeeApi

- Favorites feature  
  UI <--> FavoritesCubit <--> CoffeeStorageRepository <--> CoffeeStorageApi <--> CoffeeLocalStorageApi

The CoffeeLocalStorageApi implements an abstract class exposed by the CoffeeStorageApi.
This allows us to easily implement alternative storage solutions in the future.

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
