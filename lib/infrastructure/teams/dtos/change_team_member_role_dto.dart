import 'package:json_annotation/json_annotation.dart';

part 'change_team_member_role_dto.g.dart';

@JsonSerializable()
class ChangeTeamMemberRoleDto {
  ChangeTeamMemberRoleDto({
    required this.newRole,
  });

  factory ChangeTeamMemberRoleDto.fromJson(Map<String, dynamic> json) =>
      _$ChangeTeamMemberRoleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeTeamMemberRoleDtoToJson(this);

  final String newRole;
}
