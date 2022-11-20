import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/infrastructure/teams/dtos/team_dto.dart';
import 'package:sportly/infrastructure/teams/mappers/sport_discipline_mapper.dart';

@injectable
class TeamFromDtoMapper extends DataMapper<TeamDto, Team> {
  TeamFromDtoMapper(this._sportDisciplineMapper);

  final SportDisciplineMapper _sportDisciplineMapper;

  @override
  Team call(TeamDto data) {
    return Team(
      id: data.id,
      name: data.name,
      type: teamTypeFromString(data.teamType),
      isAdmin: data.isAdmin,
      membersCount: data.membersCount,
      discipline: _sportDisciplineMapper.fromDto(data.discipline),
    );
  }
}
