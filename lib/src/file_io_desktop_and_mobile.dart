import 'dart:io';
import 'dart:typed_data';

Future<void> saveFontToDeviceFileSystem(String path, List<int> bytes) async {
  final file = File('$path');
  await file.writeAsBytes(bytes);
}

/// path must point to existing .ttf font
Future<ByteData?> loadFontFromDeviceFileSystem(String path) async {
  try {
    final file = File(path);
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
