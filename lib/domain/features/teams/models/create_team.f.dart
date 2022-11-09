import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';

part 'create_team.f.freezed.dart';

@freezed
class CreateTeam with _$CreateTeam {
  const factory CreateTeam({
    required String name,
    required TeamType teamType,
    required SportDiscipline discipline,
    required String location,
    required String? organizationName,
  }) = _CreateTeam;
}
