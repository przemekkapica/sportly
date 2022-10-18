import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sportly/infrastructure/teams/data_sources/teams_data_source.dart';
import 'package:sportly/infrastructure/teams/dtos/create_team_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/get_teams_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/team_dto.dart';

@LazySingleton(as: TeamsDataSource)
class TeamsMockDataSource implements TeamsDataSource {
  @override
  Future<void> createTeam(CreateTeamDto createTeamDto) async {
    // TODO: implement createTeam
  }

  @override
  Future<GetTeamsDto> getTeams() async {
    final contents =
        await rootBundle.loadString('assets/mocks/teams/teams.json');

    final data = jsonDecode(contents);

    final teams = GetTeamsDto.fromJson(data);

    return teams;
  }
}
