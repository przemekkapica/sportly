import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_event.f.freezed.dart';

@freezed
class EditEvent with _$EditEvent {
  const factory EditEvent({
    required DateTime date,
    required String title,
    required String? description,
  }) = _EditEvent;
}
