import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';

part 'team_selection_state.f.freezed.dart';

@freezed
class TeamSelectionState with _$TeamSelectionState {
  const factory TeamSelectionState.loading() = TeamSelectionStateLoading;

  const factory TeamSelectionState.idle({
    required List<Team> teams,
  }) = TeamSelectionStateIdle;

  const factory TeamSelectionState.noTeams() = TeamSelectionStateNoTeams;

  const factory TeamSelectionState.error() = TeamSelectionStateError;
}
