import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_action.f.freezed.dart';

@freezed
class AppAction with _$AppAction {
  const factory AppAction.offline() = AppActionOffline;

  const factory AppAction.online() = AppActionOnline;
}
