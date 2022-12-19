import 'package:freezed_annotation/freezed_annotation.dart';

part 'events_list_page_action.f.freezed.dart';

@freezed
class EventsListPageAction with _$EventsListPageAction {
  const factory EventsListPageAction.showLoader() = _ShowLoader;

  const factory EventsListPageAction.hideLoader() = _HideLoader;

  const factory EventsListPageAction.deleteSuccess({
    required bool popPage,
  }) = _DeleteSuccess;

  const factory EventsListPageAction.updateSuccess() = _UpdateSuccess;
}
