import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.f.freezed.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required DateTime date,
    required String title,
    required String? description,
  }) = _Event;
}
