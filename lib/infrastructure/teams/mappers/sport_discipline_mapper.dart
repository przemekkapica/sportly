import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/infrastructure/teams/dtos/sport_discipline_dto.dart';

@injectable
class SportDisciplineMapper
    extends BidirectionalDataMapper<SportDisciplineDto, SportDiscipline> {
  @override
  SportDiscipline fromDto(SportDisciplineDto dto) {
    return SportDiscipline(name: dto.name);
  }

  @override
  SportDisciplineDto toDto(SportDiscipline data) {
    return SportDisciplineDto(name: data.name);
  }
}
