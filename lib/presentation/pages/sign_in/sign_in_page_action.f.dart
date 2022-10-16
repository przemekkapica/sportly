import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_page_action.f.freezed.dart';

@freezed
class SignInPageAction with _$SignInPageAction {
  const factory SignInPageAction.authSuccess() = SignInPageActionAuthSuccess;

  const factory SignInPageAction.authError() = SignInPageActionAuthError;
}
