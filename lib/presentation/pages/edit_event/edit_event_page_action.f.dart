import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_event_page_action.f.freezed.dart';

@freezed
class EditEventPageAction with _$EditEventPageAction {
  const factory EditEventPageAction.showLoader() = _ShowLoader;

  const factory EditEventPageAction.hideLoader() = _HideLoader;

  const factory EditEventPageAction.success() = _Success;
}
