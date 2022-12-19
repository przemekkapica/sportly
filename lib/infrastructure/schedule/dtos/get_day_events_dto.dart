import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/schedule/dtos/day_event_dto.dart';

part 'get_day_events_dto.g.dart';

@JsonSerializable()
class GetDayEventsDto {
  GetDayEventsDto({
    required this.events,
  });

  factory GetDayEventsDto.fromJson(Map<String, dynamic> json) =>
      _$GetDayEventsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetDayEventsDtoToJson(this);

  final List<DayEventDto> events;
}
