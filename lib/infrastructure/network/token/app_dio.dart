import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/core/config/env_config.dart';

const _timeout = Duration(seconds: 10);

class BaseDio extends DioMixin {
  BaseDio() {
    _setup();
  }

  void _setup() {
    httpClientAdapter = DefaultHttpClientAdapter();
    options = BaseOptions(
      baseUrl: EnvConfig.BASE_URL,
      receiveTimeout: _timeout.inMilliseconds,
      connectTimeout: _timeout.inMilliseconds,
      sendTimeout: _timeout.inMilliseconds,
    );
  }
}

@Singleton(as: Dio)
class AppDio extends BaseDio implements Dio {
  AppDio() : super();
}

@Singleton()
class UnauthenticatedAppDio extends BaseDio implements Dio {
  UnauthenticatedAppDio() : super();
}
