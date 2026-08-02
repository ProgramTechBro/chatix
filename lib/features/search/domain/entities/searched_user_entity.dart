class SearchedUserEntity {
  const SearchedUserEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isOnline,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;
}
