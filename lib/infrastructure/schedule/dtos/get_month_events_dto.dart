import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/schedule/dtos/month_event_dto.dart';

part 'get_month_events_dto.g.dart';

@JsonSerializable()
class GetMonthEventsDto {
  GetMonthEventsDto({
    required this.events,
  });

  factory GetMonthEventsDto.fromJson(Map<String, dynamic> json) =>
      _$GetMonthEventsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetMonthEventsDtoToJson(this);

  final List<MonthEventDto> events;
}
