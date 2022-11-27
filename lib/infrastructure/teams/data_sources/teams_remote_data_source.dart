import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';
import 'package:sportly/infrastructure/teams/dtos/create_team_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/get_disciplines_dto.dart';

part 'teams_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class TeamsRemoteDataSource {
  @factoryMethod
  factory TeamsRemoteDataSource(Dio dio) = _TeamsRemoteDataSource;

  @GET(NetworkConfig.GET_TEAMS)
  Future<dynamic> getTeams();

  @POST(NetworkConfig.CREATE_TEAM)
  Future<void> createTeam(CreateTeamDto createTeamDto);

  @GET(NetworkConfig.GET_DISCIPLINES)
  Future<GetDisciplinesDto> getDisciplines();
}
