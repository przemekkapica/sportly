import 'package:sportly/domain/features/network/enums/connection_state.dart';

abstract class ConnectionChecker {
  Stream<ConnectionState> get onConnectionStateChange;

  Future<ConnectionState> getSourceConnectionState();

  void stopServerPing();

  void startServerPing();
}
