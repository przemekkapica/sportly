import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/infrastructure/teams/dtos/create_team_dto.dart';
import 'package:sportly/infrastructure/teams/mappers/sport_discipline_mapper.dart';

@injectable
class CreateTeamMapper extends DataMapper<CreateTeam, CreateTeamDto> {
  CreateTeamMapper(
    this._sportDisciplineMapper,
  );

  final SportDisciplineMapper _sportDisciplineMapper;

  @override
  CreateTeamDto call(CreateTeam data) {
    return CreateTeamDto(
      name: data.name,
      discipline: _sportDisciplineMapper.toDto(data.discipline),
      location: data.location,
      teamType: data.teamType.value,
      organizationName: data.organizationName,
    );
  }
}
