import 'dart:io';
import 'dart:typed_data';

/// The interface for an API that saves and removes images to storage
abstract class CoffeeStorageApi {
  /// constructor
  const CoffeeStorageApi();

  /// saves image at path ending with id
  Future<void> saveImage(String id, Uint8List bytes);

  /// removes image at path ending with id
  Future<void> removeImage(String id);

  /// get image file at path ending with id
  ///
  /// if no file exists, a [CoffeeImageNotFoundException] is thrown
  File getImage(String id);
}

/// Error thrown when image is not found at specified path
class CoffeeImageNotFoundException implements Exception {}
