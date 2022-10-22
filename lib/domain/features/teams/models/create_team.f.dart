import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/age_group.f.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';

part 'create_team.f.freezed.dart';

@freezed
class CreateTeam with _$CreateTeam {
  const factory CreateTeam({
    required String name,
    required SportDiscipline discipline,
    required AgeGroup ageGroup,
    required String location,
    required String? organizationName,
  }) = _CreateTeam;
}
