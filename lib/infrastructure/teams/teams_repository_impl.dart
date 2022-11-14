import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';
import 'package:sportly/infrastructure/teams/data_sources/teams_data_source.dart';
import 'package:sportly/infrastructure/teams/data_sources/teams_remote_data_source.dart';
import 'package:sportly/infrastructure/teams/mappers/create_team_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/team_details_from_dto_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/team_from_dto_mapper.dart';

@LazySingleton(as: TeamsRepository)
class TeamsRepositoryImpl implements TeamsRepository {
  TeamsRepositoryImpl(
    this._teamsRemoteDataSource,
    this._teamsDataSource,
    this._createTeamMapper,
    this._teamFromDtoMapper,
    this._teamDetailsFromDtoMapper,
  );

  final TeamsRemoteDataSource _teamsRemoteDataSource;
  final TeamsDataSource _teamsDataSource;
  final CreateTeamMapper _createTeamMapper;
  final TeamFromDtoMapper _teamFromDtoMapper;
  final TeamDetailsFromDtoMapper _teamDetailsFromDtoMapper;

  @override
  Future<void> createTeam(CreateTeam createTeam) async {
    try {
      await _teamsDataSource.createTeam(_createTeamMapper(createTeam));
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

  @override
  Future<TeamDetails> getTeamDetails(String id) async {
    try {
      final teamDetailsDto = await _teamsDataSource.getTeamDetails(id);

      return _teamDetailsFromDtoMapper(teamDetailsDto);
    } catch (e) {
      // TODO: add error handling
      throw (Exception('get team details error'));
    }
  }

  @override
  Future<bool> joinTeam(String code) async {
    try {
      return await _teamsDataSource.joinTeam(code);
    } catch (e) {
      // TODO: add error handling
      return false;
    }
    return false;
  }

  @override
  Future<void> leaveTeam(String id) async {
    return await _teamsDataSource.leaveTeam(id);
  }
}
