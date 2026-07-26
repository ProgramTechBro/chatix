import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/share_contacts_repository.dart';
import '../entities/share_contact_entity.dart';

@injectable
class GetShareContactsUseCase {
  const GetShareContactsUseCase(this._repository);

  final ShareContactsRepository _repository;

  Future<Either<Failure, List<ShareContactEntity>>> call() => _repository.getContacts();
}
