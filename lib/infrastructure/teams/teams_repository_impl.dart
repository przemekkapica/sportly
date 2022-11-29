import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sportly/domain/features/teams/models/invitation_code.f.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';
import 'package:sportly/domain/features/teams/models/update_team.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';
import 'package:sportly/infrastructure/teams/data_sources/teams_data_source.dart';
import 'package:sportly/infrastructure/teams/data_sources/teams_remote_data_source.dart';
import 'package:sportly/infrastructure/teams/mappers/create_team_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/get_invitation_code_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/invitation_code_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/sport_discipline_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/team_details_from_dto_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/team_from_dto_mapper.dart';
import 'package:sportly/infrastructure/teams/mappers/update_team_mapper.dart';

@LazySingleton(as: TeamsRepository)
class TeamsRepositoryImpl implements TeamsRepository {
  TeamsRepositoryImpl(
    this._teamsRemoteDataSource,
    this._teamsDataSource,
    this._createTeamMapper,
    this._teamFromDtoMapper,
    this._teamDetailsFromDtoMapper,
    this._updateTeamMapper,
    this._sportDisciplineMapper,
    this._getInvitationCodeMapper,
    this._invitationCodeMapper,
  );

  final TeamsRemoteDataSource _teamsRemoteDataSource;
  final TeamsDataSource _teamsDataSource;
  final CreateTeamMapper _createTeamMapper;
  final TeamFromDtoMapper _teamFromDtoMapper;
  final TeamDetailsFromDtoMapper _teamDetailsFromDtoMapper;
  final UpdateTeamMapper _updateTeamMapper;
  final SportDisciplineMapper _sportDisciplineMapper;
  final GetInvitationCodeMapper _getInvitationCodeMapper;
  final InvitationCodeMapper _invitationCodeMapper;

  final BehaviorSubject<List<Team>> _teamsBroadcaster = BehaviorSubject();
  Timer? _timer;
  bool alreadyStartedCheckingTeams = false;

  @override
  Future<void> createTeam(CreateTeam createTeam) async {
    try {
      await _teamsRemoteDataSource.createTeam(_createTeamMapper(createTeam));
    } catch (e) {
      print(e);
      // TODO: add error handling
      throw (Exception('create team error'));
    }
  }

  @override
  Future<List<Team>> getTeams() async {
    try {
      final teamsDto = await _teamsRemoteDataSource.getTeams();
      return teamsDto.teams
          .map((teamDto) => _teamFromDtoMapper(teamDto))
          .toList();
    } catch (e) {
      // TODO: add error handling
      print(e);
      throw (Exception('get teams error'));
    }
  }

  @override
  Future<TeamDetails> getTeamDetails(int id) async {
    try {
      final teamDetailsDto = await _teamsRemoteDataSource.getTeamDetails(id);

      return _teamDetailsFromDtoMapper(teamDetailsDto);
    } catch (e) {
      // TODO: add error handling
      print(e);
      throw (Exception('get team details error'));
    }
  }

  @override
  Future<void> joinTeam(String code) async {
    return await _teamsRemoteDataSource.joinTeam(_invitationCodeMapper(code));
  }

  @override
  Future<void> leaveTeam(int id) async {
    return await _teamsDataSource.leaveTeam(id);
  }

  @override
  Future<void> updateTeam(int id, UpdateTeam updateTeam) async {
    return await _teamsDataSource.updateTeam(
      id,
      _updateTeamMapper(updateTeam),
    );
  }

  @override
  Future<void> updateTeamMemberRole(int teamId, String userId, Role role) {
    // TODO: implement changeMemberRole
    throw UnimplementedError();
  }

  @override
  Future<void> removeTeamMember(int teamId, String userId) {
    // TODO: implement removeTeamMember
    throw UnimplementedError();
  }

  @override
  Future<List<SportDiscipline>> getDisciplines() async {
    final disciplinesDto = await _teamsRemoteDataSource.getDisciplines();

    return disciplinesDto.disciplines
        .map((dto) => _sportDisciplineMapper.fromDto(dto))
        .toList();
  }

  @override
  Future<InvitationCode> getInvitationCode(int teamId) async {
    final dto = await _teamsRemoteDataSource.getInvitationCode(teamId);

    return _getInvitationCodeMapper(dto);
  }

  // Stream methods
  @override
  Future<void> startCheckingTeams(Duration checkingPeriod) async {
    if (alreadyStartedCheckingTeams) {
      return;
    }
    alreadyStartedCheckingTeams = true;
    _timer?.cancel();
    await fetchTeams();
    _timer = Timer.periodic(checkingPeriod, (_) => fetchTeams());
  }

  @override
  void stopCheckingTeams() {
    alreadyStartedCheckingTeams = false;
    _timer?.cancel();
  }

  @override
  Future<void> fetchTeams() async {
    try {
      final teams = await this.getTeams();

      _teamsBroadcaster.add(teams);
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<List<Team>> get teamsStream => _teamsBroadcaster.stream;

  @override
  List<Team> get currentTeams => _teamsBroadcaster.value;
}
