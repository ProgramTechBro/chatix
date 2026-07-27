// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileHash() => r'ce656c06c5a8fa2d211e4c5ee5d1594e424f2909';

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

/// See also [profile].
@ProviderFor(profile)
const profileProvider = ProfileFamily();

/// See also [profile].
class ProfileFamily extends Family<AsyncValue<ProfileEntity>> {
  /// See also [profile].
  const ProfileFamily();

  /// See also [profile].
  ProfileProvider call(String userId) {
    return ProfileProvider(userId);
  }

  @override
  ProfileProvider getProviderOverride(covariant ProfileProvider provider) {
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
  String? get name => r'profileProvider';
}

/// See also [profile].
class ProfileProvider extends AutoDisposeFutureProvider<ProfileEntity> {
  /// See also [profile].
  ProfileProvider(String userId)
    : this._internal(
        (ref) => profile(ref as ProfileRef, userId),
        from: profileProvider,
        name: r'profileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$profileHash,
        dependencies: ProfileFamily._dependencies,
        allTransitiveDependencies: ProfileFamily._allTransitiveDependencies,
        userId: userId,
      );

  ProfileProvider._internal(
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
    FutureOr<ProfileEntity> Function(ProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProfileProvider._internal(
        (ref) => create(ref as ProfileRef),
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
  AutoDisposeFutureProviderElement<ProfileEntity> createElement() {
    return _ProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileProvider && other.userId == userId;
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
mixin ProfileRef on AutoDisposeFutureProviderRef<ProfileEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ProfileProviderElement
    extends AutoDisposeFutureProviderElement<ProfileEntity>
    with ProfileRef {
  _ProfileProviderElement(super.provider);

  @override
  String get userId => (origin as ProfileProvider).userId;
}

String _$profilePostsHash() => r'4490a6e6b65053e8a0ecbfd4ff3d1da7b64350fd';

/// See also [profilePosts].
@ProviderFor(profilePosts)
const profilePostsProvider = ProfilePostsFamily();

/// See also [profilePosts].
class ProfilePostsFamily extends Family<AsyncValue<List<PostEntity>>> {
  /// See also [profilePosts].
  const ProfilePostsFamily();

  /// See also [profilePosts].
  ProfilePostsProvider call(String userId) {
    return ProfilePostsProvider(userId);
  }

  @override
  ProfilePostsProvider getProviderOverride(
    covariant ProfilePostsProvider provider,
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
  String? get name => r'profilePostsProvider';
}

/// See also [profilePosts].
class ProfilePostsProvider extends AutoDisposeFutureProvider<List<PostEntity>> {
  /// See also [profilePosts].
  ProfilePostsProvider(String userId)
    : this._internal(
        (ref) => profilePosts(ref as ProfilePostsRef, userId),
        from: profilePostsProvider,
        name: r'profilePostsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$profilePostsHash,
        dependencies: ProfilePostsFamily._dependencies,
        allTransitiveDependencies:
            ProfilePostsFamily._allTransitiveDependencies,
        userId: userId,
      );

  ProfilePostsProvider._internal(
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
    FutureOr<List<PostEntity>> Function(ProfilePostsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProfilePostsProvider._internal(
        (ref) => create(ref as ProfilePostsRef),
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
  AutoDisposeFutureProviderElement<List<PostEntity>> createElement() {
    return _ProfilePostsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfilePostsProvider && other.userId == userId;
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
mixin ProfilePostsRef on AutoDisposeFutureProviderRef<List<PostEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ProfilePostsProviderElement
    extends AutoDisposeFutureProviderElement<List<PostEntity>>
    with ProfilePostsRef {
  _ProfilePostsProviderElement(super.provider);

  @override
  String get userId => (origin as ProfilePostsProvider).userId;
}

String _$profilePhotosHash() => r'c21a0916c6e0b9794e284ae6f43c706781adf521';

/// See also [profilePhotos].
@ProviderFor(profilePhotos)
const profilePhotosProvider = ProfilePhotosFamily();

/// See also [profilePhotos].
class ProfilePhotosFamily extends Family<AsyncValue<List<String>>> {
  /// See also [profilePhotos].
  const ProfilePhotosFamily();

  /// See also [profilePhotos].
  ProfilePhotosProvider call(String userId) {
    return ProfilePhotosProvider(userId);
  }

  @override
  ProfilePhotosProvider getProviderOverride(
    covariant ProfilePhotosProvider provider,
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
  String? get name => r'profilePhotosProvider';
}

/// See also [profilePhotos].
class ProfilePhotosProvider extends AutoDisposeFutureProvider<List<String>> {
  /// See also [profilePhotos].
  ProfilePhotosProvider(String userId)
    : this._internal(
        (ref) => profilePhotos(ref as ProfilePhotosRef, userId),
        from: profilePhotosProvider,
        name: r'profilePhotosProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$profilePhotosHash,
        dependencies: ProfilePhotosFamily._dependencies,
        allTransitiveDependencies:
            ProfilePhotosFamily._allTransitiveDependencies,
        userId: userId,
      );

  ProfilePhotosProvider._internal(
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
    FutureOr<List<String>> Function(ProfilePhotosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProfilePhotosProvider._internal(
        (ref) => create(ref as ProfilePhotosRef),
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
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _ProfilePhotosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfilePhotosProvider && other.userId == userId;
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
mixin ProfilePhotosRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ProfilePhotosProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with ProfilePhotosRef {
  _ProfilePhotosProviderElement(super.provider);

  @override
  String get userId => (origin as ProfilePhotosProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
