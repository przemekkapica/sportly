import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';

part 'teams_page_state.f.freezed.dart';

@freezed
class TeamsPageState with _$TeamsPageState {
  const factory TeamsPageState.loading() = TeamsPageStateLoading;

  const factory TeamsPageState.idle({
    required List<Team> teams,
  }) = TeamsPageStateIdle;

  const factory TeamsPageState.noTeams() = TeamsPageStateNoTeams;

  const factory TeamsPageState.error() = TeamsPageStateError;
}
