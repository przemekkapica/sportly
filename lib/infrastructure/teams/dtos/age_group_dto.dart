import 'package:json_annotation/json_annotation.dart';

part 'age_group_dto.g.dart';

@JsonSerializable()
class AgeGroupDto {
  AgeGroupDto({
    required this.name,
  });

  factory AgeGroupDto.fromJson(Map<String, dynamic> json) =>
      _$AgeGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AgeGroupDtoToJson(this);

  final String name;
}
