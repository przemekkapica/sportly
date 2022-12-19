import 'package:json_annotation/json_annotation.dart';

part 'create_event_dto.g.dart';

@JsonSerializable()
class CreateEventDto {
  CreateEventDto({
    required this.eventDate,
    required this.title,
    required this.description,
  });

  factory CreateEventDto.fromJson(Map<String, dynamic> json) =>
      _$CreateEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateEventDtoToJson(this);

  final String eventDate;
  final String title;
  final String? description;
}
