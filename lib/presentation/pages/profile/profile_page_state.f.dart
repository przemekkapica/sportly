import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/auth/models/user.f.dart';

part 'profile_page_state.f.freezed.dart';

@freezed
class ProfilePageState with _$ProfilePageState {
  const factory ProfilePageState.idle({
    required User user,
  }) = ProfilePageStateIdle;

  const factory ProfilePageState.loading() = ProfilePageStateLoading;

  const factory ProfilePageState.error() = ProfilePageStateError;
}
