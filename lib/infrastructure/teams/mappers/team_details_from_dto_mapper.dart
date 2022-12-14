import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/infrastructure/teams/dtos/team_details_dto.dart';
import 'package:sportly/infrastructure/teams/mappers/sport_discipline_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/team_member_mapper.dart';

@injectable
class TeamDetailsFromDtoMapper extends DataMapper<TeamDetailsDto, TeamDetails> {
  TeamDetailsFromDtoMapper(
    this._sportDisciplineMapper,
    this._teamMemberMapper,
  );

  final SportDisciplineMapper _sportDisciplineMapper;
  final TeamMemberMapper _teamMemberMapper;

  @override
  TeamDetails call(TeamDetailsDto data) {
    return TeamDetails(
      id: data.id,
      name: data.name,
      type: teamTypeFromString(data.teamType),
      membersCount: data.membersCount,
      role: roleFromString(data.role),
      discipline: _sportDisciplineMapper.fromDto(data.discipline),
      joinedDate: DateTime.parse(data.joinedDate),
      location: data.location,
      organizationName: data.organizationName,
      members: data.members
          .map((member) => _teamMemberMapper.fromDto(member))
          .toList(),
    );
  }
}
