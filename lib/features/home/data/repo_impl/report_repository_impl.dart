import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/local/report_local_datasource.dart';
import '../repo/report_repository.dart';

@LazySingleton(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  const ReportRepositoryImpl(this._localDataSource);

  final ReportLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, void>> submitReport({required String postId, required String reason}) async {
    await _localDataSource.submitReport(postId: postId, reason: reason);
    return const Right(null);
  }
}
