import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_page_action.f.freezed.dart';

@freezed
class ProfilePageAction with _$ProfilePageAction {
  const factory ProfilePageAction.signOut() = _SignOut;
}
