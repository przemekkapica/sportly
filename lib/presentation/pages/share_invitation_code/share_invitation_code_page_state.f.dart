import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/invitation_code.f.dart';

part 'share_invitation_code_page_state.f.freezed.dart';

@freezed
class ShareInvitationCodePageState with _$ShareInvitationCodePageState {
  const factory ShareInvitationCodePageState.loading() =
      ShareInvitationCodePageStateLoading;

  const factory ShareInvitationCodePageState.idle({
    required InvitationCode code,
  }) = ShareInvitationCodePageStateIdle;

  const factory ShareInvitationCodePageState.error() =
      ShareInvitationCodePageStateError;
}
