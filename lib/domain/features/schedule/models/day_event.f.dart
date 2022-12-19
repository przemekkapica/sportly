import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_event.f.freezed.dart';

@freezed
class DayEvent with _$DayEvent {
  const factory DayEvent({
    required int id,
    required DateTime date,
    required String title,
    required String? description,
    required bool editable,
  }) = _DayEvent;
}
