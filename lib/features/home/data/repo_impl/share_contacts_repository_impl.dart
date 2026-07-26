import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/share_contact_entity.dart';
import '../datasources/local/share_contacts_local_datasource.dart';
import '../repo/share_contacts_repository.dart';

@LazySingleton(as: ShareContactsRepository)
class ShareContactsRepositoryImpl implements ShareContactsRepository {
  const ShareContactsRepositoryImpl(this._localDataSource);

  final ShareContactsLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<ShareContactEntity>>> getContacts() async {
    final contacts = await _localDataSource.getContacts();
    return Right(contacts);
  }
}
