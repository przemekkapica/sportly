import 'package:json_annotation/json_annotation.dart';

part 'create_event_dto.g.dart';

@JsonSerializable()
class CreateEventDto {
  CreateEventDto({
    required this.date,
    required this.title,
    required this.description,
  });

  factory CreateEventDto.fromJson(Map<String, dynamic> json) =>
      _$CreateEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateEventDtoToJson(this);

  final String date;
  final String title;
  final String? description;
}
