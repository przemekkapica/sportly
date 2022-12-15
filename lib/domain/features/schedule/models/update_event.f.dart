import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_event.f.freezed.dart';

@freezed
class UpdateEvent with _$UpdateEvent {
  const factory UpdateEvent({
    required DateTime date,
    required String title,
    required String? description,
  }) = _UpdateEvent;
}
