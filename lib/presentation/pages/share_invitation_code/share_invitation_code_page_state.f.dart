import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_invitation_code_page_state.f.freezed.dart';

@freezed
class ShareInvitationCodePageState with _$ShareInvitationCodePageState {
  const factory ShareInvitationCodePageState.loading() =
      ShareInvitationCodePageStateLoading;

  const factory ShareInvitationCodePageState.idle({
    required String code,
  }) = ShareInvitationCodePageStateIdle;

  const factory ShareInvitationCodePageState.error() =
      ShareInvitationCodePageStateError;
}
