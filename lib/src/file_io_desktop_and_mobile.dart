import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<void> saveFontToDeviceFileSystem(String path, List<int> bytes) async {
  final file = File('$path');
  await file.writeAsBytes(bytes);
}

// Font file must be located in ApplicationSupportDirectory
Future<ByteData?> loadFontFromDeviceFileSystem(String path) async {
  try {
    final loaclPath = await _localPath;
    final file = File('$_localPath/$path');
    final fileExists = file.existsSync();
    if (fileExists) {
      List<int> contents = await file.readAsBytes();
      if (contents.isNotEmpty) {
        return ByteData.view(Uint8List.fromList(contents).buffer);
      }
    }
  } catch (e) {
    return null;
  }

  return null;
}

Future<String> get _localPath async {
  final directory = await getApplicationSupportDirectory();
  return directory.path;
}
