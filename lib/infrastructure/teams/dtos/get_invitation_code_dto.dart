import 'package:json_annotation/json_annotation.dart';

part 'get_invitation_code_dto.g.dart';

@JsonSerializable()
class GetInvitationCodeDto {
  GetInvitationCodeDto({
    required this.code,
    required this.expireDate,
  });

  factory GetInvitationCodeDto.fromJson(Map<String, dynamic> json) =>
      _$GetInvitationCodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetInvitationCodeDtoToJson(this);

  final String code;
  final String expireDate;
}
