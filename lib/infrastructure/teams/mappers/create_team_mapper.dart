import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/infrastructure/teams/dtos/create_team_dto.dart';
import 'package:sportly/infrastructure/teams/mappers/age_group_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/sport_discipline_mapper.dart';

@injectable
class CreateTeamMapper
    extends BidirectionalDataMapper<CreateTeamDto, CreateTeam> {
  CreateTeamMapper(
    this._ageGroupMapper,
    this._sportDisciplineMapper,
  );

  final AgeGroupMapper _ageGroupMapper;
  final SportDisciplineMapper _sportDisciplineMapper;

  @override
  CreateTeam fromDto(CreateTeamDto dto) {
    return CreateTeam(
      name: dto.name,
      discipline: _sportDisciplineMapper.fromDto(dto.discipline),
      location: dto.location,
      ageGroup: _ageGroupMapper.fromDto(dto.ageGroup),
      organizationName: dto.organizationName,
    );
  }

  @override
  CreateTeamDto toDto(CreateTeam data) {
    return CreateTeamDto(
      name: data.name,
      discipline: _sportDisciplineMapper.toDto(data.discipline),
      location: data.location,
      ageGroup: _ageGroupMapper.toDto(data.ageGroup),
      organizationName: data.organizationName,
    );
  }
}
