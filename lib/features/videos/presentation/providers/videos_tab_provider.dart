import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/enums/videos_tab.dart';

part 'videos_tab_provider.g.dart';

@riverpod
class VideosTabSelection extends _$VideosTabSelection {
  @override
  VideosTab build() => VideosTab.forYou;

  void select(VideosTab tab) => state = tab;
}
