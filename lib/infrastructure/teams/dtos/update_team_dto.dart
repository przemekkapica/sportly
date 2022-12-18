import 'package:json_annotation/json_annotation.dart';

part 'update_team_dto.g.dart';

@JsonSerializable()
class UpdateTeamDto {
  UpdateTeamDto({
    required this.newTeamName,
    required this.newLocation,
    required this.newOrganizationName,
  });

  factory UpdateTeamDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateTeamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTeamDtoToJson(this);

  final String newTeamName;
  final String? newLocation;
  final String? newOrganizationName;
}
