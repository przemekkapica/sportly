import 'package:json_annotation/json_annotation.dart';
import 'package:sportly/infrastructure/teams/dtos/sport_discipline_dto.dart';
import 'package:sportly/infrastructure/teams/dtos/team_member_dto.dart';

part 'team_details_dto.g.dart';

@JsonSerializable()
class TeamDetailsDto {
  TeamDetailsDto({
    required this.id,
    required this.name,
    required this.teamType,
    required this.membersCount,
    required this.isAdmin,
    required this.discipline,
    required this.joinedDate,
    required this.members,
  });

  factory TeamDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$TeamDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDetailsDtoToJson(this);

  final String id;
  final String name;
  final String teamType;
  final int membersCount;
  final bool isAdmin;
  final SportDisciplineDto discipline;
  final String joinedDate;
  final List<TeamMemberDto> members;
}
