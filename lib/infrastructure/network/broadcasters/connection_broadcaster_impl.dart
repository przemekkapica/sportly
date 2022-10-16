import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/network/broadcasters/connection_broadcaster.dart';
import 'package:sportly/domain/features/network/connectivity/connection_checker.dart';
import 'package:sportly/domain/features/network/enums/connection_state.dart';

@LazySingleton(as: ConnectionBroadcaster)
class ConnectionBroadcasterImpl implements ConnectionBroadcaster {
  ConnectionBroadcasterImpl(this._connectionChecker);

  final ConnectionChecker _connectionChecker;

  @override
  Stream<ConnectionState> get stream =>
      _connectionChecker.onConnectionStateChange;
}
