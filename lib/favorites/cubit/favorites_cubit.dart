import 'dart:developer';
import 'dart:io';

import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffee_storage_repository/coffee_storage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'favorites_state.dart';

String idGenerator() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

class FavoritesCubit extends Cubit<FavoritesState> with HydratedMixin {
  FavoritesCubit(this._coffeeStorageRepository) : super(const FavoritesState());

  final CoffeeStorageRepository _coffeeStorageRepository;

  Future<void> addFavorite(CoffeePicture coffeePicture) async {
    final id = idGenerator();
    emit(
      FavoritesState(
        idsForFavorites: [...state.idsForFavorites, id],
      ),
    );
    await _coffeeStorageRepository.saveImage(id, coffeePicture.bytes);
  }

  void removeFavorite(int index) {
    final favs = [...state.idsForFavorites];
    final removedId = favs.removeAt(index);
    emit(FavoritesState(idsForFavorites: favs));
    _coffeeStorageRepository.removeImage(removedId);
  }

  File? getImgFromStorage(String id) {
    try {
      final file = _coffeeStorageRepository.getImage(id);
      return file;
    } catch (e) {
      log('Error getting file from storage $e');
    }
    return null;
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    final list = json['idsForFavorites'] as List;

    return FavoritesState(
      idsForFavorites: list.map((e) => e as String).toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    return {'idsForFavorites': state.idsForFavorites};
  }
}
