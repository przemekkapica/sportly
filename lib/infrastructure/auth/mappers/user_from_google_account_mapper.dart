import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/models/user.f.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';

@injectable
class UserFromGoogleAccountMapper
    extends DataMapper<GoogleSignInAccount, User> {
  @override
  User call(GoogleSignInAccount data) {
    return User(
      id: data.id,
      email: data.email,
      displayName: data.displayName ?? '',
      photoUrl: data.photoUrl,
    );
  }
}
