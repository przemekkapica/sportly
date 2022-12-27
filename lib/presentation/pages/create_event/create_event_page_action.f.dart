import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event_page_action.f.freezed.dart';

@freezed
class CreateEventPageAction with _$CreateEventPageAction {
  const factory CreateEventPageAction.showLoader() = _ShowLoader;

  const factory CreateEventPageAction.hideLoader() = _HideLoader;

  const factory CreateEventPageAction.success({
    required DateTime date,
  }) = _Success;
}
