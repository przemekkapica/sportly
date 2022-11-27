import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/teams_repository.dart';

@injectable
class GetDisciplinesUseCase {
  GetDisciplinesUseCase(
    this._teamsRepository,
  );

  final TeamsRepository _teamsRepository;

  Future<List<SportDiscipline>> call() async {
    return await _teamsRepository.getDisciplines();
  }
}
