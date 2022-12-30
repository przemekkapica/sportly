import 'package:freezed_annotation/freezed_annotation.dart';

part 'internal_user.f.freezed.dart';

@freezed
class InternalUser with _$InternalUser {
  const factory InternalUser({
    required String id,
    required String firstName,
    required String lastName,
  }) = _InternalUser;
}
