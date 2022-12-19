import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';
import 'package:sportly/infrastructure/schedule/dtos/create_event_dto.dart';
import 'package:sportly/infrastructure/schedule/dtos/get_month_events_dto.dart';

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

  @GET(NetworkConfig.GET_MONTH_EVENTS)
  Future<GetMonthEventsDto> getMonthEvents(
    @Path() int teamId,
    @Query('date') String date,
  );
}
