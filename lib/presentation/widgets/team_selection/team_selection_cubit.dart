import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/get_teams_use_case.dart';
import 'package:sportly/domain/use_cases/leave_team_use_case.dart';
import 'package:sportly/presentation/widgets/team_selection/team_selection_state.f.dart';

@injectable
class TeamSelectionCubit extends Cubit<TeamSelectionState> {
  TeamSelectionCubit(
    this._getTeamsUseCase,
    this._leaveTeamUseCase,
  ) : super(const TeamSelectionState.loading());

  final GetTeamsUseCase _getTeamsUseCase;
  final LeaveTeamUseCase _leaveTeamUseCase;

  Future<void> init() async {
    try {
      var teams = await _getTeamsUseCase();

      // teams = []; // TODO: temp
      if (teams.isEmpty) {
        emit(const TeamSelectionState.noTeams());
      } else {
        emit(TeamSelectionState.idle(teams: teams));
      }
    } catch (e) {
      emit(const TeamSelectionState.error());
    }
  }

  Future<void> leaveTeam(String id) async {
    return await this._leaveTeamUseCase(id);
  }
}
