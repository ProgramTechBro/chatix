import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/connection_model.dart';

abstract class ConnectionsLocalDataSource {
  Future<List<ConnectionModel>> getFollowing(String userId);
  Future<List<ConnectionModel>> getFollowers(String userId);
}

@LazySingleton(as: ConnectionsLocalDataSource)
class ConnectionsLocalDataSourceImpl implements ConnectionsLocalDataSource {
  static const List<ConnectionModel> _connections = [
    ConnectionModel(
      id: 'c_mohana_jerin',
      name: 'Mohana Jerin',
      avatarUrl: AppNetworkImages.contactMohanaJerin,
    ),
    ConnectionModel(
      id: 'c_mohana',
      name: 'Mohana',
      avatarUrl: AppNetworkImages.contactMohana,
    ),
    ConnectionModel(
      id: 'c_joseph',
      name: 'Joseph',
      avatarUrl: AppNetworkImages.contactJoseph,
    ),
    ConnectionModel(
      id: 'c_memy_mur',
      name: 'Memy mur',
      avatarUrl: AppNetworkImages.contactMemyMur,
    ),
    ConnectionModel(
      id: 'c_mohana_ale',
      name: 'Mohana Ale',
      avatarUrl: AppNetworkImages.contactMohanaAle,
    ),
    ConnectionModel(
      id: 'c_sultan_khan',
      name: 'Sultan khan',
      avatarUrl: AppNetworkImages.contactSultan,
    ),
    ConnectionModel(
      id: 'c_akm_karim',
      name: 'AKM Karim',
      avatarUrl: AppNetworkImages.contactAkmKarim,
    ),
    ConnectionModel(
      id: 'c_johana_jerin',
      name: 'Johana Jerin',
      avatarUrl: AppNetworkImages.contactJohanaJerin,
    ),
  ];

  @override
  Future<List<ConnectionModel>> getFollowing(String userId) async =>
      _connections;

  @override
  Future<List<ConnectionModel>> getFollowers(String userId) async =>
      _connections.reversed.toList();
}
