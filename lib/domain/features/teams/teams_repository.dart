import 'package:sportly/domain/features/teams/models/create_team.f.dart';
import 'package:sportly/domain/features/teams/models/invitation_code.f.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/domain/features/teams/models/team_details.f.dart';
import 'package:sportly/domain/features/teams/models/update_team.f.dart';

abstract class TeamsRepository {
  Future<void> createTeam(CreateTeam createTeam);

  Future<List<Team>> getTeams();

  Future<TeamDetails> getTeamDetails(int id);

  Future<InvitationCode> getInvitationCode(int teamId);

  Future<void> joinTeam(String code);

  Future<void> leaveTeam(int id);

  Future<void> updateTeam(int id, UpdateTeam updateTeam);

  Future<void> removeTeamMember(int teamId, String userId);

  Future<void> updateTeamMemberRole(int teamId, String userId, Role role);

  Future<List<SportDiscipline>> getDisciplines();
}
