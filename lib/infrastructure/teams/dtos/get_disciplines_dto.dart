import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/teams/dtos/sport_discipline_dto.dart';

part 'get_disciplines_dto.g.dart';

@JsonSerializable()
class GetDisciplinesDto {
  GetDisciplinesDto({
    required this.disciplines,
  });

  factory GetDisciplinesDto.fromJson(Map<String, dynamic> json) =>
      _$GetDisciplinesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetDisciplinesDtoToJson(this);

  final List<SportDisciplineDto> disciplines;
}
