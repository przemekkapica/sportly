import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/teams/dtos/sport_discipline_dto.dart';

part 'create_team_dto.g.dart';

@JsonSerializable()
class CreateTeamDto {
  CreateTeamDto({
    required this.teamName,
    required this.discipline,
    required this.teamType,
    required this.location,
    required this.organizationName,
  });

  factory CreateTeamDto.fromJson(Map<String, dynamic> json) =>
      _$CreateTeamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTeamDtoToJson(this);

  final String teamName;
  final SportDisciplineDto discipline;
  final String teamType;
  final String? location;
  final String? organizationName;
}
