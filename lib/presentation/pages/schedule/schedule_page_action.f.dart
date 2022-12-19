import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_page_action.f.freezed.dart';

@freezed
class SchedulePageAction with _$SchedulePageAction {
  const factory SchedulePageAction.showLoader() = _ShowLoader;

  const factory SchedulePageAction.hideLoader() = _HideLoader;
}
