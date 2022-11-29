import 'package:json_annotation/json_annotation.dart';

part 'team_member_dto.g.dart';

@JsonSerializable()
class TeamMemberDto {
  TeamMemberDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  factory TeamMemberDto.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TeamMemberDtoToJson(this);

  final int id;
  final String firstName;
  final String lastName;
  final String role;
}
