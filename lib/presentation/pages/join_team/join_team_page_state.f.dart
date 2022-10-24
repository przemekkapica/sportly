import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_team_page_state.f.freezed.dart';

@freezed
class JoinTeamPageState with _$JoinTeamPageState {
  const factory JoinTeamPageState.idle({
    required bool canSubmit,
    required String code,
  }) = JoinTeamPageStateIdle;

  const factory JoinTeamPageState.loading() = JoinTeamPageStateLoading;
}
