import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/use_cases/get_teams_stream_use_case.dart';
import 'package:sportly/domain/use_cases/get_teams_use_case.dart';
import 'package:sportly/domain/use_cases/leave_team_use_case.dart';
import 'package:sportly/domain/use_cases/start_checking_get_teams_use_case.dart';
import 'package:sportly/domain/use_cases/stop_checking_get_teams_use_case.dart';
import 'package:sportly/presentation/widgets/team_selection/team_selection_state.f.dart';

@injectable
class TeamSelectionCubit extends Cubit<TeamSelectionState> {
  TeamSelectionCubit(
    this._getTeamsUseCase,
    this._leaveTeamUseCase,
    this._getTeamsStreamUseCase,
    this._startCheckingGetTeams,
    this._stopCheckingGetTeamsUseCase,
  ) : super(const TeamSelectionState.loading()) {
    _getTeamsSubscription = _getTeamsStreamUseCase().listen(_onGetTeamsChanged);
  }

  final GetTeamsUseCase _getTeamsUseCase;
  final LeaveTeamUseCase _leaveTeamUseCase;
  final StartCheckingGetTeamsUseCase _startCheckingGetTeams;
  final StopCheckingGetTeamsUseCase _stopCheckingGetTeamsUseCase;
  final GetTeamsStreamUseCase _getTeamsStreamUseCase;

  late final StreamSubscription _getTeamsSubscription;

  Future<void> init() async {
    _startCheckingGetTeams();

    try {
      var teams = await _getTeamsUseCase();

      _emitIdle(teams);
    } catch (e) {
      emit(const TeamSelectionState.error());
    }
  }

  Future<void> leaveTeam(int id) async {
    return await this._leaveTeamUseCase(id);
  }

  void _onGetTeamsChanged(List<Team> teams) {
    _emitIdle(teams);
  }

  void startCheckingGetTeams() {
    _startCheckingGetTeams();
  }

  void stopCheckingGetTeams() {
    _stopCheckingGetTeamsUseCase();
  }

  void _emitIdle(List<Team> teams) {
    if (teams.isEmpty) {
      emit(const TeamSelectionState.noTeams());
    } else {
      emit(TeamSelectionState.idle(teams: teams));
    }
  }

  @override
  Future<void> close() {
    _getTeamsSubscription.cancel();
    _stopCheckingGetTeamsUseCase();
    return super.close();
  }
}
