import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/domain/use_cases/create_team_use_case.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page_action.f.dart';
import 'package:sportly/presentation/pages/create_team/create_team_page_state.f.dart';

@injectable
class CreateTeamPageCubit
    extends ActionCubit<CreateTeamPageState, CreateTeamPageAction> {
  CreateTeamPageCubit(
    this._createTeamUseCase,
  ) : super(const CreateTeamPageState.idle());

  final CreateTeamUseCase _createTeamUseCase;

  String? _teamName;
  SportDiscipline? _sportDiscipline;
  String? _location;
  String? _organizationName;
  TeamType? _teamType = TeamType.professional;

  onTeamNameChanged(String? value) {
    _teamName = value;
  }

  onSportDisciplineChanged(SportDiscipline? value) {
    _sportDiscipline = value;
  }

  onLocationChanged(String? value) {
    _location = value;
  }

  onOrganizationNameChanged(String? value) {
    _organizationName = value;
  }

  onTeamTypeChanged(TeamType? value) {
    _teamType = value;
  }

  Future<void> submit() async {
    dispatch(const CreateTeamPageAction.showLoader());
    if (_teamName != null &&
        _teamType != null &&
        _location != null &&
        _sportDiscipline != null) {
      try {
        await _createTeamUseCase(
          CreateTeam(
            discipline: _sportDiscipline!,
            location: _location!,
            name: _teamName!,
            organizationName: _organizationName,
            teamType: _teamType!,
          ),
        );
        dispatch(const CreateTeamPageAction.success());
      } catch (e) {
        emit(const CreateTeamPageState.error());
      } finally {
        dispatch(const CreateTeamPageAction.hideLoader());
      }
    }
  }
}
