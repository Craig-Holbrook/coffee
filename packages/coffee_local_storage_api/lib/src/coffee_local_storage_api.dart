import 'dart:io';
import 'dart:typed_data';

import 'package:coffee_storage_api/coffee_storage_api.dart';
import 'package:file/file.dart' hide Directory;
import 'package:file/local.dart';
import 'package:path/path.dart' as p;

/// local storage api that implements coffeestorageapi
class CoffeeLocalStorageApi implements CoffeeStorageApi {
  /// constructor
  CoffeeLocalStorageApi({
    required Directory directory,
    FileSystem? fileSystem,
  })  : _directory = directory,
        _fileSystem = fileSystem ?? const LocalFileSystem();

  final Directory _directory;
  final FileSystem _fileSystem;

  @override
  File getImage(String id) {
    final file = _fileSystem.file(p.join(_directory.path, id));
    if (!file.existsSync()) throw CoffeeImageNotFoundException();
    return file;
  }

  @override
  Future<void> removeImage(String id) async {
    final file = _fileSystem.file(p.join(_directory.path, id));
    await file.delete();
  }

  @override
  Future<void> saveImage(String id, Uint8List bytes) async {
    final file = _fileSystem.file(p.join(_directory.path, id));
    await file.writeAsBytes(bytes);
  }
}
