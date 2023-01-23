import 'dart:typed_data';

import 'package:coffee_local_storage_api/coffee_local_storage_api.dart';
import 'package:coffee_storage_api/coffee_storage_api.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockDirectory extends Mock implements Directory {}

class _MockFileSystem extends Mock implements FileSystem {}

class _MockFile extends Mock implements File {}

void main() {
  group('CoffeeLocalStorageApi', () {
    late Directory dir;
    late CoffeeLocalStorageApi coffeeLocalStorageApi;
    late File file;
    late FileSystem fileSystem;
    late String id;
    late String path;
    late Uint8List bytes;

    setUp(() {
      dir = _MockDirectory();
      fileSystem = _MockFileSystem();
      coffeeLocalStorageApi = CoffeeLocalStorageApi(
        directory: dir,
        fileSystem: fileSystem,
      );
      file = _MockFile();
      id = '123';
      path = 'path';
      bytes = Uint8List.fromList([1, 2, 3]);
    });

    test('constructor', () {
      expect(
        CoffeeLocalStorageApi(directory: dir, fileSystem: fileSystem),
        isNotNull,
      );
    });

    group('getImage', () {
      test('getImage returns a file', () {
        when(() => dir.path).thenReturn(path);
        when(() => fileSystem.file(any<String>())).thenReturn(file);
        when(() => file.existsSync()).thenReturn(true);
        expect(coffeeLocalStorageApi.getImage(id), isA<File>());
      });

      test('''
getImage throws CoffeeImageNotFoundException
when existsSync comes back false
''', () {
        when(() => dir.path).thenReturn(path);
        when(() => fileSystem.file(any<String>())).thenReturn(file);
        when(() => file.existsSync()).thenReturn(false);
        expect(
          () => coffeeLocalStorageApi.getImage(id),
          throwsA(isA<CoffeeImageNotFoundException>()),
        );
      });
    });
    test('removeImage file.delete is called once', () {
      when(() => dir.path).thenReturn(path);
      when(() => fileSystem.file(any<String>())).thenReturn(file);
      when(() => file.delete()).thenAnswer((_) async => file);
      coffeeLocalStorageApi.removeImage(id);
      verify(() => file.delete()).called(1);
    });
    test('saveImage file.writeAsBytes is called once', () {
      when(() => dir.path).thenReturn(path);
      when(() => fileSystem.file(any<String>())).thenReturn(file);
      when(() => file.writeAsBytes(bytes)).thenAnswer((_) async => file);
      coffeeLocalStorageApi.saveImage(id, bytes);
      verify(() => file.writeAsBytes(bytes)).called(1);
    });

    group('memory file system tests', () {
      late MemoryFileSystem memoryFileSystem;

      setUp(() {
        memoryFileSystem = MemoryFileSystem();
      });

      test('test files get saved using memory filesystem', () {
        final testFile = memoryFileSystem.file('dir/filename')..createSync(recursive: true);
        expect(testFile.existsSync(), true);
      });
    });
  });
}
