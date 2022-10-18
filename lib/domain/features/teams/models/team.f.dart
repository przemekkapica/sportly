import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.f.freezed.dart';

@freezed
class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    required int membersCount,
    required bool isAdmin,
  }) = _Team;
}
