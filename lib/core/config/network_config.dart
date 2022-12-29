class NetworkConfig {
  // Teams
  static const GET_TEAMS = '/team/GetTeams';
  static const CREATE_TEAM = '/team/CreateTeam';
  static const GET_DISCIPLINES = '/team/GetDisciplines';
  static const GET_TEAM_DETAILS = '/team/GetTeamDetails/{teamId}';
  static const GET_INVITATION_CODE = '/team/GetTeamCode/{teamId}';
  static const JOIN_TEAM = '/team/JoinTeam';
  static const DELETE_TEAM = '/team/DeleteTeam/{teamId}';
  static const LEAVE_TEAM = '/team/LeaveTeam/{teamId}';
  static const UPDATE_TEAM = '/team/UpdateTeam/{teamId}';
  static const REMOVE_MEMBER = '/team/RemoveMember/{teamId}/{userId}';
  static const CHANGE_MEMBER_ROLE = '/team/ChangeMemberRole/{teamId}/{userId}';

  // Schedule
  static const GET_MONTH_EVENTS = '/schedule/GetMonthEvents/{teamId}';
  static const GET_DAY_EVENTS = '/schedule/GetDayEvents/{teamId}';
  static const CREATE_EVENT = '/schedule/CreateEvent/{teamId}';
  static const DELETE_EVENT = '/schedule/RemoveEvent/{teamId}/{eventId}';
  static const UPDATE_EVENT = '/schedule/UpdateEvent/{teamId}/{eventId}';
}
