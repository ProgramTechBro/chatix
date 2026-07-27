import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class ReportRepository {
  Future<Either<Failure, void>> submitReport({required String postId, required String reason});
}
