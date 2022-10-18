import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/infrastructure/teams/dtos/team_dto.dart';

@injectable
class TeamFromDtoMapper extends DataMapper<TeamDto, Team> {
  @override
  Team call(TeamDto data) {
    return Team(
      id: data.id,
      name: data.name,
      isAdmin: data.isAdmin,
      membersCount: data.membersCount,
    );
  }
}
