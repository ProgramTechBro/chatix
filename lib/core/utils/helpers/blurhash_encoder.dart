import 'dart:io';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

Future<String?> encodeBlurHash(File file) => compute(_encode, file.path);

String? _encode(String path) {
  try {
    final decoded = img.decodeImage(File(path).readAsBytesSync());
    if (decoded == null) return null;
    final resized = img.copyResize(decoded, width: 32);
    return BlurHash.encode(resized, numCompX: 4, numCompY: 3).hash;
  } catch (_) {
    return null;
  }
}
