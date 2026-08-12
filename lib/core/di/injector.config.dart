// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatix/core/backend/firebase_client.dart' as _i394;
import 'package:chatix/core/backend/supabase_client.dart' as _i449;
import 'package:chatix/core/services/active_conversation_tracker.dart' as _i154;
import 'package:chatix/core/services/local_storage_service.dart' as _i1023;
import 'package:chatix/core/services/logger_service.dart' as _i399;
import 'package:chatix/core/services/permission_service.dart' as _i763;
import 'package:chatix/core/services/push_notification_service.dart' as _i66;
import 'package:chatix/features/auth/data/datasources/remote/firebase_phone_auth_remote_datasource.dart'
    as _i698;
import 'package:chatix/features/auth/data/datasources/remote/firebase_phone_auth_remote_datasource_impl.dart'
    as _i163;
import 'package:chatix/features/auth/data/datasources/remote/supabase_auth_remote_datasource.dart'
    as _i290;
import 'package:chatix/features/auth/data/datasources/remote/supabase_auth_remote_datasource_impl.dart'
    as _i659;
import 'package:chatix/features/auth/data/repositories/auth_repository_impl.dart'
    as _i28;
import 'package:chatix/features/auth/domain/repositories/auth_repository.dart'
    as _i31;
import 'package:chatix/features/auth/domain/usecases/confirm_phone_otp_usecase.dart'
    as _i295;
import 'package:chatix/features/auth/domain/usecases/restore_session_usecase.dart'
    as _i959;
import 'package:chatix/features/auth/domain/usecases/set_offline_usecase.dart'
    as _i13;
import 'package:chatix/features/auth/domain/usecases/sign_in_with_email_usecase.dart'
    as _i974;
import 'package:chatix/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i525;
import 'package:chatix/features/auth/domain/usecases/sign_up_with_email_usecase.dart'
    as _i824;
import 'package:chatix/features/auth/domain/usecases/update_display_name_usecase.dart'
    as _i513;
import 'package:chatix/features/auth/domain/usecases/update_last_seen_usecase.dart'
    as _i30;
import 'package:chatix/features/auth/domain/usecases/verify_phone_number_usecase.dart'
    as _i906;
import 'package:chatix/features/chat/data/datasources/local/chat_header_local_datasource.dart'
    as _i1032;
import 'package:chatix/features/chat/data/datasources/local/chat_header_local_datasource_impl.dart'
    as _i537;
import 'package:chatix/features/chat/data/datasources/local/chat_local_datasource.dart'
    as _i430;
import 'package:chatix/features/chat/data/datasources/local/chat_local_datasource_impl.dart'
    as _i596;
import 'package:chatix/features/chat/data/datasources/local/voice_cache_local_datasource.dart'
    as _i686;
import 'package:chatix/features/chat/data/datasources/local/voice_cache_local_datasource_impl.dart'
    as _i782;
import 'package:chatix/features/chat/data/datasources/remote/chat_remote_datasource.dart'
    as _i654;
import 'package:chatix/features/chat/data/datasources/remote/chat_remote_datasource_impl.dart'
    as _i975;
import 'package:chatix/features/chat/data/datasources/remote/typing_remote_datasource.dart'
    as _i105;
import 'package:chatix/features/chat/data/datasources/remote/typing_remote_datasource_impl.dart'
    as _i331;
import 'package:chatix/features/chat/data/repositories/chat_repository_impl.dart'
    as _i1056;
import 'package:chatix/features/chat/data/repositories/typing_repository_impl.dart'
    as _i819;
import 'package:chatix/features/chat/data/repositories/voice_repository_impl.dart'
    as _i228;
import 'package:chatix/features/chat/domain/repositories/chat_repository.dart'
    as _i930;
import 'package:chatix/features/chat/domain/repositories/typing_repository.dart'
    as _i529;
import 'package:chatix/features/chat/domain/repositories/voice_repository.dart'
    as _i847;
import 'package:chatix/features/chat/domain/usecases/get_or_extract_voice_waveform_usecase.dart'
    as _i566;
