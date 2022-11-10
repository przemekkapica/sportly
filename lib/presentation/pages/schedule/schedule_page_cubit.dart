import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/get_teams_use_case.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page_state.f.dart';

@injectable
class SchedulePageCubit extends Cubit<SchedulePageState> {
  SchedulePageCubit(
    this._getTeamsUseCase,
  ) : super(const SchedulePageState.loading());

  final GetTeamsUseCase _getTeamsUseCase;

  Future<void> init() async {
    try {
      var teams = await _getTeamsUseCase();

      teams = []; // TODO: temp
      if (teams.isEmpty) {
        emit(const SchedulePageState.noTeams());
      } else {
        emit(SchedulePageState.idle(teams: teams));
      }
    } catch (e) {
      emit(const SchedulePageState.error());
    }
  }
}
