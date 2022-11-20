import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team_member.f.dart';
import 'package:sportly/domain/use_cases/get_team_details_use_case.dart';
import 'package:sportly/domain/use_cases/leave_team_use_case.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page_state.f.dart';

@injectable
class TeamDetailsPageCubit extends Cubit<TeamDetailsPageState> {
  TeamDetailsPageCubit(
    this._getTeamDetailsUseCase,
    this._leaveTeamUseCase,
  ) : super(const TeamDetailsPageState.loading());

  final GetTeamDetailsUseCase _getTeamDetailsUseCase;
  final LeaveTeamUseCase _leaveTeamUseCase;

  Future<void> init(String teamId) async {
    try {
      final teamDetails = await _getTeamDetailsUseCase(teamId);
      var members = List<TeamMember>.from(teamDetails.members);

      members.sort((m1, m2) => m2.isAdmin ? 1 : -1);

      emit(
        TeamDetailsPageState.idle(
          teamDetails: teamDetails.copyWith(members: members),
        ),
      );
    } catch (e) {
      emit(const TeamDetailsPageState.error());
    }
  }

  Future<void> leaveTeam(String id) async {
    return await this._leaveTeamUseCase(id);
  }
}
