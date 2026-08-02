import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/share_contact_entity.dart';
import '../repositories/share_contacts_repository.dart';

@injectable
class GetShareContactsUseCase {
  const GetShareContactsUseCase(this._repository);

  final ShareContactsRepository _repository;

  Future<Either<Failure, List<ShareContactEntity>>> call() =>
      _repository.getContacts();
}
