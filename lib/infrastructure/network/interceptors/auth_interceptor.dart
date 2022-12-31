import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/use_cases/get_id_token_use_case.dart';

@injectable
class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this._getIdTokenUseCase,
  );

  final GetIdTokenUseCase _getIdTokenUseCase;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _getIdTokenUseCase();
    if (token == null) {
      return super.onRequest(options, handler);
    }

    options.headers.addAll({
      'idToken': token,
    });

    super.onRequest(options, handler);
  }
}
