import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';
import 'package:sportly/infrastructure/teams/data_sources/teams_data_source.dart';
import 'package:sportly/infrastructure/teams/mappers/create_team_from_dto_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/team_from_dto_mapper.dart';

@LazySingleton(as: TeamsRepository)
class TeamsRepositoryImpl implements TeamsRepository {
  TeamsRepositoryImpl(
    this._teamsDataSource,
    this._createTeamMapper,
    this._teamFromDtoMapper,
  );

  final TeamsDataSource _teamsDataSource;
  final CreateTeamMapper _createTeamMapper;
  final TeamFromDtoMapper _teamFromDtoMapper;

  @override
  Future<void> createTeam(CreateTeam createTeam) async {
    try {
      await _teamsDataSource.createTeam(_createTeamMapper.toDto(createTeam));
    } catch (e) {
      // TODO: add error handling
      throw (Exception('create team error'));
    }
  }

  @override
  Future<List<Team>> getTeams() async {
    try {
      final teamsDto = await _teamsDataSource.getTeams();

      return teamsDto.teams
          .map((teamDto) => _teamFromDtoMapper(teamDto))
          .toList();
    } catch (e) {
      // TODO: add error handling
      throw (Exception('get teams error'));
    }
  }
}
