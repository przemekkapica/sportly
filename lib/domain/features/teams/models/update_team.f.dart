import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_team.f.freezed.dart';

@freezed
class UpdateTeam with _$UpdateTeam {
  const factory UpdateTeam({
    required String name,
    required String? location,
    required String? organizationName,
  }) = _UpdateTeam;
}
