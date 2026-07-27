import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/report_repository.dart';

@injectable
class SubmitPostReportUseCase {
  const SubmitPostReportUseCase(this._repository);

  final ReportRepository _repository;

  Future<Either<Failure, void>> call({required String postId, required String reason}) =>
      _repository.submitReport(postId: postId, reason: reason);
}
