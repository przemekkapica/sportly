import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/fetch_teams_use_case.dart';
import 'package:sportly/domain/use_cases/join_team_use_case.dart';
import 'package:sportly/presentation/pages/join_team/join_team_page_action.f.dart';
import 'package:sportly/presentation/pages/join_team/join_team_page_state.f.dart';

@injectable
class JoinTeamPageCubit
    extends ActionCubit<JoinTeamPageState, JoinTeamPageAction> {
  JoinTeamPageCubit(
    this._joinTeamUseCase,
    this._fetchTeamsUseCase,
  ) : super(const JoinTeamPageState.loading());

  final JoinTeamUseCase _joinTeamUseCase;
  final FetchTeamsUseCase _fetchTeamsUseCase;

  bool _canSubmit = false;
  String _code = '';

  void init() {
    _emitIdle();
  }

  void onChanged(String code) {
    if (code.length != 6) {
      _canSubmit = false;
    } else {
      _canSubmit = true;
    }
    _code = code;
    _emitIdle();
  }

  void _emitIdle() {
    emit(
      JoinTeamPageState.idle(
        canSubmit: _canSubmit,
        code: _code,
      ),
    );
  }

  void submit() async {
    try {
      dispatch(const JoinTeamPageAction.showLoader());

      await _joinTeamUseCase(_code);
      dispatch(const JoinTeamPageAction.addedToTeam());
      _fetchTeamsUseCase();
    } catch (e) {
      dispatch(const JoinTeamPageAction.wrongCode());
      // emit(const JoinTeamPageState.loading());
    } finally {
      dispatch(const JoinTeamPageAction.hideLoader());
    }
  }
}
