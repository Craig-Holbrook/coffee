part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.idsForFavorites = const []});

  final List<String> idsForFavorites;

  @override
  List<Object> get props => [idsForFavorites];

  @override
  String toString() => 'FavoritesState(idsForFavorites: $idsForFavorites)';
}
