bool isNetworkError(Object error) {
  final message = error.toString().toLowerCase();
  return message.contains('socketexception') ||
      message.contains('failed host lookup') ||
      message.contains('connection failed') ||
      message.contains('network is unreachable') ||
      message.contains('clientexception');
}
