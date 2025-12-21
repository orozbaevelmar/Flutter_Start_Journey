import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

extension DirectoryExtended on Directory {
  String appendingPath(String path) =>
      '${this.path}${Platform.pathSeparator}$path';
}

extension FileExtended on File {
  Future<File> renameLastPathComponent(String name) => rename(
    path.replaceRange(
      parent.path.length + Platform.pathSeparator.length,
      null,
      name,
    ),
  );

  Map<String, dynamic> readAsJsonSync() {
    final content = readAsStringSync();
    return json.decode(content);
  }
}

extension FileSystemEntityExtended on FileSystemEntity {
  String get lastPathComponent => path.substring(
      parent.path.length + Platform.pathSeparator.length, path.length);
}

extension FileSavingListExtended on List<String> {
  Future<List<String>> saveInAppDocumentsDirectory() async {
    final newFiles = <String>[];
    for (final filePath in this) {
      newFiles.add(await _prepareFileToStorage(filePath));
    }
    return newFiles;
  }

  Future<String> _prepareFileToStorage(String filePath) async =>
      filePath.copyFileToStorage(await filePath.makeAppDocumentsPath());
}

extension FileSavingExtended on String {
  Future<String> makeAppDocumentsPath() async {
    final path = join(
      (await getApplicationDocumentsDirectory()).path,
      basename(this),
    );
    return path;
  }

  Future<String> copyFileToStorage(String newPath) async {
    final file = await asFile().copy(newPath);
    return file.path;
  }

  File asFile() => File(this);
}
