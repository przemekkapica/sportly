import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sportly/domain/features/network/connectivity/connection_checker.dart';
import 'package:sportly/domain/features/network/enums/connection_state.dart';
import 'package:sportly/infrastructure/network/mappers/connection_state_mapper.dart';

const _connectionCheckDuration = Duration(seconds: 5);

@LazySingleton(as: ConnectionChecker)
class ConnectionCheckerImpl implements ConnectionChecker {
  ConnectionCheckerImpl(
    this._connectivity,
    this._connectionStateMapper,
  ) {
    final connectivityResultSubject =
        BehaviorSubject<ConnectivityResult>.seeded(ConnectivityResult.none)
          ..addStream(_connectivity.onConnectivityChanged);

    final connectionSourceStream = connectivityResultSubject
        .where(
          (connectionType) => connectionType != ConnectivityResult.bluetooth,
        )
        .map(_connectionStateMapper.call)
        .distinct();

    final connectionSourcePeriodicChecker = Rx.combineLatest2(
      Stream.periodic(_connectionCheckDuration),
      connectionSourceStream,
      (streamInterval, ConnectionState connectionState) => connectionState,
    );

    final connectionStateStream = connectionSourcePeriodicChecker
        .switchMap(_checkIsSourceConnected)
        .distinct();
    _connectionSubject
        .addStream(connectionStateStream)
        .then((_) => _connectionSubject.close());
    _connectionSubject.listen((state) {
// TODO: add log here
    });
  }

  final BehaviorSubject<ConnectionState> _connectionSubject = BehaviorSubject();
  final ConnectionStateMapper _connectionStateMapper;
  final Connectivity _connectivity;

  bool isPingEnabled = false;

  Stream<ConnectionState> _checkIsSourceConnected(
    ConnectionState state,
  ) async* {
    final realState = await getSourceConnectionState();
    if (realState == ConnectionState.disconnected) {
      // to confirm the second time
      final confirmedRealState = await getSourceConnectionState();
      yield confirmedRealState;
    } else {
      yield realState;
    }
  }

  @override
  Stream<ConnectionState> get onConnectionStateChange =>
      _connectionSubject.stream;

  @override
  Future<ConnectionState> getSourceConnectionState() async {
    if (isPingEnabled) {
      final hasConnection = await _connectivity
              .checkConnectivity()
              .then((value) => _connectionStateMapper.call(value)) ==
          ConnectionState.connected;

      return hasConnection
          ? ConnectionState.connected
          : ConnectionState.disconnected;
    } else {
      return ConnectionState.connected;
    }
  }

  @override
  void stopServerPing() {
    isPingEnabled = false;
  }

  @override
  void startServerPing() {
    isPingEnabled = true;
  }
}
