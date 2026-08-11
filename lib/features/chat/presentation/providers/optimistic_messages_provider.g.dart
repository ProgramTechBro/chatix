// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optimistic_messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$optimisticMessagesHash() =>
    r'd86fbf8e3968e557e1197155f8c641dabf80e7ec';

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

abstract class _$OptimisticMessages
    extends BuildlessAutoDisposeNotifier<List<MessageEntity>> {
  late final String conversationId;

  List<MessageEntity> build(String conversationId);
}

/// See also [OptimisticMessages].
@ProviderFor(OptimisticMessages)
const optimisticMessagesProvider = OptimisticMessagesFamily();

/// See also [OptimisticMessages].
class OptimisticMessagesFamily extends Family<List<MessageEntity>> {
  /// See also [OptimisticMessages].
  const OptimisticMessagesFamily();

  /// See also [OptimisticMessages].
  OptimisticMessagesProvider call(String conversationId) {
    return OptimisticMessagesProvider(conversationId);
  }

  @override
  OptimisticMessagesProvider getProviderOverride(
    covariant OptimisticMessagesProvider provider,
  ) {
    return call(provider.conversationId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'optimisticMessagesProvider';
}

/// See also [OptimisticMessages].
class OptimisticMessagesProvider
    extends
        AutoDisposeNotifierProviderImpl<
          OptimisticMessages,
          List<MessageEntity>
        > {
  /// See also [OptimisticMessages].
  OptimisticMessagesProvider(String conversationId)
    : this._internal(
        () => OptimisticMessages()..conversationId = conversationId,
        from: optimisticMessagesProvider,
        name: r'optimisticMessagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$optimisticMessagesHash,
        dependencies: OptimisticMessagesFamily._dependencies,
        allTransitiveDependencies:
            OptimisticMessagesFamily._allTransitiveDependencies,
        conversationId: conversationId,
      );

  OptimisticMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.conversationId,
  }) : super.internal();

  final String conversationId;

  @override
  List<MessageEntity> runNotifierBuild(covariant OptimisticMessages notifier) {
    return notifier.build(conversationId);
  }

  @override
  Override overrideWith(OptimisticMessages Function() create) {
    return ProviderOverride(
      origin: this,
      override: OptimisticMessagesProvider._internal(
        () => create()..conversationId = conversationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        conversationId: conversationId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<OptimisticMessages, List<MessageEntity>>
  createElement() {
    return _OptimisticMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OptimisticMessagesProvider &&
        other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OptimisticMessagesRef
    on AutoDisposeNotifierProviderRef<List<MessageEntity>> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _OptimisticMessagesProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          OptimisticMessages,
          List<MessageEntity>
        >
    with OptimisticMessagesRef {
  _OptimisticMessagesProviderElement(super.provider);

  @override
  String get conversationId =>
      (origin as OptimisticMessagesProvider).conversationId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
