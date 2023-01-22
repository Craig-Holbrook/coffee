import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:coffee_storage_api/coffee_storage_api.dart';
import 'package:path/path.dart' as p;

/// local storage api that implements coffeestorageapi
class CoffeeLocalStorageApi implements CoffeeStorageApi {
  /// constructor
  const CoffeeLocalStorageApi(this._directory);

  final Directory _directory;

  @override
  File getImage(String id) {
    final file = File(p.join(_directory.path, id));
    if (!file.existsSync()) throw CoffeeImageNotFoundException();
    return file;
  }

  @override
  Future<void> removeImage(String id) async {
    final file = File(p.join(_directory.path, id));
    await file.delete();
  }

  @override
  Future<void> saveImage(String id, Uint8List bytes) async {
    final file = File(p.join(_directory.path, id));
    await file.writeAsBytes(bytes);
  }
}
