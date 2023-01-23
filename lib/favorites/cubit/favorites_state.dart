// ignore_for_file: lines_longer_than_80_chars

part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.idsForFavorites = const [],
    this.currentIsFavorited = false,
  });

  final List<String> idsForFavorites;
  final bool currentIsFavorited;

  @override
  List<Object> get props => [idsForFavorites, currentIsFavorited];

  @override
  String toString() =>
      'FavoritesState(idsForFavorites: $idsForFavorites, currentIsFavorited: $currentIsFavorited)';
}
