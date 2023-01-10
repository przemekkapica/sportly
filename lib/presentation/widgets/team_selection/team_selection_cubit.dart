import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/use_cases/delete_team_use_case.dart';
import 'package:sportly/domain/use_cases/fetch_teams_use_case.dart';
import 'package:sportly/domain/use_cases/get_teams_stream_use_case.dart';
import 'package:sportly/domain/use_cases/get_teams_use_case.dart';
import 'package:sportly/domain/use_cases/leave_team_use_case.dart';
import 'package:sportly/domain/use_cases/start_checking_get_teams_use_case.dart';
import 'package:sportly/domain/use_cases/stop_checking_get_teams_use_case.dart';
import 'package:sportly/domain/use_cases/update_selected_chat_team_use_case.dart';
import 'package:sportly/domain/use_cases/update_selected_schedule_team_use_case.dart';
import 'package:sportly/presentation/widgets/team_selection/team_selection_state.f.dart';

@injectable
class TeamSelectionCubit extends Cubit<TeamSelectionState> {
  TeamSelectionCubit(
    this._getTeamsUseCase,
    this._leaveTeamUseCase,
    this._getTeamsStreamUseCase,
    this._startCheckingGetTeams,
    this._stopCheckingGetTeamsUseCase,
    this._deleteTeamUseCase,
    this._fetchTeamsUseCase,
    this._updateSelectedChatTeamUseCase,
    this._updateSelectedScheduleTeamUseCase,
  ) : super(const TeamSelectionState.loading()) {
    _getTeamsSubscription =
        _getTeamsStreamUseCase().distinct().listen(_onGetTeamsChanged);
  }

  final GetTeamsUseCase _getTeamsUseCase;
  final LeaveTeamUseCase _leaveTeamUseCase;
  final StartCheckingGetTeamsUseCase _startCheckingGetTeams;
  final StopCheckingGetTeamsUseCase _stopCheckingGetTeamsUseCase;
  final GetTeamsStreamUseCase _getTeamsStreamUseCase;
  final DeleteTeamUseCase _deleteTeamUseCase;
  final FetchTeamsUseCase _fetchTeamsUseCase;
  final UpdateSelectedChatTeamUseCase _updateSelectedChatTeamUseCase;
  final UpdateSelectedScheduleTeamUseCase _updateSelectedScheduleTeamUseCase;

  late final StreamSubscription _getTeamsSubscription;

  Future<void> init() async {
    try {
      _startCheckingGetTeams();

      var teams = await _getTeamsUseCase();

      _emitIdle(teams);
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      emit(const TeamSelectionState.error());
    }
  }

  Future<void> leaveTeam(int id) async {
    await this._leaveTeamUseCase(id);
    _fetchTeamsUseCase();
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

  Future<void> deleteTeam(int teamId) async {
    try {
      await _deleteTeamUseCase(teamId);
      _fetchTeamsUseCase();
    } catch (e) {
      log(e.toString());
      emit(const TeamSelectionState.error());
    }
  }

  void _emitIdle(List<Team> teams) {
    if (teams.isEmpty) {
      emit(const TeamSelectionState.noTeams());
    } else {
      emit(TeamSelectionState.idle(teams: teams));
    }
  }

  void updateSelectedChatTeam(Team team) {
    this._updateSelectedChatTeamUseCase(team);
  }

  void updateSelectedScheduleTeam(Team team) {
    this._updateSelectedScheduleTeamUseCase(team);
  }

  @override
  Future<void> close() {
    _getTeamsSubscription.cancel();
    _stopCheckingGetTeamsUseCase();
    return super.close();
  }
}
