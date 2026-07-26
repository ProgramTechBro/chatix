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
import 'package:chatix/features/home/data/datasources/local/comments_local_datasource.dart'
    as _i958;
import 'package:chatix/features/home/data/datasources/local/feed_local_datasource.dart'
    as _i400;
import 'package:chatix/features/home/data/datasources/local/share_contacts_local_datasource.dart'
    as _i2;
import 'package:chatix/features/home/data/repo/comments_repository.dart'
    as _i903;
import 'package:chatix/features/home/data/repo/feed_repository.dart' as _i217;
import 'package:chatix/features/home/data/repo/share_contacts_repository.dart'
    as _i156;
import 'package:chatix/features/home/data/repo_impl/comments_repository_impl.dart'
    as _i6;
import 'package:chatix/features/home/data/repo_impl/feed_repository_impl.dart'
    as _i244;
import 'package:chatix/features/home/data/repo_impl/share_contacts_repository_impl.dart'
    as _i260;
import 'package:chatix/features/home/domain/usecases/get_feed_posts_usecase.dart'
    as _i738;
import 'package:chatix/features/home/domain/usecases/get_post_comments_usecase.dart'
    as _i480;
import 'package:chatix/features/home/domain/usecases/get_share_contacts_usecase.dart'
    as _i999;
import 'package:chatix/features/home/domain/usecases/toggle_like_post_usecase.dart'
    as _i802;
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
    gh.lazySingleton<_i400.FeedLocalDataSource>(
      () => _i400.FeedLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i958.CommentsLocalDataSource>(
      () => _i958.CommentsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i156.ShareContactsRepository>(
      () => _i260.ShareContactsRepositoryImpl(
        gh<_i2.ShareContactsLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i154.AuthRepository>(() => _i526.AuthRepositoryImpl());
    gh.lazySingleton<_i903.CommentsRepository>(
      () => _i6.CommentsRepositoryImpl(gh<_i958.CommentsLocalDataSource>()),
    );
    gh.lazySingleton<_i217.FeedRepository>(
      () => _i244.FeedRepositoryImpl(gh<_i400.FeedLocalDataSource>()),
    );
    gh.factory<_i544.SendOtpUseCase>(
      () => _i544.SendOtpUseCase(gh<_i154.AuthRepository>()),
    );
    gh.factory<_i943.VerifyOtpUseCase>(
      () => _i943.VerifyOtpUseCase(gh<_i154.AuthRepository>()),
    );
    gh.factory<_i480.GetPostCommentsUseCase>(
      () => _i480.GetPostCommentsUseCase(gh<_i903.CommentsRepository>()),
    );
    gh.factory<_i999.GetShareContactsUseCase>(
      () => _i999.GetShareContactsUseCase(gh<_i156.ShareContactsRepository>()),
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
