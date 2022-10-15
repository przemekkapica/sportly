import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/network/enums/connection_state.dart';

@injectable
class ConnectionStateMapper
    extends DataMapper<ConnectivityResult, ConnectionState> {
  @override
  ConnectionState call(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      return ConnectionState.disconnected;
    }

    return ConnectionState.connected;
  }
}
