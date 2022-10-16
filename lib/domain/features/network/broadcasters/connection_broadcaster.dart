import 'package:sportly/domain/features/network/enums/connection_state.dart';

abstract class ConnectionBroadcaster {
  Stream<ConnectionState> get stream;
}
