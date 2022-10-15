import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

const _dirs = ['lib', 'bin', 'test'];

@InjectableInit(generateForDir: _dirs)
Future<void> configureInjection(String environment) {
  return $initGetIt(
    getIt,
    environment: environment,
  );
}
