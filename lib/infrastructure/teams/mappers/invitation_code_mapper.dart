import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/infrastructure/teams/dtos/invitation_code_dto.dart';

@injectable
class InvitationCodeMapper extends DataMapper<String, InvitationCodeDto> {
  @override
  InvitationCodeDto call(String code) {
    return InvitationCodeDto(code: code);
  }
}
