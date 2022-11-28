import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';

part 'team.f.freezed.dart';

@freezed
class Team with _$Team {
  const factory Team({
    required int id,
    required String name,
    required TeamType type,
    required int membersCount,
    required Role role,
    required SportDiscipline discipline,
  }) = _Team;

  factory Team.fromDetails(TeamDetails details) {
    return Team(
      id: details.id,
      name: details.name,
      type: details.type,
      membersCount: details.membersCount,
      role: details.role,
      discipline: details.discipline,
    );
  }
}
