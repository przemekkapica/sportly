import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/models/team_member.f.dart';
import 'package:sportly/domain/use_cases/fetch_teams_use_case.dart';
import 'package:sportly/domain/use_cases/get_team_details_use_case.dart';
import 'package:sportly/domain/use_cases/leave_team_use_case.dart';
import 'package:sportly/domain/use_cases/update_selected_chat_team_use_case.dart';
import 'package:sportly/domain/use_cases/update_selected_schedule_team_use_case.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page_state.f.dart';

@injectable
class TeamDetailsPageCubit extends Cubit<TeamDetailsPageState> {
  TeamDetailsPageCubit(
    this._getTeamDetailsUseCase,
    this._leaveTeamUseCase,
    this._fetchTeamsUseCase,
    this._updateSelectedChatTeamUseCase,
    this._updateSelectedScheduleTeamUseCase,
  ) : super(const TeamDetailsPageState.loading());

  final GetTeamDetailsUseCase _getTeamDetailsUseCase;
  final LeaveTeamUseCase _leaveTeamUseCase;
  final FetchTeamsUseCase _fetchTeamsUseCase;
  final UpdateSelectedChatTeamUseCase _updateSelectedChatTeamUseCase;
  final UpdateSelectedScheduleTeamUseCase _updateSelectedScheduleTeamUseCase;

  Future<void> init(int teamId) async {
    try {
      final teamDetails = await _getTeamDetailsUseCase(teamId);
      var members = List<TeamMember>.from(teamDetails.members);

      members.sort((m1, m2) => m2.role.isAdmin ? 1 : -1);

      emit(
        TeamDetailsPageState.idle(
          teamDetails: teamDetails.copyWith(members: members),
        ),
      );
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      emit(const TeamDetailsPageState.error());
    }
  }

  Future<void> leaveTeam(int id) async {
    await this._leaveTeamUseCase(id);
    _fetchTeamsUseCase();
  }

  void updateSelectedChatTeam(Team team) {
    _updateSelectedChatTeamUseCase(team);
  }

  void updateSelectedScheduleTeam(Team team) {
    _updateSelectedScheduleTeamUseCase(team);
  }
}
