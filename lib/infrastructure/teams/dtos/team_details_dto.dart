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
    required this.role,
    required this.discipline,
    required this.location,
    required this.organizationName,
    required this.joinedDate,
    required this.members,
  });

  factory TeamDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$TeamDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDetailsDtoToJson(this);

  final int id;
  final String name;
  final String teamType;
  final int membersCount;
  final String role;
  final SportDisciplineDto discipline;
  final String? location;
  final String? organizationName;
  final String joinedDate;
  final List<TeamMemberDto> members;
}
