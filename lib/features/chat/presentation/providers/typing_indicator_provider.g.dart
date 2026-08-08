// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typing_indicator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$typingIndicatorHash() => r'2fd007a72f0d7e9312411c6676011a70f4267893';

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

abstract class _$TypingIndicator extends BuildlessAutoDisposeNotifier<bool> {
  late final String conversationId;

  bool build(String conversationId);
}

/// See also [TypingIndicator].
@ProviderFor(TypingIndicator)
const typingIndicatorProvider = TypingIndicatorFamily();

/// See also [TypingIndicator].
class TypingIndicatorFamily extends Family<bool> {
  /// See also [TypingIndicator].
  const TypingIndicatorFamily();

  /// See also [TypingIndicator].
  TypingIndicatorProvider call(String conversationId) {
    return TypingIndicatorProvider(conversationId);
  }

  @override
  TypingIndicatorProvider getProviderOverride(
    covariant TypingIndicatorProvider provider,
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
  String? get name => r'typingIndicatorProvider';
}

/// See also [TypingIndicator].
class TypingIndicatorProvider
    extends AutoDisposeNotifierProviderImpl<TypingIndicator, bool> {
  /// See also [TypingIndicator].
  TypingIndicatorProvider(String conversationId)
    : this._internal(
        () => TypingIndicator()..conversationId = conversationId,
        from: typingIndicatorProvider,
        name: r'typingIndicatorProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$typingIndicatorHash,
        dependencies: TypingIndicatorFamily._dependencies,
        allTransitiveDependencies:
            TypingIndicatorFamily._allTransitiveDependencies,
        conversationId: conversationId,
      );

  TypingIndicatorProvider._internal(
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
  bool runNotifierBuild(covariant TypingIndicator notifier) {
    return notifier.build(conversationId);
  }

  @override
  Override overrideWith(TypingIndicator Function() create) {
    return ProviderOverride(
      origin: this,
      override: TypingIndicatorProvider._internal(
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
  AutoDisposeNotifierProviderElement<TypingIndicator, bool> createElement() {
    return _TypingIndicatorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TypingIndicatorProvider &&
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
mixin TypingIndicatorRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _TypingIndicatorProviderElement
    extends AutoDisposeNotifierProviderElement<TypingIndicator, bool>
    with TypingIndicatorRef {
  _TypingIndicatorProviderElement(super.provider);

  @override
  String get conversationId =>
      (origin as TypingIndicatorProvider).conversationId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
