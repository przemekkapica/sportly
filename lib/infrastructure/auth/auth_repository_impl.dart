import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/auth_repository.dart';
import 'package:sportly/domain/auth/models/user.f.dart';
import 'package:sportly/infrastructure/auth/data_sources/auth_data_source.dart';
import 'package:sportly/infrastructure/auth/mappers/user_from_google_account_mapper.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authDataSource, this._userFromGoogleAccountMapper);

  final AuthDataSource _authDataSource;
  final UserFromGoogleAccountMapper _userFromGoogleAccountMapper;

  @override
  Future<void> signInWithGoogle() async {
    await _authDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  @override
  User? getCurrentUser() {
    final account = _authDataSource.getCurrentUser();

    if (account == null) {
      return null;
    }

    return _userFromGoogleAccountMapper(account);
  }

  @override
  Future<String> getIdToken() async {
    // TODO: rethink
    return await _authDataSource.getIdToken() ?? '';
  }
}
