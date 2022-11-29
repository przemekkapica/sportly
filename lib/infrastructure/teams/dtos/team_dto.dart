import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/teams/dtos/sport_discipline_dto.dart';

part 'team_dto.g.dart';

@JsonSerializable()
class TeamDto {
  TeamDto({
    required this.id,
    required this.teamName,
    required this.type,
    required this.membersCount,
    required this.role,
    required this.discipline,
  });

  factory TeamDto.fromJson(Map<String, dynamic> json) =>
      _$TeamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDtoToJson(this);

  final int id;
  final String teamName;
  final String type;
  final int membersCount;
  final String role;
  final SportDisciplineDto discipline;
}
