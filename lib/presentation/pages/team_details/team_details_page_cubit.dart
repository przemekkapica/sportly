import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/get_team_details_use_case.dart';
import 'package:sportly/presentation/pages/team_details/team_details_page_state.f.dart';

@injectable
class TeamDetailsPageCubit extends Cubit<TeamDetailsPageState> {
  TeamDetailsPageCubit(
    this._getTeamDetailsUseCase,
  ) : super(const TeamDetailsPageState.loading());

  final GetTeamDetailsUseCase _getTeamDetailsUseCase;

  Future<void> init(String teamId) async {
    try {
      final teamDetails = await _getTeamDetailsUseCase(teamId);
      print(teamDetails);
      emit(TeamDetailsPageState.idle(teamDetails: teamDetails));
    } catch (e) {
      emit(const TeamDetailsPageState.error());
    }
  }
}
