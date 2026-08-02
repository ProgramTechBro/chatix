// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessagesHash() => r'f25e65329d871518777d38a21cf8874cee4eda32';

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

/// See also [chatMessages].
@ProviderFor(chatMessages)
const chatMessagesProvider = ChatMessagesFamily();

/// See also [chatMessages].
class ChatMessagesFamily extends Family<AsyncValue<List<MessageEntity>>> {
  /// See also [chatMessages].
  const ChatMessagesFamily();

  /// See also [chatMessages].
  ChatMessagesProvider call(String conversationId) {
    return ChatMessagesProvider(conversationId);
  }

  @override
  ChatMessagesProvider getProviderOverride(
    covariant ChatMessagesProvider provider,
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
  String? get name => r'chatMessagesProvider';
}

/// See also [chatMessages].
class ChatMessagesProvider
    extends AutoDisposeStreamProvider<List<MessageEntity>> {
  /// See also [chatMessages].
  ChatMessagesProvider(String conversationId)
    : this._internal(
        (ref) => chatMessages(ref as ChatMessagesRef, conversationId),
        from: chatMessagesProvider,
        name: r'chatMessagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatMessagesHash,
        dependencies: ChatMessagesFamily._dependencies,
        allTransitiveDependencies:
            ChatMessagesFamily._allTransitiveDependencies,
        conversationId: conversationId,
      );

  ChatMessagesProvider._internal(
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
  Override overrideWith(
    Stream<List<MessageEntity>> Function(ChatMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatMessagesProvider._internal(
        (ref) => create(ref as ChatMessagesRef),
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
  AutoDisposeStreamProviderElement<List<MessageEntity>> createElement() {
    return _ChatMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesProvider &&
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
mixin ChatMessagesRef on AutoDisposeStreamProviderRef<List<MessageEntity>> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _ChatMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<MessageEntity>>
    with ChatMessagesRef {
  _ChatMessagesProviderElement(super.provider);

  @override
  String get conversationId => (origin as ChatMessagesProvider).conversationId;
}

String _$chatHeaderHash() => r'c75a0d9abce878d313a0ad21b6e2fbc2d3284fbf';

/// See also [chatHeader].
@ProviderFor(chatHeader)
const chatHeaderProvider = ChatHeaderFamily();

/// See also [chatHeader].
class ChatHeaderFamily extends Family<AsyncValue<ChatHeaderEntity>> {
  /// See also [chatHeader].
  const ChatHeaderFamily();

  /// See also [chatHeader].
  ChatHeaderProvider call(String conversationId) {
    return ChatHeaderProvider(conversationId);
  }

  @override
  ChatHeaderProvider getProviderOverride(
    covariant ChatHeaderProvider provider,
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
  String? get name => r'chatHeaderProvider';
}

/// See also [chatHeader].
class ChatHeaderProvider extends AutoDisposeFutureProvider<ChatHeaderEntity> {
  /// See also [chatHeader].
  ChatHeaderProvider(String conversationId)
    : this._internal(
        (ref) => chatHeader(ref as ChatHeaderRef, conversationId),
        from: chatHeaderProvider,
        name: r'chatHeaderProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatHeaderHash,
        dependencies: ChatHeaderFamily._dependencies,
        allTransitiveDependencies: ChatHeaderFamily._allTransitiveDependencies,
        conversationId: conversationId,
      );

  ChatHeaderProvider._internal(
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
  Override overrideWith(
    FutureOr<ChatHeaderEntity> Function(ChatHeaderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatHeaderProvider._internal(
        (ref) => create(ref as ChatHeaderRef),
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
  AutoDisposeFutureProviderElement<ChatHeaderEntity> createElement() {
    return _ChatHeaderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatHeaderProvider &&
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
mixin ChatHeaderRef on AutoDisposeFutureProviderRef<ChatHeaderEntity> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _ChatHeaderProviderElement
    extends AutoDisposeFutureProviderElement<ChatHeaderEntity>
    with ChatHeaderRef {
  _ChatHeaderProviderElement(super.provider);

  @override
  String get conversationId => (origin as ChatHeaderProvider).conversationId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
