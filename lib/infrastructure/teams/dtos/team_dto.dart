import 'package:json_annotation/json_annotation.dart';

part 'team_dto.g.dart';

@JsonSerializable()
class TeamDto {
  TeamDto({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.isAdmin,
  });

  factory TeamDto.fromJson(Map<String, dynamic> json) =>
      _$TeamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDtoToJson(this);

  final String id;
  final String name;
  final int membersCount;
  final bool isAdmin;
}
