// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connections_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$followingListHash() => r'3e2faab0646930a0668da5708dd4fc9e59cddb05';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [followingList].
@ProviderFor(followingList)
const followingListProvider = FollowingListFamily();

/// See also [followingList].
class FollowingListFamily extends Family<AsyncValue<List<ConnectionEntity>>> {
  /// See also [followingList].
  const FollowingListFamily();

  /// See also [followingList].
  FollowingListProvider call(String userId) {
    return FollowingListProvider(userId);
  }

  @override
  FollowingListProvider getProviderOverride(
    covariant FollowingListProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'followingListProvider';
}

/// See also [followingList].
class FollowingListProvider
    extends AutoDisposeFutureProvider<List<ConnectionEntity>> {
  /// See also [followingList].
  FollowingListProvider(String userId)
    : this._internal(
        (ref) => followingList(ref as FollowingListRef, userId),
        from: followingListProvider,
        name: r'followingListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$followingListHash,
        dependencies: FollowingListFamily._dependencies,
        allTransitiveDependencies:
            FollowingListFamily._allTransitiveDependencies,
        userId: userId,
      );

  FollowingListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<ConnectionEntity>> Function(FollowingListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FollowingListProvider._internal(
        (ref) => create(ref as FollowingListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ConnectionEntity>> createElement() {
    return _FollowingListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowingListProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowingListRef on AutoDisposeFutureProviderRef<List<ConnectionEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FollowingListProviderElement
    extends AutoDisposeFutureProviderElement<List<ConnectionEntity>>
    with FollowingListRef {
  _FollowingListProviderElement(super.provider);

  @override
  String get userId => (origin as FollowingListProvider).userId;
}

String _$followersListHash() => r'dacac39a394a88274e515088df9f0f88cf383050';

/// See also [followersList].
@ProviderFor(followersList)
const followersListProvider = FollowersListFamily();

/// See also [followersList].
class FollowersListFamily extends Family<AsyncValue<List<ConnectionEntity>>> {
  /// See also [followersList].
  const FollowersListFamily();

  /// See also [followersList].
  FollowersListProvider call(String userId) {
    return FollowersListProvider(userId);
  }

  @override
  FollowersListProvider getProviderOverride(
    covariant FollowersListProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'followersListProvider';
}

/// See also [followersList].
class FollowersListProvider
    extends AutoDisposeFutureProvider<List<ConnectionEntity>> {
  /// See also [followersList].
  FollowersListProvider(String userId)
    : this._internal(
        (ref) => followersList(ref as FollowersListRef, userId),
        from: followersListProvider,
        name: r'followersListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$followersListHash,
        dependencies: FollowersListFamily._dependencies,
        allTransitiveDependencies:
            FollowersListFamily._allTransitiveDependencies,
        userId: userId,
      );

  FollowersListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<ConnectionEntity>> Function(FollowersListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FollowersListProvider._internal(
        (ref) => create(ref as FollowersListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ConnectionEntity>> createElement() {
    return _FollowersListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowersListProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowersListRef on AutoDisposeFutureProviderRef<List<ConnectionEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FollowersListProviderElement
    extends AutoDisposeFutureProviderElement<List<ConnectionEntity>>
    with FollowersListRef {
  _FollowersListProviderElement(super.provider);

  @override
  String get userId => (origin as FollowersListProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
