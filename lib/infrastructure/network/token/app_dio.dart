import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/core/config/env_config.dart';
import 'package:sportly/domain/use_cases/get_id_token_use_case.dart';

const _timeout = Duration(seconds: 30);

class BaseDio extends DioMixin {
  BaseDio(
    this._getIdTokenUseCase,
  ) {
    _setup();
  }

  final GetIdTokenUseCase _getIdTokenUseCase;

  void _setup() async {
    final token = await _getIdTokenUseCase();

    httpClientAdapter = DefaultHttpClientAdapter();

    options = BaseOptions(
      baseUrl: EnvConfig.BASE_URL,
      receiveTimeout: _timeout.inMilliseconds,
      connectTimeout: _timeout.inMilliseconds,
      sendTimeout: _timeout.inMilliseconds,
      headers: {'idToken': token},
    );
  }
}

@Singleton(as: Dio)
class AppDio extends BaseDio implements Dio {
  AppDio(
    GetIdTokenUseCase getIdTokenUseCase,
  ) : super(getIdTokenUseCase);
}

@Singleton()
class UnauthenticatedAppDio extends BaseDio implements Dio {
  UnauthenticatedAppDio(
    GetIdTokenUseCase getIdTokenUseCase,
  ) : super(getIdTokenUseCase);
}
