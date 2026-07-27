// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatix/features/auth/data/repo/auth_repository.dart' as _i154;
import 'package:chatix/features/auth/data/repo_impl/auth_repository_impl.dart'
    as _i526;
import 'package:chatix/features/auth/domain/usecases/send_otp_usecase.dart'
    as _i544;
import 'package:chatix/features/auth/domain/usecases/verify_otp_usecase.dart'
    as _i943;
import 'package:chatix/features/chat_list/data/datasources/local/chat_list_local_datasource.dart'
    as _i110;
import 'package:chatix/features/chat_list/data/repo/chat_list_repository.dart'
    as _i504;
import 'package:chatix/features/chat_list/data/repo_impl/chat_list_repository_impl.dart'
    as _i959;
import 'package:chatix/features/chat_list/domain/usecases/get_chat_list_usecase.dart'
    as _i816;
import 'package:chatix/features/home/data/datasources/local/comments_local_datasource.dart'
    as _i958;
import 'package:chatix/features/home/data/datasources/local/feed_local_datasource.dart'
    as _i400;
import 'package:chatix/features/home/data/datasources/local/report_local_datasource.dart'
    as _i187;
import 'package:chatix/features/home/data/datasources/local/share_contacts_local_datasource.dart'
    as _i2;
import 'package:chatix/features/home/data/repo/comments_repository.dart'
    as _i903;
import 'package:chatix/features/home/data/repo/feed_repository.dart' as _i217;
import 'package:chatix/features/home/data/repo/report_repository.dart' as _i321;
import 'package:chatix/features/home/data/repo/share_contacts_repository.dart'
    as _i156;
import 'package:chatix/features/home/data/repo_impl/comments_repository_impl.dart'
    as _i6;
import 'package:chatix/features/home/data/repo_impl/feed_repository_impl.dart'
    as _i244;
import 'package:chatix/features/home/data/repo_impl/report_repository_impl.dart'
    as _i519;
import 'package:chatix/features/home/data/repo_impl/share_contacts_repository_impl.dart'
    as _i260;
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
import 'package:chatix/features/profile/data/datasources/local/profile_local_datasource.dart'
    as _i508;
import 'package:chatix/features/profile/data/repo/profile_repository.dart'
    as _i129;
import 'package:chatix/features/profile/data/repo_impl/profile_repository_impl.dart'
    as _i782;
import 'package:chatix/features/profile/domain/usecases/get_profile_photos_usecase.dart'
    as _i397;
import 'package:chatix/features/profile/domain/usecases/get_profile_posts_usecase.dart'
    as _i716;
import 'package:chatix/features/profile/domain/usecases/get_profile_usecase.dart'
    as _i653;
import 'package:chatix/features/search/data/datasources/local/search_local_datasource.dart'
    as _i562;
import 'package:chatix/features/search/data/repo/search_repository.dart'
    as _i736;
import 'package:chatix/features/search/data/repo_impl/search_repository_impl.dart'
    as _i672;
import 'package:chatix/features/search/domain/usecases/get_recent_searches_usecase.dart'
    as _i474;
import 'package:chatix/features/search/domain/usecases/remove_recent_search_usecase.dart'
    as _i361;
import 'package:chatix/features/search/domain/usecases/search_users_usecase.dart'
    as _i949;
import 'package:chatix/features/videos/data/datasources/local/videos_local_datasource.dart'
    as _i164;
import 'package:chatix/features/videos/data/repo/videos_repository.dart'
    as _i276;
import 'package:chatix/features/videos/data/repo_impl/videos_repository_impl.dart'
    as _i75;
