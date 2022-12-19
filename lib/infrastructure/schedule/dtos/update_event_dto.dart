import 'package:json_annotation/json_annotation.dart';

part 'update_event_dto.g.dart';

@JsonSerializable()
class UpdateEventDto {
  UpdateEventDto({
    required this.date,
    required this.title,
    required this.description,
  });

  factory UpdateEventDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateEventDtoToJson(this);

  final String date;
  final String title;
  final String? description;
}
