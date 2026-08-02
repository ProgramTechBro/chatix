import '../../domain/entities/searched_user_entity.dart';

class SearchedUserModel extends SearchedUserEntity {
  const SearchedUserModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.isOnline,
  });

  factory SearchedUserModel.fromJson(Map<String, dynamic> json) {
    return SearchedUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String? ?? '',
      isOnline: json['is_online'] as bool? ?? false,
    );
  }
}
