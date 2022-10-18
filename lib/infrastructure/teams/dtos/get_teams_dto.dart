import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/teams/dtos/team_dto.dart';

part 'get_teams_dto.g.dart';

@JsonSerializable()
class GetTeamsDto {
  GetTeamsDto({
    required this.teams,
  });

  factory GetTeamsDto.fromJson(Map<String, dynamic> json) =>
      _$GetTeamsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetTeamsDtoToJson(this);

  final List<TeamDto> teams;
}
