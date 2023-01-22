import 'dart:typed_data';

/// A model representing coffee image containing Uint8List bytes
class CoffeePicture {
  /// CoffeePicture constructor
  CoffeePicture(this.bytes);

  /// bytes for [CoffeePicture]
  final Uint8List bytes;
}
