import 'package:injectable/injectable.dart';

abstract class ReportLocalDataSource {
  Future<void> submitReport({required String postId, required String reason});
}

@LazySingleton(as: ReportLocalDataSource)
class ReportLocalDataSourceImpl implements ReportLocalDataSource {
  @override
  Future<void> submitReport({
    required String postId,
    required String reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