import 'package:chatix/features/chat/domain/usecases/mark_conversation_read_usecase.dart'
    as _i166;
import 'package:chatix/features/chat/domain/usecases/send_image_message_usecase.dart'
    as _i785;
import 'package:chatix/features/chat/domain/usecases/send_message_usecase.dart'
    as _i994;
import 'package:chatix/features/chat/domain/usecases/send_typing_indicator_usecase.dart'
    as _i69;
import 'package:chatix/features/chat/domain/usecases/send_voice_message_usecase.dart'
    as _i229;
import 'package:chatix/features/chat/domain/usecases/watch_conversation_header_usecase.dart'
    as _i504;
import 'package:chatix/features/chat/domain/usecases/watch_messages_usecase.dart'
    as _i642;
import 'package:chatix/features/chat/domain/usecases/watch_typing_indicator_usecase.dart'
    as _i62;
import 'package:chatix/features/chat_list/data/datasources/local/chat_list_local_datasource.dart'
    as _i110;
import 'package:chatix/features/chat_list/data/datasources/local/chat_list_local_datasource_impl.dart'
    as _i894;
import 'package:chatix/features/chat_list/data/datasources/remote/chat_list_remote_datasource.dart'
    as _i480;
import 'package:chatix/features/chat_list/data/datasources/remote/chat_list_remote_datasource_impl.dart'
    as _i495;
import 'package:chatix/features/chat_list/data/repositories/chat_list_repository_impl.dart'
    as _i870;
import 'package:chatix/features/chat_list/domain/repositories/chat_list_repository.dart'
    as _i20;
import 'package:chatix/features/chat_list/domain/usecases/get_or_create_conversation_usecase.dart'
    as _i205;
import 'package:chatix/features/chat_list/domain/usecases/watch_chat_list_usecase.dart'
    as _i705;
import 'package:chatix/features/connections/data/datasources/local/connections_local_datasource.dart'
    as _i974;
import 'package:chatix/features/connections/data/repositories/connections_repository_impl.dart'
    as _i860;
import 'package:chatix/features/connections/domain/repositories/connections_repository.dart'
    as _i446;
import 'package:chatix/features/connections/domain/usecases/get_followers_usecase.dart'
    as _i248;
import 'package:chatix/features/connections/domain/usecases/get_following_usecase.dart'
    as _i1061;
import 'package:chatix/features/home/data/datasources/local/comments_local_datasource.dart'
    as _i958;
import 'package:chatix/features/home/data/datasources/local/feed_local_datasource.dart'
    as _i400;
import 'package:chatix/features/home/data/datasources/local/report_local_datasource.dart'
    as _i187;
import 'package:chatix/features/home/data/datasources/local/share_contacts_local_datasource.dart'
    as _i2;
import 'package:chatix/features/home/data/repositories/comments_repository_impl.dart'
    as _i1025;
import 'package:chatix/features/home/data/repositories/feed_repository_impl.dart'
    as _i622;
import 'package:chatix/features/home/data/repositories/report_repository_impl.dart'
    as _i825;
import 'package:chatix/features/home/data/repositories/share_contacts_repository_impl.dart'
    as _i26;
import 'package:chatix/features/home/domain/repositories/comments_repository.dart'
    as _i1054;
import 'package:chatix/features/home/domain/repositories/feed_repository.dart'
    as _i100;
import 'package:chatix/features/home/domain/repositories/report_repository.dart'
    as _i462;
import 'package:chatix/features/home/domain/repositories/share_contacts_repository.dart'
    as _i376;
import 'package:chatix/features/home/domain/usecases/get_feed_posts_usecase.dart'
    as _i738;
import 'package:chatix/features/home/domain/usecases/get_post_comments_usecase.dart'
    as _i480;
import 'package:chatix/features/home/domain/usecases/get_share_contacts_usecase.dart'
    as _i999;
import 'package:chatix/features/home/domain/usecases/submit_post_report_usecase.dart'
    as _i146;
