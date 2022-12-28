import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/use_cases/get_selected_team_stream_use_case.dart';
import 'package:sportly/presentation/pages/home/home_page_state.f.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this._getSelectedTeamStreamUseCase,
  ) : super(const HomePageState.idle(selectedTeam: null)) {
    selectedTeamSubscription = _getSelectedTeamStreamUseCase()
        .distinct()
        .listen(_onSelectedTeamChange);
  }

  final GetSelectedTeamStreamUseCase _getSelectedTeamStreamUseCase;
  late StreamSubscription selectedTeamSubscription;

  void _onSelectedTeamChange(Team team) {
    emit(HomePageState.idle(selectedTeam: team));
  }
}