import 'package:chatix/features/videos/domain/usecases/get_videos_usecase.dart'
    as _i262;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i2.ShareContactsLocalDataSource>(
      () => _i2.ShareContactsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i187.ReportLocalDataSource>(
      () => _i187.ReportLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i508.ProfileLocalDataSource>(
      () => _i508.ProfileLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i110.ChatListLocalDataSource>(
      () => _i110.ChatListLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i504.ChatListRepository>(
      () => _i959.ChatListRepositoryImpl(gh<_i110.ChatListLocalDataSource>()),
    );
    gh.lazySingleton<_i562.SearchLocalDataSource>(
      () => _i562.SearchLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i400.FeedLocalDataSource>(
      () => _i400.FeedLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i958.CommentsLocalDataSource>(
      () => _i958.CommentsLocalDataSourceImpl(),
    );
    gh.factory<_i816.GetChatListUseCase>(
      () => _i816.GetChatListUseCase(gh<_i504.ChatListRepository>()),
    );
    gh.lazySingleton<_i156.ShareContactsRepository>(
      () => _i260.ShareContactsRepositoryImpl(
        gh<_i2.ShareContactsLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i154.AuthRepository>(() => _i526.AuthRepositoryImpl());
    gh.lazySingleton<_i164.VideosLocalDataSource>(
      () => _i164.VideosLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i276.VideosRepository>(
      () => _i75.VideosRepositoryImpl(gh<_i164.VideosLocalDataSource>()),
    );
    gh.lazySingleton<_i321.ReportRepository>(
      () => _i519.ReportRepositoryImpl(gh<_i187.ReportLocalDataSource>()),
    );
    gh.lazySingleton<_i903.CommentsRepository>(
      () => _i6.CommentsRepositoryImpl(gh<_i958.CommentsLocalDataSource>()),
    );
    gh.lazySingleton<_i217.FeedRepository>(
      () => _i244.FeedRepositoryImpl(gh<_i400.FeedLocalDataSource>()),
    );
    gh.factory<_i262.GetVideosUseCase>(
      () => _i262.GetVideosUseCase(gh<_i276.VideosRepository>()),
    );
    gh.lazySingleton<_i129.ProfileRepository>(
      () => _i782.ProfileRepositoryImpl(gh<_i508.ProfileLocalDataSource>()),
    );
    gh.factory<_i544.SendOtpUseCase>(
      () => _i544.SendOtpUseCase(gh<_i154.AuthRepository>()),
    );
    gh.factory<_i943.VerifyOtpUseCase>(
      () => _i943.VerifyOtpUseCase(gh<_i154.AuthRepository>()),
    );
    gh.lazySingleton<_i736.SearchRepository>(
      () => _i672.SearchRepositoryImpl(gh<_i562.SearchLocalDataSource>()),
    );
    gh.factory<_i480.GetPostCommentsUseCase>(
      () => _i480.GetPostCommentsUseCase(gh<_i903.CommentsRepository>()),
    );
    gh.factory<_i397.GetProfilePhotosUseCase>(
      () => _i397.GetProfilePhotosUseCase(gh<_i129.ProfileRepository>()),
    );
    gh.factory<_i716.GetProfilePostsUseCase>(
      () => _i716.GetProfilePostsUseCase(gh<_i129.ProfileRepository>()),
    );
    gh.factory<_i653.GetProfileUseCase>(
      () => _i653.GetProfileUseCase(gh<_i129.ProfileRepository>()),
    );
    gh.factory<_i474.GetRecentSearchesUseCase>(
      () => _i474.GetRecentSearchesUseCase(gh<_i736.SearchRepository>()),
    );
    gh.factory<_i361.RemoveRecentSearchUseCase>(
      () => _i361.RemoveRecentSearchUseCase(gh<_i736.SearchRepository>()),
    );
    gh.factory<_i949.SearchUsersUseCase>(
      () => _i949.SearchUsersUseCase(gh<_i736.SearchRepository>()),
    );
    gh.factory<_i999.GetShareContactsUseCase>(
      () => _i999.GetShareContactsUseCase(gh<_i156.ShareContactsRepository>()),
    );
    gh.factory<_i146.SubmitPostReportUseCase>(
      () => _i146.SubmitPostReportUseCase(gh<_i321.ReportRepository>()),
    );
    gh.factory<_i738.GetFeedPostsUseCase>(
      () => _i738.GetFeedPostsUseCase(gh<_i217.FeedRepository>()),
    );
    gh.factory<_i802.ToggleLikePostUseCase>(
      () => _i802.ToggleLikePostUseCase(gh<_i217.FeedRepository>()),
    );
    return this;
  }
}