import 'package:chatix/features/home/domain/usecases/toggle_like_post_usecase.dart'
    as _i802;
import 'package:chatix/features/notifications/data/datasources/fcm_token_datasource.dart'
    as _i954;
import 'package:chatix/features/notifications/data/datasources/local/notifications_local_datasource.dart'
    as _i580;
import 'package:chatix/features/notifications/data/datasources/local/pending_message_local_datasource.dart'
    as _i460;
import 'package:chatix/features/notifications/data/datasources/local/pending_message_local_datasource_impl.dart'
    as _i983;
import 'package:chatix/features/notifications/data/repositories/notifications_repository_impl.dart'
    as _i124;
import 'package:chatix/features/notifications/data/repositories/pending_messages_repository_impl.dart'
    as _i287;
import 'package:chatix/features/notifications/domain/repositories/notifications_repository.dart'
    as _i777;
import 'package:chatix/features/notifications/domain/repositories/pending_messages_repository.dart'
    as _i79;
import 'package:chatix/features/notifications/domain/usecases/add_pending_message_usecase.dart'
    as _i723;
import 'package:chatix/features/notifications/domain/usecases/clear_pending_messages_usecase.dart'
    as _i357;
import 'package:chatix/features/notifications/domain/usecases/get_notifications_usecase.dart'
    as _i653;
import 'package:chatix/features/notifications/domain/usecases/get_pending_messages_usecase.dart'
    as _i6;
import 'package:chatix/features/notifications/domain/usecases/save_device_token_usecase.dart'
    as _i1024;
import 'package:chatix/features/profile/data/datasources/local/profile_local_datasource.dart'
    as _i508;
import 'package:chatix/features/profile/data/repositories/profile_repository_impl.dart'
    as _i1030;
import 'package:chatix/features/profile/domain/repositories/profile_repository.dart'
    as _i367;
import 'package:chatix/features/profile/domain/usecases/get_profile_photos_usecase.dart'
    as _i397;
import 'package:chatix/features/profile/domain/usecases/get_profile_posts_usecase.dart'
    as _i716;
import 'package:chatix/features/profile/domain/usecases/get_profile_usecase.dart'
    as _i653;
import 'package:chatix/features/search/data/datasources/local/search_local_datasource.dart'
    as _i562;
import 'package:chatix/features/search/data/datasources/remote/search_remote_datasource.dart'
    as _i41;
import 'package:chatix/features/search/data/repositories/search_repository_impl.dart'
    as _i860;
import 'package:chatix/features/search/domain/repositories/search_repository.dart'
    as _i733;
import 'package:chatix/features/search/domain/usecases/get_recent_searches_usecase.dart'
    as _i474;
import 'package:chatix/features/search/domain/usecases/remove_recent_search_usecase.dart'
    as _i361;
import 'package:chatix/features/search/domain/usecases/search_users_usecase.dart'
    as _i949;
import 'package:chatix/features/videos/data/datasources/local/videos_local_datasource.dart'
    as _i164;
import 'package:chatix/features/videos/data/repositories/videos_repository_impl.dart'
    as _i309;
import 'package:chatix/features/videos/domain/repositories/videos_repository.dart'
    as _i132;
