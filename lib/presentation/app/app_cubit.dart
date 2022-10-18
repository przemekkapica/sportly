import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/presentation/app/app_action.f.dart';
import 'package:sportly/presentation/app/app_state.f.dart';
import 'package:sportly/domain/features/network/enums/connection_state.dart';
import 'package:sportly/domain/use_cases/get_connection_state_stream_use_case.dart';

@injectable
class AppCubit extends ActionCubit<AppState, AppAction> {
  AppCubit(
    this._getConnectionStateStream,
  ) : super(const AppState.idle()) {
    _getConnectionStateStream().listen(_onConnectionStateChanged);
  }

  final GetConnectionStateStreamUseCase _getConnectionStateStream;

  void _onConnectionStateChanged(ConnectionState connectionState) {
    if (connectionState == ConnectionState.disconnected) {
      dispatch(const AppAction.offline());
    } else {
      dispatch(const AppAction.online());
    }
  }
}
