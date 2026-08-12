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
String _$chatListReadyHash() => r'0f70e87b1ce5d67c269c0dabcff50490de551ece';

/// See also [chatListReady].
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
