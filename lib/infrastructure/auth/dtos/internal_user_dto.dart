import 'package:json_annotation/json_annotation.dart';

part 'internal_user_dto.g.dart';

@JsonSerializable()
class InternalUserDto {
  InternalUserDto({
    required this.userId,
    required this.firstName,
    required this.lastName,
  });

  factory InternalUserDto.fromJson(Map<String, dynamic> json) =>
      _$InternalUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InternalUserDtoToJson(this);

  final int userId;
  final String firstName;
  final String lastName;
}
