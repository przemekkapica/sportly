import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_team_page_action.f.freezed.dart';

@freezed
class JoinTeamPageAction with _$JoinTeamPageAction {
  const factory JoinTeamPageAction.alreadyInTeam() = _AlreadyInTeam;

  const factory JoinTeamPageAction.addedToTeam() = _AddedToTeam;

  const factory JoinTeamPageAction.wrongCode() = _WrongCode;
}
