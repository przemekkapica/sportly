import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'month_event.f.freezed.dart';

@freezed
class MonthEvent with _$MonthEvent {
  const factory MonthEvent({
    required DateTime date,
    required String title,
  }) = _MonthEvent;
}
