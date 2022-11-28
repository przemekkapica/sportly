import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/domain/features/teams/models/update_team.f.dart';
import 'package:sportly/domain/use_cases/get_team_details_use_case.dart';
import 'package:sportly/domain/use_cases/remove_team_member_use_case.dart';
import 'package:sportly/domain/use_cases/update_team_member_role.dart';
import 'package:sportly/domain/use_cases/update_team_use_case.dart';
import 'package:sportly/presentation/pages/team_management/team_management_page_action.f.dart';
import 'package:sportly/presentation/pages/team_management/team_management_page_state.f.dart';
import 'package:sportly/utils/extensions/string_extension.dart';

@injectable
class TeamManagementPageCubit
    extends ActionCubit<TeamManagementPageState, TeamManagementPageAction> {
  TeamManagementPageCubit(
    this._updateTeamUseCase,
    this._getTeamDetailsUseCase,
    this._updateTeamMemberRoleUseCase,
    this._removeTeamMemberUseCase,
  ) : super(const TeamManagementPageState.loading());

  final UpdateTeamUseCase _updateTeamUseCase;
  final GetTeamDetailsUseCase _getTeamDetailsUseCase;
  final UpdateTeamMemberRoleUseCase _updateTeamMemberRoleUseCase;
  final RemoveTeamMemberUseCase _removeTeamMemberUseCase;

  late final int _teamId;
  late final TeamDetails _teamDetails;

  String? _teamName;
  SportDiscipline? _sportDiscipline;
  String? _location;
  String? _organizationName;
  TeamType? _teamType = TeamType.professional;
  bool _submitButtonEnabled = false;

  Future<void> init(int teamId) async {
    _teamId = teamId;
    try {
      _teamDetails = await _getTeamDetailsUseCase(_teamId);

      _teamName = _teamDetails.name;
      _sportDiscipline = _teamDetails.discipline;
      _location = _teamDetails.location;
      _organizationName = _teamDetails.organizationName;

      emit(
        TeamManagementPageState.idle(
          teamDetails: _teamDetails,
          submitButtonEnabled: false,
        ),
      );
    } catch (e) {
      emit(const TeamManagementPageState.error());
    }
  }

  onTeamNameChanged(String? value) {
    _teamName = value;
    _checkIfButtonEnabledAndEmit();
  }

  onLocationChanged(String? value) {
    _location = value;
    _checkIfButtonEnabledAndEmit();
  }

  onOrganizationNameChanged(String? value) {
    _organizationName = value;
    _checkIfButtonEnabledAndEmit();
  }

  void _checkIfButtonEnabledAndEmit() {
    if (_teamName.nullOrEmpty) {
      _submitButtonEnabled = false;
    } else {
      _submitButtonEnabled = true;
    }
    emit(
      TeamManagementPageState.idle(
        teamDetails: _teamDetails.copyWith(
          name: _teamName ?? '',
          location: _location,
          organizationName: _organizationName,
        ),
        submitButtonEnabled: _submitButtonEnabled,
      ),
    );
  }

  Future<void> submit() async {
    dispatch(const TeamManagementPageAction.showLoader());
    if (_teamName != null &&
        _teamType != null &&
        _location != null &&
        _sportDiscipline != null) {
      try {
        await _updateTeamUseCase(
          _teamId,
          UpdateTeam(
            name: _teamName!,
            location: _location!,
            organizationName: _organizationName,
          ),
        );
        dispatch(const TeamManagementPageAction.success());
      } catch (e) {
        emit(const TeamManagementPageState.error());
      } finally {
        dispatch(const TeamManagementPageAction.hideLoader());
      }
    }
  }
}
