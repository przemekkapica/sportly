import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';

part 'team_management_page_state.f.freezed.dart';

@freezed
class TeamManagementPageState with _$TeamManagementPageState {
  const factory TeamManagementPageState.loading() =
      TeamManagementPageStateLoading;

  const factory TeamManagementPageState.idle({
    required TeamDetails teamDetails,
    required bool submitButtonEnabled,
  }) = TeamManagementPageStateIdle;

  const factory TeamManagementPageState.error() = TeamManagementPageStateError;
}
