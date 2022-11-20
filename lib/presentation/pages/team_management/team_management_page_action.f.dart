import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_management_page_action.f.freezed.dart';

@freezed
class TeamManagementPageAction with _$TeamManagementPageAction {
  const factory TeamManagementPageAction.showLoader() = _ShowLoader;

  const factory TeamManagementPageAction.hideLoader() = _HideLoader;

  const factory TeamManagementPageAction.success() = _Success;
}
