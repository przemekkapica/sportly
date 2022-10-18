import 'package:freezed_annotation/freezed_annotation.dart';

part 'age_group.f.freezed.dart';

@freezed
class AgeGroup with _$AgeGroup {
  const factory AgeGroup({
    required String name,
  }) = _AgeGroup;
}
