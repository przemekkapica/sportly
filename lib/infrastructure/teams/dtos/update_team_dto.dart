import 'package:json_annotation/json_annotation.dart';

part 'update_team_dto.g.dart';

@JsonSerializable()
class UpdateTeamDto {
  UpdateTeamDto({
    required this.name,
    required this.location,
    required this.organizationName,
  });

  factory UpdateTeamDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateTeamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTeamDtoToJson(this);

  final String name;
  final String? location;
  final String? organizationName;
}
