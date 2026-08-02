import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/notification_model.dart';

abstract class NotificationsLocalDataSource {
  Future<List<NotificationModel>> getNotifications();
}

@LazySingleton(as: NotificationsLocalDataSource)
class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    return const [
      NotificationModel(
        id: 'n1',
        avatarUrl: AppNetworkImages.contactLarryKovet,
        title: 'Larry kovet',
        message:
            "Shared your post with ''mr manny, johary bell, sabit musa and 3 others...",
        time: '12:34',
      ),
      NotificationModel(
        id: 'n2',
        avatarUrl: AppNetworkImages.contactMarianaJerin,
        title: 'Mariana jerin',
        message: 'Just liked your post',
        time: '3:11',
      ),
      NotificationModel(
        id: 'n3',
        avatarUrl: AppNetworkImages.contactDKarry,
        title: 'D karry',
        message: 'Started following you from Astronomy art... post',
        time: '3:44',
      ),
      NotificationModel(
        id: 'n4',
        avatarUrl: AppNetworkImages.contactLarryKovet,
        title: 'Larry kovet',
        message:
            "Shared your post with ''mr manny, johary bell, sabit musa and 7 others...",
        time: '12:34',
      ),
      NotificationModel(
        id: 'n5',
        avatarUrl: AppNetworkImages.contactMarianaJerin,
        title: 'You have achieved new gift',
        message: 'You have received a new gift from Kolen Vamos!',
        time: '1d',
      ),
      NotificationModel(
        id: 'n6',
        avatarUrl: AppNetworkImages.contactWahidZaman,
        title: 'Wahid Zaman',
        message:
            "Commented on your post '' Hey your are just looking so nice and I have a crush on you''...",
        time: '4d',
      ),
      NotificationModel(
        id: 'n7',
        avatarUrl: AppNetworkImages.contactDKarry,
        title: 'You have achieved new gift',
        message:
            "Shared your post with ''mr manny, johary bell, sabit musa and 3 others...",
        time: '12:34',
      ),
    ];
  }
}
