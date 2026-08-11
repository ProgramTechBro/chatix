import 'package:injectable/injectable.dart';

@lazySingleton
class ActiveConversationTracker {
  String? current;
}
