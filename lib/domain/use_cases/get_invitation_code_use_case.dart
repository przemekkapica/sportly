import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/invitation_code.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class GetInvitationCodeUseCase {
  GetInvitationCodeUseCase(this._teamsRepository);

  final TeamsRepository _teamsRepository;

  Future<InvitationCode> call(int teamId) async {
    return await _teamsRepository.getInvitationCode(teamId);
  }
}
