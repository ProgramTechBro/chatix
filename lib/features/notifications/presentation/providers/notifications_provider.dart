import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/get_notifications_usecase.dart';

part 'notifications_provider.g.dart';

@riverpod
Future<List<NotificationEntity>> notifications(NotificationsRef ref) async {
  final result = await getIt<GetNotificationsUseCase>().call();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (notifications) => notifications,
  );
}
