import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.f.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.idle() = AppStateIdle;
}
