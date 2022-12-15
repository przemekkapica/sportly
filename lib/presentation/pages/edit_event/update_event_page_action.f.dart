import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_event_page_action.f.freezed.dart';

@freezed
class UpdateEventPageAction with _$UpdateEventPageAction {
  const factory UpdateEventPageAction.showLoader() = _ShowLoader;

  const factory UpdateEventPageAction.hideLoader() = _HideLoader;

  const factory UpdateEventPageAction.success() = _Success;
}
