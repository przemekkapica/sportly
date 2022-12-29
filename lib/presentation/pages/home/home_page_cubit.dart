import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/use_cases/get_selected_chat_team_stream_use_case.dart';
import 'package:sportly/domain/use_cases/get_selected_schedule_team_stream_use_case.dart';
import 'package:sportly/presentation/pages/home/home_page_state.f.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this._getSelectedChatTeamStreamUseCase,
    this._getSelectedScheduleTeamStreamUseCase,
  ) : super(
          const HomePageState.idle(
            selectedChatTeam: null,
            selectedScheduleTeam: null,
          ),
        ) {
    selectedChatTeamSubscription = _getSelectedChatTeamStreamUseCase()
        .distinct()
        .listen(_onSelectedChatTeamChange);
    selectedScheduleTeamSubscription = _getSelectedScheduleTeamStreamUseCase()
        .distinct()
        .listen(_onSelectedScheduleTeamChange);
  }

  final GetSelectedChatTeamStreamUseCase _getSelectedChatTeamStreamUseCase;
  final GetSelectedScheduleTeamStreamUseCase
      _getSelectedScheduleTeamStreamUseCase;

  late StreamSubscription selectedChatTeamSubscription;
  late StreamSubscription selectedScheduleTeamSubscription;

  Team? _lastSelectedChatTeam;
  Team? _lastSelectedScheduleTeam;

  void _onSelectedChatTeamChange(Team team) {
    emit(
      HomePageState.idle(
        selectedChatTeam: team,
        selectedScheduleTeam: _lastSelectedScheduleTeam,
      ),
    );
    _lastSelectedChatTeam = team;
  }

  void _onSelectedScheduleTeamChange(Team team) {
    emit(
      HomePageState.idle(
        selectedChatTeam: _lastSelectedChatTeam,
        selectedScheduleTeam: team,
      ),
    );
    _lastSelectedScheduleTeam = team;
  }
}
