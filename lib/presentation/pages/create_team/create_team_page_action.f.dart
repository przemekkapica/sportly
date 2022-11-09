import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_team_page_action.f.freezed.dart';

@freezed
class CreateTeamPageAction with _$CreateTeamPageAction {
  const factory CreateTeamPageAction.showLoader() = _ShowLoader;

  const factory CreateTeamPageAction.hideLoader() = _HideLoader;

  const factory CreateTeamPageAction.success() = _Success;
}
