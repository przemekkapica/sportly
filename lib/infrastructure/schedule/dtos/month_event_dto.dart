import 'package:json_annotation/json_annotation.dart';

part 'month_event_dto.g.dart';

@JsonSerializable()
class MonthEventDto {
  MonthEventDto({
    required this.id,
    required this.date,
    required this.title,
  });

  factory MonthEventDto.fromJson(Map<String, dynamic> json) =>
      _$MonthEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MonthEventDtoToJson(this);

  final int id;
  final String date;
  final String title;
}
