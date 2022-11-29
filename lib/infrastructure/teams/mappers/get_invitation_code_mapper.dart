import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/teams/models/invitation_code.f.dart';
import 'package:sportly/infrastructure/teams/dtos/get_invitation_code_dto.dart';

@injectable
class GetInvitationCodeMapper
    extends DataMapper<GetInvitationCodeDto, InvitationCode> {
  @override
  InvitationCode call(GetInvitationCodeDto data) {
    return InvitationCode(
      code: data.code,
      expiryDate: DateTime.parse(data.expireDate),
    );
  }
}
