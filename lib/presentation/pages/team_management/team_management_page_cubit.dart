import 'dart:developer';

import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';
import 'package:sportly/domain/features/teams/models/update_team.f.dart';
import 'package:sportly/domain/use_cases/fetch_teams_use_case.dart';
import 'package:sportly/domain/use_cases/get_team_details_use_case.dart';
import 'package:sportly/domain/use_cases/remove_team_member_use_case.dart';
import 'package:sportly/domain/use_cases/change_team_member_role_use_case.dart';
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
    this._changeTeamMemberRoleUseCase,
    this._removeTeamMemberUseCase,
    this._fetchTeamsUseCase,
  ) : super(const TeamManagementPageState.loading());

  final UpdateTeamUseCase _updateTeamUseCase;
  final GetTeamDetailsUseCase _getTeamDetailsUseCase;
  final ChangeTeamMemberRoleUseCase _changeTeamMemberRoleUseCase;
  final RemoveTeamMemberUseCase _removeTeamMemberUseCase;
  final FetchTeamsUseCase _fetchTeamsUseCase;

  late final int _teamId;
  late TeamDetails _teamDetails;

  String? _teamName;
  String? _location;
  String? _organizationName;
  bool _submitButtonEnabled = false;

  Future<void> init(int teamId) async {
    _teamId = teamId;
    try {
      _teamDetails = await _getTeamDetailsUseCase(_teamId);

      _teamName = _teamDetails.name;
      _location = _teamDetails.location;
      _organizationName = _teamDetails.organizationName;

      _emitIdle();
    } catch (e) {
      emit(const TeamManagementPageState.error());
    }
  }

  void _emitIdle() {
    emit(
      TeamManagementPageState.idle(
        teamDetails: _teamDetails,
        submitButtonEnabled: _submitButtonEnabled,
      ),
    );
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
    if (!_teamName.nullOrEmpty) {
      dispatch(const TeamManagementPageAction.showLoader());
      try {
        await _updateTeamUseCase(
          _teamId,
          UpdateTeam(
            name: _teamName!,
            location: _location,
            organizationName: _organizationName,
          ),
        );
        _teamDetails = await _getTeamDetailsUseCase(_teamId);
        dispatch(const TeamManagementPageAction.success(popPage: true));
        _fetchTeamsUseCase();
      } catch (e) {
        log(e.toString());
        emit(const TeamManagementPageState.error());
      }
      dispatch(const TeamManagementPageAction.hideLoader());
    }
  }

  Future<void> removeTeamMember(int userId) async {
    try {
      dispatch(const TeamManagementPageAction.showLoader());
      await this._removeTeamMemberUseCase(_teamId, userId);
      _teamDetails = await _getTeamDetailsUseCase(_teamId);
      _emitIdle();
      dispatch(const TeamManagementPageAction.success(popPage: false));
    } catch (e) {
      log(e.toString());
      emit(const TeamManagementPageState.error());
    }
    dispatch(const TeamManagementPageAction.hideLoader());
  }

  Future<void> changeTeamMemberRole(int userId, Role role) async {
    try {
      dispatch(const TeamManagementPageAction.showLoader());
      await this._changeTeamMemberRoleUseCase(_teamId, userId, role);
      _teamDetails = await _getTeamDetailsUseCase(_teamId);
      _emitIdle();
      dispatch(const TeamManagementPageAction.success(popPage: false));
    } catch (e) {
      log(e.toString());
      emit(const TeamManagementPageState.error());
    }
    dispatch(const TeamManagementPageAction.hideLoader());
  }
}
