import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_member.f.freezed.dart';

@freezed
class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String id,
    required String firstName,
    required String lastName,
    required bool isAdmin,
  }) = _TeamMember;
}

extension TeamMemberExtension on TeamMember {
  String get fullName => firstName + ' ' + lastName;
}
