import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/teams/models/update_team.f.dart';
import 'package:sportly/infrastructure/teams/dtos/update_team_dto.dart';

@injectable
class UpdateTeamMapper extends DataMapper<UpdateTeam, UpdateTeamDto> {
  @override
  UpdateTeamDto call(UpdateTeam data) {
    return UpdateTeamDto(
      name: data.name,
      organizationName: data.organizationName,
      location: data.location,
    );
  }
}
