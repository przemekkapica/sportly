import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/models/internal_user.f.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/infrastructure/auth/dtos/internal_user_dto.dart';

@injectable
class InternalUserFromDtoMapper
    extends DataMapper<InternalUserDto, InternalUser> {
  @override
  InternalUser call(InternalUserDto data) {
    return InternalUser(
      id: data.userId.toString(),
      firstName: data.firstName,
      lastName: data.lastName,
    );
  }
}
