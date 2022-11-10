import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';

part 'schedule_page_state.f.freezed.dart';

@freezed
class SchedulePageState with _$SchedulePageState {
  const factory SchedulePageState.loading() = SchedulePageStateLoading;

  const factory SchedulePageState.idle({
    required List<Team> teams,
  }) = SchedulePageStateIdle;

  const factory SchedulePageState.noTeams() = SchedulePageStateNoTeams;

  const factory SchedulePageState.error() = SchedulePageStateError;
}
