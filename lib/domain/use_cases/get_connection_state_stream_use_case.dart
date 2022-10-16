import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/network/broadcasters/connection_broadcaster.dart';
import 'package:sportly/domain/features/network/enums/connection_state.dart';

@injectable
class GetConnectionStateStreamUseCase {
  GetConnectionStateStreamUseCase(this._broadcaster);

  final ConnectionBroadcaster _broadcaster;

  Stream<ConnectionState> call() => _broadcaster.stream;
}
