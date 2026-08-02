import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/searched_user_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchedUserModel>> getRecentSearches();
  Future<List<SearchedUserModel>> searchUsers(String query);
}

@LazySingleton(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  SearchRemoteDataSourceImpl(this._client);

  final SupabaseClient _client;

  String get _currentUserId => _client.auth.currentUser!.id;

  @override
  Future<List<SearchedUserModel>> getRecentSearches() async {
    final rows = await _client
        .from('profiles')
        .select()
        .neq('id', _currentUserId);
    return rows.map(SearchedUserModel.fromJson).toList();
  }

  @override
  Future<List<SearchedUserModel>> searchUsers(String query) async {
    if (query.trim().isEmpty) return getRecentSearches();
    final rows = await _client
        .from('profiles')
        .select()
        .neq('id', _currentUserId)
        .ilike('name', '%$query%');
    return rows.map(SearchedUserModel.fromJson).toList();
  }
}
