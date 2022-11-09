import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_team_page_state.f.freezed.dart';

@freezed
class CreateTeamPageState with _$CreateTeamPageState {
  const factory CreateTeamPageState.idle() = CreateTeamPageStateIdle;

  const factory CreateTeamPageState.error() = CreateTeamPageStateError;
}
