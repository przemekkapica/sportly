import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event.f.freezed.dart';

@freezed
class CreateEvent with _$CreateEvent {
  const factory CreateEvent({
    required DateTime date,
    required String title,
    required String? description,
  }) = _CreateEvent;
}
