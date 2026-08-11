import 'dart:developer' as developer;

import 'package:injectable/injectable.dart';

@lazySingleton
class LoggerService {
  void logError(Object error, [StackTrace? stackTrace]) {
    developer.log(
      error.toString(),
      name: 'chatix',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void logInfo(String message) {
    developer.log(message, name: 'chatix');
  }
}
