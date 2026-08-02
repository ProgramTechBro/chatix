import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/share_contact_entity.dart';

abstract class ShareContactsRepository {
  Future<Either<Failure, List<ShareContactEntity>>> getContacts();
}
