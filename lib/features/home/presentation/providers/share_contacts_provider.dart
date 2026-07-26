import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/share_contact_entity.dart';
import '../../domain/usecases/get_share_contacts_usecase.dart';

part 'share_contacts_provider.g.dart';

@riverpod
Future<List<ShareContactEntity>> shareContacts(ShareContactsRef ref) async {
  final result = await getIt<GetShareContactsUseCase>().call();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (contacts) => contacts,
  );
}
