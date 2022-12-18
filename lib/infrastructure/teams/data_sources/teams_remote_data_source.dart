import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';
import 'package:sportly/infrastructure/teams/dtos/change_team_member_role_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/create_team_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/get_disciplines_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/get_teams_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/get_invitation_code_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/invitation_code_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/team_details_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/update_team_dto.dart';

part 'teams_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class TeamsRemoteDataSource {
  @factoryMethod
  factory TeamsRemoteDataSource(Dio dio) = _TeamsRemoteDataSource;

  @GET(NetworkConfig.GET_TEAMS)
  Future<GetTeamsDto> getTeams();

  @POST(NetworkConfig.CREATE_TEAM)
  Future<void> createTeam(@Body() CreateTeamDto createTeamDto);

  @GET(NetworkConfig.GET_DISCIPLINES)
  Future<GetDisciplinesDto> getDisciplines();

  @GET(NetworkConfig.GET_TEAM_DETAILS)
  Future<TeamDetailsDto> getTeamDetails(@Path() int teamId);

  @GET(NetworkConfig.GET_INVITATION_CODE)
  Future<GetInvitationCodeDto> getInvitationCode(@Path() int teamId);

  @POST(NetworkConfig.JOIN_TEAM)
  Future<void> joinTeam(@Body() InvitationCodeDto invitationCodeDto);

  @DELETE(NetworkConfig.DELETE_TEAM)
  Future<void> deleteTeam(@Path() int teamId);

  @POST(NetworkConfig.LEAVE_TEAM)
  Future<void> leaveTeam(@Path() int teamId);

  @PUT(NetworkConfig.UPDATE_TEAM)
  Future<void> updateTeam(
    @Path() int teamId,
    @Body() UpdateTeamDto updateTeamDto,
  );

  @PUT(NetworkConfig.CHANGE_MEMBER_ROLE)
  Future<void> changeMemberRole(
    @Path() int teamId,
    @Path() int userId,
    @Body() ChangeTeamMemberRoleDto changeTeamMemberRoleDto,
  );

  @DELETE(NetworkConfig.REMOVE_MEMBER)
  Future<void> removeMember(
    @Path() int teamId,
    @Path() int userId,
  );
}
