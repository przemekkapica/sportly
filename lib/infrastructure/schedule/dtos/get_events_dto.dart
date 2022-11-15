import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/schedule/dtos/event_dto.dart';

part 'get_events_dto.g.dart';

@JsonSerializable()
class GetEventsDto {
  GetEventsDto({
    required this.events,
  });

  factory GetEventsDto.fromJson(Map<String, dynamic> json) =>
      _$GetEventsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetEventsDtoToJson(this);

  final List<EventDto> events;
}
