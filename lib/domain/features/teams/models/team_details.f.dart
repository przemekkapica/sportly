import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team_member.f.dart';

part 'team_details.f.freezed.dart';

@freezed
class TeamDetails with _$TeamDetails {
  const factory TeamDetails({
    required String id,
    required String name,
    required int membersCount,
    required bool isAdmin,
    required SportDiscipline discipline,
    required DateTime joinedDate,
    required List<TeamMember> members,
  }) = _TeamDetails;
}
