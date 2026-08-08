import 'package:injectable/injectable.dart';
import '../../domain/repositories/typing_repository.dart';
import '../datasources/remote/typing_remote_datasource.dart';

@LazySingleton(as: TypingRepository)
class TypingRepositoryImpl implements TypingRepository {
  const TypingRepositoryImpl(this._remoteDataSource);

  final TypingRemoteDataSource _remoteDataSource;

  @override
  Future<void> sendTyping(String conversationId) {
    return _remoteDataSource.sendTyping(conversationId);
  }

  @override
  Stream<void> watchTyping(String conversationId) {
    return _remoteDataSource.watchTyping(conversationId);
  }
}
