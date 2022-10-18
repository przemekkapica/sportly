import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/teams/models/age_group.f.dart';
import 'package:sportly/infrastructure/teams/dtos/age_group_dto.dart';

@injectable
class AgeGroupMapper extends BidirectionalDataMapper<AgeGroupDto, AgeGroup> {
  @override
  AgeGroup fromDto(AgeGroupDto dto) {
    return AgeGroup(name: dto.name);
  }

  @override
  AgeGroupDto toDto(AgeGroup data) {
    return AgeGroupDto(name: data.name);
  }
}
