import 'package:freezed_annotation/freezed_annotation.dart';

part 'sport_discipline.f.freezed.dart';

@freezed
class SportDiscipline with _$SportDiscipline {
  const factory SportDiscipline({
    required String name,
  }) = _SportDiscipline;
}
