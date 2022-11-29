import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation_code.f.freezed.dart';

@freezed
class InvitationCode with _$InvitationCode {
  const factory InvitationCode({
    required String code,
    required DateTime expiryDate,
  }) = _InvitationCode;
}
