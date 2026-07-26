import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/share_contact_model.dart';

abstract class ShareContactsLocalDataSource {
  Future<List<ShareContactModel>> getContacts();
}

@LazySingleton(as: ShareContactsLocalDataSource)
class ShareContactsLocalDataSourceImpl implements ShareContactsLocalDataSource {
  @override
  Future<List<ShareContactModel>> getContacts() async {
    return const [
      ShareContactModel(id: 'u1', name: 'Mike tyson', avatarUrl: AppNetworkImages.postAuthorMikeTyson),
      ShareContactModel(id: 'u2', name: 'Jonathan', avatarUrl: AppNetworkImages.contactJonathan),
      ShareContactModel(id: 'u3', name: 'Gebrel', avatarUrl: AppNetworkImages.contactGebrel),
      ShareContactModel(id: 'u4', name: 'Sultan', avatarUrl: AppNetworkImages.contactSultan),
      ShareContactModel(id: 'u5', name: 'Joshim', avatarUrl: AppNetworkImages.contactJoshim),
      ShareContactModel(id: 'u6', name: 'Albert', avatarUrl: AppNetworkImages.contactAlbert),
    ];
  }
}
