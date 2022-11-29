import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_team_member.f.freezed.dart';

@freezed
class UpdateTeamMember with _$UpdateTeamMember {
  const factory UpdateTeamMember({
    required int id,
    required bool isAdmin,
  }) = _UpdateTeamMember;
}
