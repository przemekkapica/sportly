import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';

part 'create_team_page_state.f.freezed.dart';

@freezed
class CreateTeamPageState with _$CreateTeamPageState {
  const factory CreateTeamPageState.loading() = CreateTeamPageStateLoading;

  const factory CreateTeamPageState.idle({
    required List<SportDiscipline> disciplines,
    required bool submitButtonEnabled,
  }) = CreateTeamPageStateIdle;

  const factory CreateTeamPageState.error() = CreateTeamPageStateError;
}
