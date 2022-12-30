import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';
import 'package:sportly/infrastructure/auth/dtos/internal_user_dto.dart';

part 'user_data_source.g.dart';

@RestApi()
@injectable
abstract class UserDataSource {
  @factoryMethod
  factory UserDataSource(Dio dio) = _UserDataSource;

  @GET(NetworkConfig.GET_USER_DATA)
  Future<InternalUserDto> getUserData();
}
