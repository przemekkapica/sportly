import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/get_teams_use_case.dart';
import 'package:sportly/presentation/pages/teams/teams_page_state.f.dart';

@injectable
class TeamsPageCubit extends Cubit<TeamsPageState> {
  TeamsPageCubit(
    this._getTeamsUseCase,
  ) : super(const TeamsPageState.loading());

  final GetTeamsUseCase _getTeamsUseCase;

  Future<void> init() async {
    try {
      var teams = await _getTeamsUseCase();

      teams = []; // TODO: temp
      if (teams.isEmpty) {
        emit(const TeamsPageState.noTeams());
      } else {
        emit(TeamsPageState.idle(teams: teams));
      }
    } catch (e) {
      emit(const TeamsPageState.error());
    }
  }
}
