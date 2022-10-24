import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_page_state.f.freezed.dart';

@freezed
abstract class SignInPageState with _$SignInPageState {
  const factory SignInPageState.loading() = SignInPageStateLoading;

  const factory SignInPageState.idle() = SignInPageStateIdle;
}
