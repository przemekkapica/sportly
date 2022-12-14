import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:sportly/core/config/network_config.dart';
import 'package:sportly/infrastructure/schedule/dtos/create_event_dto.dart';
import 'package:sportly/infrastructure/schedule/dtos/get_day_events_dto.dart';
import 'package:sportly/infrastructure/schedule/dtos/get_month_events_dto.dart';
import 'package:sportly/infrastructure/schedule/dtos/update_event_dto.dart';

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

  @GET(NetworkConfig.GET_DAY_EVENTS)
  Future<GetDayEventsDto> getDayEvents(
    @Path() int teamId,
    @Query('date') String date,
  );

  @DELETE(NetworkConfig.DELETE_EVENT)
  Future<void> deleteEvent(
    @Path() int teamId,
    @Path() int eventId,
  );

  @PUT(NetworkConfig.UPDATE_EVENT)
  Future<void> updateEvent(
    @Path() int teamId,
    @Path() int eventId,
    @Body() UpdateEventDto updateEventDto,
  );
}
