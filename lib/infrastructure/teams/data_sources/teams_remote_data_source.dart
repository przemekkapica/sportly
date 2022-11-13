import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';

part 'teams_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class TeamsRemoteDataSource {
  @factoryMethod
  factory TeamsRemoteDataSource(Dio dio) = _TeamsRemoteDataSource;

  @POST(NetworkConfig.GET_TEAMS)
  Future<dynamic> getTeams();
}
