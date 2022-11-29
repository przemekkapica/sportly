import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/teams/models/invitation_code.f.dart';
import 'package:sportly/infrastructure/teams/dtos/invitation_code_dto.dart';

@injectable
class InvitationCodeMapper
    extends BidirectionalDataMapper<InvitationCodeDto, InvitationCode> {
  @override
  InvitationCode fromDto(InvitationCodeDto dto) {
    return InvitationCode(code: dto.code);
  }

  @override
  InvitationCodeDto toDto(InvitationCode data) {
    return InvitationCodeDto(code: data.code);
  }
}
