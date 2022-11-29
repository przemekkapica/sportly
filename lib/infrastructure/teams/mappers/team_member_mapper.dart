import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/team_member.f.dart';
import 'package:sportly/infrastructure/teams/dtos/team_member_dto.dart';

@injectable
class TeamMemberMapper
    extends BidirectionalDataMapper<TeamMemberDto, TeamMember> {
  @override
  TeamMember fromDto(TeamMemberDto dto) {
    return TeamMember(
      id: dto.id,
      firstName: dto.firstName,
      role: roleFromString(dto.role),
      lastName: dto.lastName,
    );
  }

  @override
  TeamMemberDto toDto(TeamMember data) {
    return TeamMemberDto(
      id: data.id,
      firstName: data.firstName,
      role: data.role.value,
      lastName: data.lastName,
    );
  }
}
