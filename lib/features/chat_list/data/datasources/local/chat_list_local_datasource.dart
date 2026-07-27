import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/chat_summary_model.dart';

abstract class ChatListLocalDataSource {
  Future<List<ChatSummaryModel>> getChatList();
}

@LazySingleton(as: ChatListLocalDataSource)
class ChatListLocalDataSourceImpl implements ChatListLocalDataSource {
  @override
  Future<List<ChatSummaryModel>> getChatList() async {
    const lastMessage = 'Hi there! I was thinking maybe we should...';
    return const [
      ChatSummaryModel(
        id: 'c1',
        userId: 'u_johanna',
        name: 'Johanna West',
        avatarUrl: AppNetworkImages.contactJohannaWest,
        lastMessage: lastMessage,
        time: '4:37',
      ),
      ChatSummaryModel(
        id: 'c2',
        userId: 'u2',
        name: 'Jonathan',
        avatarUrl: AppNetworkImages.contactJonathan,
        lastMessage: lastMessage,
        time: '4:37',
      ),
      ChatSummaryModel(
        id: 'c3',
        userId: 'u3',
        name: 'Gebrel',
        avatarUrl: AppNetworkImages.contactGebrel,
        lastMessage: lastMessage,
        time: '4:37',
      ),
      ChatSummaryModel(
        id: 'c4',
        userId: 'u4',
        name: 'Sultan',
        avatarUrl: AppNetworkImages.contactSultan,
        lastMessage: lastMessage,
        time: '4:37',
      ),
      ChatSummaryModel(
        id: 'c5',
        userId: 'u5',
        name: 'Joshim',
        avatarUrl: AppNetworkImages.contactJoshim,
        lastMessage: lastMessage,
        time: '4:37',
      ),
      ChatSummaryModel(
        id: 'c6',
        userId: 'u6',
        name: 'Albert',
        avatarUrl: AppNetworkImages.contactAlbert,
        lastMessage: lastMessage,
        time: '4:37',
      ),
      ChatSummaryModel(
        id: 'c7',
        userId: 'u7',
        name: 'Pinky',
        avatarUrl: AppNetworkImages.contactPinky,
        lastMessage: lastMessage,
        time: '4:37',
      ),
      ChatSummaryModel(
        id: 'c8',
        userId: 'u10',
        name: 'Mohana Jerin',
        avatarUrl: AppNetworkImages.contactMohanaJerin,
        lastMessage: lastMessage,
        time: '4:37',
      ),
    ];
  }
}
