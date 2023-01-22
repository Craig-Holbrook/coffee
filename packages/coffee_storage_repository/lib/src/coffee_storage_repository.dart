import 'dart:io';
import 'dart:typed_data';

import 'package:coffee_storage_api/coffee_storage_api.dart';

/// repository that uses functions by abstract CoffeeStorageApi
class CoffeeStorageRepository {
  ///constructor
  const CoffeeStorageRepository(this._coffeeStorageApi);

  final CoffeeStorageApi _coffeeStorageApi;

  /// Saves image bytes to file in storage using a id to create unique storage path
  Future<void> saveImage(String id, Uint8List bytes) => _coffeeStorageApi.saveImage(id, bytes);

  /// Removes stored file by finding path with specified id
  Future<void> removeImage(String id) => _coffeeStorageApi.removeImage(id);

  /// Gets image file by finding the file at a path ../id
  File getImage(String id) => _coffeeStorageApi.getImage(id);
}
