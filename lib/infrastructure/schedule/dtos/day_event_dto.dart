import 'package:json_annotation/json_annotation.dart';

part 'day_event_dto.g.dart';

@JsonSerializable()
class DayEventDto {
  DayEventDto({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.editable,
  });

  factory DayEventDto.fromJson(Map<String, dynamic> json) =>
      _$DayEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DayEventDtoToJson(this);

  final int id;
  final String date;
  final String title;
  final String? description;
  final bool editable;
}
