import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class GetTeamsUseCase {
  GetTeamsUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<List<Team>> call() async {
    return await _teamsRepository.getTeams();
  }
}
