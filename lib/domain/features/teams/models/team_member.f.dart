import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/role.dart';

part 'team_member.f.freezed.dart';

@freezed
class TeamMember with _$TeamMember {
  const factory TeamMember({
    required int id,
    required String firstName,
    required String lastName,
    required Role role,
  }) = _TeamMember;
}

extension TeamMemberExtension on TeamMember {
  String get fullName => firstName + ' ' + lastName;
}