import 'package:chatix/features/videos/domain/usecases/get_videos_usecase.dart'
    as _i262;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseClientModule = _$FirebaseClientModule();
    final supabaseClientModule = _$SupabaseClientModule();
    gh.lazySingleton<_i59.FirebaseAuth>(
      () => firebaseClientModule.firebaseAuth,
    );
    gh.lazySingleton<_i454.SupabaseClient>(
      () => supabaseClientModule.supabaseClient,
    );
    gh.lazySingleton<_i154.ActiveConversationTracker>(
      () => _i154.ActiveConversationTracker(),
    );
    gh.lazySingleton<_i1023.LocalStorageService>(
      () => _i1023.LocalStorageService(),
    );
    gh.lazySingleton<_i399.LoggerService>(() => _i399.LoggerService());
    gh.lazySingleton<_i763.PermissionService>(() => _i763.PermissionService());
    gh.lazySingleton<_i66.PushNotificationService>(
      () => _i66.PushNotificationService(),
    );
    gh.lazySingleton<_i460.PendingMessageLocalDataSource>(
      () => _i983.PendingMessageLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i580.NotificationsLocalDataSource>(
      () => _i580.NotificationsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i2.ShareContactsLocalDataSource>(
      () => _i2.ShareContactsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i187.ReportLocalDataSource>(
      () => _i187.ReportLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i508.ProfileLocalDataSource>(
      () => _i508.ProfileLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i430.ChatLocalDataSource>(
      () => _i596.ChatLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i110.ChatListLocalDataSource>(
      () => _i894.ChatListLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i562.SearchLocalDataSource>(
      () => _i562.SearchLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i686.VoiceCacheLocalDataSource>(
      () => _i782.VoiceCacheLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i400.FeedLocalDataSource>(
      () => _i400.FeedLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i974.ConnectionsLocalDataSource>(
      () => _i974.ConnectionsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i1032.ChatHeaderLocalDataSource>(
      () => _i537.ChatHeaderLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i958.CommentsLocalDataSource>(
      () => _i958.CommentsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i164.VideosLocalDataSource>(
      () => _i164.VideosLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i41.SearchRemoteDataSource>(
      () => _i41.SearchRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i105.TypingRemoteDataSource>(
      () => _i331.TypingRemoteDataSourceImpl(
        gh<_i454.SupabaseClient>(),
        gh<_i399.LoggerService>(),
      ),
    );
    gh.lazySingleton<_i529.TypingRepository>(
      () => _i819.TypingRepositoryImpl(gh<_i105.TypingRemoteDataSource>()),
    );
    gh.lazySingleton<_i367.ProfileRepository>(
      () => _i1030.ProfileRepositoryImpl(gh<_i508.ProfileLocalDataSource>()),
    );
    gh.lazySingleton<_i1054.CommentsRepository>(
      () => _i1025.CommentsRepositoryImpl(gh<_i958.CommentsLocalDataSource>()),
    );
    gh.lazySingleton<_i462.ReportRepository>(
      () => _i825.ReportRepositoryImpl(gh<_i187.ReportLocalDataSource>()),
    );
    gh.lazySingleton<_i480.ChatListRemoteDataSource>(
      () => _i495.ChatListRemoteDataSourceImpl(
        gh<_i454.SupabaseClient>(),
        gh<_i399.LoggerService>(),
      ),
    );
    gh.lazySingleton<_i654.ChatRemoteDataSource>(
      () => _i975.ChatRemoteDataSourceImpl(
        gh<_i454.SupabaseClient>(),
        gh<_i399.LoggerService>(),
      ),
    );
    gh.lazySingleton<_i733.SearchRepository>(
      () => _i860.SearchRepositoryImpl(gh<_i41.SearchRemoteDataSource>()),
    );
    gh.lazySingleton<_i290.SupabaseAuthRemoteDataSource>(
      () => _i659.SupabaseAuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i397.GetProfilePhotosUseCase>(
      () => _i397.GetProfilePhotosUseCase(gh<_i367.ProfileRepository>()),
    );
    gh.factory<_i716.GetProfilePostsUseCase>(
      () => _i716.GetProfilePostsUseCase(gh<_i367.ProfileRepository>()),
    );
    gh.factory<_i653.GetProfileUseCase>(
      () => _i653.GetProfileUseCase(gh<_i367.ProfileRepository>()),
    );
    gh.lazySingleton<_i100.FeedRepository>(
      () => _i622.FeedRepositoryImpl(gh<_i400.FeedLocalDataSource>()),
    );
    gh.lazySingleton<_i132.VideosRepository>(
      () => _i309.VideosRepositoryImpl(gh<_i164.VideosLocalDataSource>()),
    );
    gh.lazySingleton<_i698.FirebasePhoneAuthRemoteDataSource>(
      () =>
          _i163.FirebasePhoneAuthRemoteDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i446.ConnectionsRepository>(
      () => _i860.ConnectionsRepositoryImpl(
        gh<_i974.ConnectionsLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i79.PendingMessagesRepository>(
      () => _i287.PendingMessagesRepositoryImpl(
        gh<_i460.PendingMessageLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i954.FcmTokenDataSource>(
      () => _i954.FcmTokenDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i376.ShareContactsRepository>(
      () => _i26.ShareContactsRepositoryImpl(
        gh<_i2.ShareContactsLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i930.ChatRepository>(
      () => _i1056.ChatRepositoryImpl(
        gh<_i654.ChatRemoteDataSource>(),
        gh<_i430.ChatLocalDataSource>(),
        gh<_i1032.ChatHeaderLocalDataSource>(),
      ),
    );
    gh.factory<_i166.MarkConversationReadUseCase>(
      () => _i166.MarkConversationReadUseCase(gh<_i930.ChatRepository>()),
    );
    gh.factory<_i785.SendImageMessageUseCase>(
      () => _i785.SendImageMessageUseCase(gh<_i930.ChatRepository>()),
    );
    gh.factory<_i994.SendMessageUseCase>(
      () => _i994.SendMessageUseCase(gh<_i930.ChatRepository>()),
    );
    gh.factory<_i229.SendVoiceMessageUseCase>(
      () => _i229.SendVoiceMessageUseCase(gh<_i930.ChatRepository>()),
    );
    gh.factory<_i504.WatchConversationHeaderUseCase>(
      () => _i504.WatchConversationHeaderUseCase(gh<_i930.ChatRepository>()),
    );
    gh.factory<_i642.WatchMessagesUseCase>(
      () => _i642.WatchMessagesUseCase(gh<_i930.ChatRepository>()),
    );
    gh.factory<_i69.SendTypingIndicatorUseCase>(
      () => _i69.SendTypingIndicatorUseCase(gh<_i529.TypingRepository>()),
    );
    gh.factory<_i62.WatchTypingIndicatorUseCase>(
      () => _i62.WatchTypingIndicatorUseCase(gh<_i529.TypingRepository>()),
    );
    gh.factory<_i248.GetFollowersUseCase>(
      () => _i248.GetFollowersUseCase(gh<_i446.ConnectionsRepository>()),
    );
    gh.factory<_i1061.GetFollowingUseCase>(
      () => _i1061.GetFollowingUseCase(gh<_i446.ConnectionsRepository>()),
    );
    gh.lazySingleton<_i847.VoiceRepository>(
      () => _i228.VoiceRepositoryImpl(gh<_i686.VoiceCacheLocalDataSource>()),
    );
    gh.factory<_i723.AddPendingMessageUseCase>(
      () =>
          _i723.AddPendingMessageUseCase(gh<_i79.PendingMessagesRepository>()),
    );
    gh.factory<_i357.ClearPendingMessagesUseCase>(
      () => _i357.ClearPendingMessagesUseCase(
        gh<_i79.PendingMessagesRepository>(),
      ),
    );
    gh.factory<_i6.GetPendingMessagesUseCase>(
      () => _i6.GetPendingMessagesUseCase(gh<_i79.PendingMessagesRepository>()),
    );
    gh.factory<_i999.GetShareContactsUseCase>(
      () => _i999.GetShareContactsUseCase(gh<_i376.ShareContactsRepository>()),
    );
    gh.lazySingleton<_i31.AuthRepository>(
      () => _i28.AuthRepositoryImpl(
        gh<_i290.SupabaseAuthRemoteDataSource>(),
        gh<_i698.FirebasePhoneAuthRemoteDataSource>(),
        gh<_i399.LoggerService>(),
      ),
    );
    gh.lazySingleton<_i20.ChatListRepository>(
      () => _i870.ChatListRepositoryImpl(
        gh<_i480.ChatListRemoteDataSource>(),
        gh<_i110.ChatListLocalDataSource>(),
      ),
    );
    gh.factory<_i738.GetFeedPostsUseCase>(
      () => _i738.GetFeedPostsUseCase(gh<_i100.FeedRepository>()),
    );
    gh.factory<_i802.ToggleLikePostUseCase>(
      () => _i802.ToggleLikePostUseCase(gh<_i100.FeedRepository>()),
    );
    gh.lazySingleton<_i777.NotificationsRepository>(
      () => _i124.NotificationsRepositoryImpl(
        gh<_i580.NotificationsLocalDataSource>(),
        gh<_i954.FcmTokenDataSource>(),
      ),
    );
    gh.factory<_i474.GetRecentSearchesUseCase>(
      () => _i474.GetRecentSearchesUseCase(gh<_i733.SearchRepository>()),
    );
    gh.factory<_i361.RemoveRecentSearchUseCase>(
      () => _i361.RemoveRecentSearchUseCase(gh<_i733.SearchRepository>()),
    );
    gh.factory<_i949.SearchUsersUseCase>(
      () => _i949.SearchUsersUseCase(gh<_i733.SearchRepository>()),
    );
    gh.factory<_i262.GetVideosUseCase>(
      () => _i262.GetVideosUseCase(gh<_i132.VideosRepository>()),
    );
    gh.factory<_i653.GetNotificationsUseCase>(
      () => _i653.GetNotificationsUseCase(gh<_i777.NotificationsRepository>()),
    );
    gh.factory<_i1024.SaveDeviceTokenUseCase>(
      () => _i1024.SaveDeviceTokenUseCase(gh<_i777.NotificationsRepository>()),
    );
    gh.factory<_i480.GetPostCommentsUseCase>(
      () => _i480.GetPostCommentsUseCase(gh<_i1054.CommentsRepository>()),
    );
    gh.factory<_i205.GetOrCreateConversationUseCase>(
      () => _i205.GetOrCreateConversationUseCase(gh<_i20.ChatListRepository>()),
    );
    gh.factory<_i705.WatchChatListUseCase>(
      () => _i705.WatchChatListUseCase(gh<_i20.ChatListRepository>()),
    );
    gh.factory<_i146.SubmitPostReportUseCase>(
      () => _i146.SubmitPostReportUseCase(gh<_i462.ReportRepository>()),
    );
    gh.factory<_i566.GetOrExtractVoiceWaveformUseCase>(
      () => _i566.GetOrExtractVoiceWaveformUseCase(gh<_i847.VoiceRepository>()),
    );
    gh.factory<_i295.ConfirmPhoneOtpUseCase>(
      () => _i295.ConfirmPhoneOtpUseCase(gh<_i31.AuthRepository>()),
    );
    gh.factory<_i959.RestoreSessionUseCase>(
      () => _i959.RestoreSessionUseCase(gh<_i31.AuthRepository>()),
    );
    gh.factory<_i13.SetOfflineUseCase>(
      () => _i13.SetOfflineUseCase(gh<_i31.AuthRepository>()),
    );
    gh.factory<_i974.SignInWithEmailUseCase>(
      () => _i974.SignInWithEmailUseCase(gh<_i31.AuthRepository>()),
    );
    gh.factory<_i525.SignOutUseCase>(
      () => _i525.SignOutUseCase(gh<_i31.AuthRepository>()),
    );
    gh.factory<_i824.SignUpWithEmailUseCase>(
      () => _i824.SignUpWithEmailUseCase(gh<_i31.AuthRepository>()),
    );
    gh.factory<_i513.UpdateDisplayNameUseCase>(
      () => _i513.UpdateDisplayNameUseCase(gh<_i31.AuthRepository>()),
    );
    gh.factory<_i30.UpdateLastSeenUseCase>(
      () => _i30.UpdateLastSeenUseCase(gh<_i31.AuthRepository>()),
    );
    gh.factory<_i906.VerifyPhoneNumberUseCase>(
      () => _i906.VerifyPhoneNumberUseCase(gh<_i31.AuthRepository>()),
    );
    return this;
  }
}

class _$FirebaseClientModule extends _i394.FirebaseClientModule {}

class _$SupabaseClientModule extends _i449.SupabaseClientModule {}
