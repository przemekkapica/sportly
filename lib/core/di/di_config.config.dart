// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../app/app_cubit.dart' as _i10;
import '../../domain/features/network/broadcasters/connection_broadcaster.dart'
    as _i7;
import '../../domain/features/network/connectivity/connection_checker.dart'
    as _i5;
import '../../domain/use_cases/get_connection_state_stream_use_case.dart'
    as _i9;
import '../../infrastructure/network/broadcasters/connection_broadcaster_impl.dart'
    as _i8;
import '../../infrastructure/network/connectivity/connection_checker_impl.dart'
    as _i6;
import '../../infrastructure/network/mappers/connection_state_mapper.dart'
    as _i3;
import 'util_module.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final utilModule = _$UtilModule();
  gh.factory<_i3.ConnectionStateMapper>(() => _i3.ConnectionStateMapper());
  gh.lazySingleton<_i4.Connectivity>(() => utilModule.connectivity);
  gh.lazySingleton<_i5.ConnectionChecker>(() => _i6.ConnectionCheckerImpl(
        get<_i4.Connectivity>(),
        get<_i3.ConnectionStateMapper>(),
      ));
  gh.lazySingleton<_i7.ConnectionBroadcaster>(
      () => _i8.ConnectionBroadcasterImpl(get<_i5.ConnectionChecker>()));
  gh.factory<_i9.GetConnectionStateStreamUseCase>(() =>
      _i9.GetConnectionStateStreamUseCase(get<_i7.ConnectionBroadcaster>()));
  gh.factory<_i10.AppCubit>(
      () => _i10.AppCubit(get<_i9.GetConnectionStateStreamUseCase>()));
  return get;
}

class _$UtilModule extends _i11.UtilModule {}
