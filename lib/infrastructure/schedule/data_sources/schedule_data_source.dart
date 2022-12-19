import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';
import 'package:sportly/infrastructure/schedule/dtos/create_event_dto.dart';

part 'schedule_data_source.g.dart';

@RestApi()
@injectable
abstract class ScheduleDataSource {
  @factoryMethod
  factory ScheduleDataSource(Dio dio) = _ScheduleDataSource;

  @POST(NetworkConfig.CREATE_EVENT)
  Future<void> createEvent(
    @Path() int teamId,
    @Body() CreateEventDto createEventDto,
  );
}
