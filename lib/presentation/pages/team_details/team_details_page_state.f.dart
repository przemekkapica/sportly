import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';

part 'team_details_page_state.f.freezed.dart';

@freezed
class TeamDetailsPageState with _$TeamDetailsPageState {
  const factory TeamDetailsPageState.loading() = TeamDetailsPageStateLoading;

  const factory TeamDetailsPageState.idle({
    required TeamDetails teamDetails,
  }) = TeamDetailsPageStateIdle;

  const factory TeamDetailsPageState.error() = TeamDetailsPageStateError;
}
