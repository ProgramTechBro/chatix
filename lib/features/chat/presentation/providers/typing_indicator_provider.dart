import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/usecases/watch_typing_indicator_usecase.dart';

part 'typing_indicator_provider.g.dart';

@riverpod
class TypingIndicator extends _$TypingIndicator {
  Timer? _hideTimer;

  @override
  bool build(String conversationId) {
    final subscription = getIt<WatchTypingIndicatorUseCase>()
        .call(conversationId)
        .listen((_) => _onTypingEvent());

    ref.onDispose(() {
      _hideTimer?.cancel();
      subscription.cancel();
    });

    return false;
  }

  void _onTypingEvent() {
    state = true;
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () => state = false);
  }
}
