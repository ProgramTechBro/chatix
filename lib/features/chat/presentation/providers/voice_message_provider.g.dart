// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_message_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$voiceMessageHash() => r'7e2fa524b15eea5911b01515f551bd4756f89018';

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

/// See also [voiceMessage].
@ProviderFor(voiceMessage)
const voiceMessageProvider = VoiceMessageFamily();

/// See also [voiceMessage].
class VoiceMessageFamily extends Family<AsyncValue<VoiceWaveformEntity>> {
  /// See also [voiceMessage].
  const VoiceMessageFamily();

  /// See also [voiceMessage].
  VoiceMessageProvider call(String audioUrl) {
    return VoiceMessageProvider(audioUrl);
  }

  @override
  VoiceMessageProvider getProviderOverride(
    covariant VoiceMessageProvider provider,
  ) {
    return call(provider.audioUrl);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'voiceMessageProvider';
}

/// See also [voiceMessage].
class VoiceMessageProvider extends FutureProvider<VoiceWaveformEntity> {
  /// See also [voiceMessage].
  VoiceMessageProvider(String audioUrl)
    : this._internal(
        (ref) => voiceMessage(ref as VoiceMessageRef, audioUrl),
        from: voiceMessageProvider,
        name: r'voiceMessageProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$voiceMessageHash,
        dependencies: VoiceMessageFamily._dependencies,
        allTransitiveDependencies:
            VoiceMessageFamily._allTransitiveDependencies,
        audioUrl: audioUrl,
      );

  VoiceMessageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.audioUrl,
  }) : super.internal();

  final String audioUrl;

  @override
  Override overrideWith(
    FutureOr<VoiceWaveformEntity> Function(VoiceMessageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VoiceMessageProvider._internal(
        (ref) => create(ref as VoiceMessageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        audioUrl: audioUrl,
      ),
    );
  }

  @override
  FutureProviderElement<VoiceWaveformEntity> createElement() {
    return _VoiceMessageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VoiceMessageProvider && other.audioUrl == audioUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, audioUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VoiceMessageRef on FutureProviderRef<VoiceWaveformEntity> {
  /// The parameter `audioUrl` of this provider.
  String get audioUrl;
}

class _VoiceMessageProviderElement
    extends FutureProviderElement<VoiceWaveformEntity>
    with VoiceMessageRef {
  _VoiceMessageProviderElement(super.provider);

  @override
  String get audioUrl => (origin as VoiceMessageProvider).audioUrl;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
