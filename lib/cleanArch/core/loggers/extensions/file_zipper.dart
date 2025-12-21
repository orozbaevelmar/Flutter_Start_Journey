import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:start_journey/cleanArch/core/loggers/extensions/file_system_extension.dart';

class FileZipper {
  static Future<File> zip(List<File> files, String zipFilename) async {
    final tempDirectory = await getTemporaryDirectory();
    final zipFilePath = tempDirectory.appendingPath(
      zipFilename.endsWith('.zip') ? zipFilename : '$zipFilename.zip',
    );
    return compute(
      _zipFiles,
      _FilesToZip(files: files, zipFilePath: zipFilePath),
    );
  }
}

class _FilesToZip {
  const _FilesToZip({required this.files, required this.zipFilePath});

  final List<File> files;
  final String zipFilePath;
}

Future<File> _zipFiles(_FilesToZip filesToZip) async {
  final encoder = ZipFileEncoder()..create(filesToZip.zipFilePath);
  filesToZip.files.forEach(encoder.addFile);
  encoder.close();
  return File(filesToZip.zipFilePath);
}
