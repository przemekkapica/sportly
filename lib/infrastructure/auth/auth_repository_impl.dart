import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/auth/auth_repository.dart';
import 'package:sportly/infrastructure/auth/data_sources/auth_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._authDataSource,
  );

  final AuthDataSource _authDataSource;

  @override
  Future<void> signInWithGoogle() async {
    await _authDataSource.signInWithGoogle();
  }
}
