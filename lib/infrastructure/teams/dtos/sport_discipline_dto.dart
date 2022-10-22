import 'package:json_annotation/json_annotation.dart';

part 'sport_discipline_dto.g.dart';

@JsonSerializable()
class SportDisciplineDto {
  SportDisciplineDto({
    required this.name,
  });

  factory SportDisciplineDto.fromJson(Map<String, dynamic> json) =>
      _$SportDisciplineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SportDisciplineDtoToJson(this);

  final String name;
}
