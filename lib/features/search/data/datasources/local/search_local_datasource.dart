import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/searched_user_model.dart';

abstract class SearchLocalDataSource {
  Future<List<SearchedUserModel>> getRecentSearches();
  Future<List<SearchedUserModel>> searchUsers(String query);
  Future<void> removeRecentSearch(String userId);
}

@LazySingleton(as: SearchLocalDataSource)
class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final List<SearchedUserModel> _users = [
    const SearchedUserModel(id: 'u10', name: 'Mohana Jerin', avatarUrl: AppNetworkImages.contactMohanaJerin),
    const SearchedUserModel(id: 'u2', name: 'Jonathan', avatarUrl: AppNetworkImages.contactJonathan),
    const SearchedUserModel(id: 'u3', name: 'Gebrel', avatarUrl: AppNetworkImages.contactGebrel),
    const SearchedUserModel(id: 'u4', name: 'Sultan', avatarUrl: AppNetworkImages.contactSultan),
    const SearchedUserModel(id: 'u5', name: 'Joshim', avatarUrl: AppNetworkImages.contactJoshim),
    const SearchedUserModel(id: 'u7', name: 'Pinky', avatarUrl: AppNetworkImages.contactPinky),
  ];

  @override
  Future<List<SearchedUserModel>> getRecentSearches() async => List.unmodifiable(_users);

  @override
  Future<List<SearchedUserModel>> searchUsers(String query) async {
    if (query.trim().isEmpty) return List.unmodifiable(_users);
    final lowerQuery = query.toLowerCase();
    return _users.where((user) => user.name.toLowerCase().contains(lowerQuery)).toList();
  }

  @override
  Future<void> removeRecentSearch(String userId) async {
    _users.removeWhere((user) => user.id == userId);
  }
}
