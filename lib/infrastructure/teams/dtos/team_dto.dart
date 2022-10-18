import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/teams/dtos/sport_discipline_dto.dart';

part 'team_dto.g.dart';

@JsonSerializable()
class TeamDto {
  TeamDto({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.isAdmin,
    required this.discipline,
  });

  factory TeamDto.fromJson(Map<String, dynamic> json) =>
      _$TeamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDtoToJson(this);

  final String id;
  final String name;
  final int membersCount;
  final bool isAdmin;
  final SportDisciplineDto discipline;
}
