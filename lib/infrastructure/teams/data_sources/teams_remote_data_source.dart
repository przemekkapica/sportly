import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';
import 'package:sportly/infrastructure/network/token/token_body.dart';
import 'package:sportly/infrastructure/teams/dtos/get_teams_dto.dart';

part 'teams_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class TeamsRemoteDataSource {
  @factoryMethod
  factory TeamsRemoteDataSource(Dio dio) = _TeamsRemoteDataSource;

  @POST(NetworkConfig.GET_TEAMS)
  Future<GetTeamsDto> getTeams(@Body() TokenBody idToken);
}
