import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/core/config/env_config.dart';
import 'package:sportly/infrastructure/network/interceptors/auth_interceptor.dart';

const _timeout = Duration(seconds: 30);

class BaseDio extends DioMixin {
  BaseDio([
    this._interceptors = const [],
  ]) {
    _setup();
  }

  final List<Interceptor> _interceptors;

  void _setup() {
    interceptors.addAll(_interceptors);

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
  AppDio(
    AuthInterceptor authInterceptor,
  ) : super([authInterceptor]);
}

@Singleton()
class UnauthenticatedAppDio extends BaseDio implements Dio {
  UnauthenticatedAppDio() : super();
}
