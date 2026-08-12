// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatListHash() => r'322d0dfb4d8b378fa674467161793c39188ce85e';

/// See also [chatList].
@ProviderFor(chatList)
final chatListProvider = StreamProvider<List<ChatSummaryEntity>>.internal(
  chatList,
  name: r'chatListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatListRef = StreamProviderRef<List<ChatSummaryEntity>>;
String _$chatListReadyHash() => r'9c98e9214833f7b9eb48e6591eda70ce296dca4f';

/// Resolves as soon as the chat list itself is available (cache-first, so this
/// is near-instant on every app reopen). The chat list screen gates its
/// skeleton on this alone — it never waits on header/image warmup.
///
/// Copied from [chatListReady].
@ProviderFor(chatListReady)
final chatListReadyProvider = FutureProvider<List<ChatSummaryEntity>>.internal(
  chatListReady,
  name: r'chatListReadyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatListReadyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatListReadyRef = FutureProviderRef<List<ChatSummaryEntity>>;
String _$chatListWarmupHash() => r'4ac9b7f22f3bd7e4ec087106e9007a39b7335fdf';

/// Warms up the header and image cache for the most recent conversations in
/// the background, plus keeps listening for newly-arriving images in those
/// conversations for the rest of the session. Triggered fire-and-forget at
/// login/session-restore; never blocks the chat list screen's own render.
///
/// Copied from [chatListWarmup].
@ProviderFor(chatListWarmup)
final chatListWarmupProvider = FutureProvider<void>.internal(
  chatListWarmup,
  name: r'chatListWarmupProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatListWarmupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatListWarmupRef = FutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
