import 'package:json_annotation/json_annotation.dart';

part 'invitation_code_dto.g.dart';

@JsonSerializable()
class InvitationCodeDto {
  InvitationCodeDto({
    required this.code,
  });

  factory InvitationCodeDto.fromJson(Map<String, dynamic> json) =>
      _$InvitationCodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationCodeDtoToJson(this);

  final String code;
}
