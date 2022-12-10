import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/domain/features/teams/models/sport_discipline.f.dart';
import 'package:sportly/domain/features/teams/models/team_type.dart';
import 'package:sportly/domain/use_cases/create_event_use_case.dart';
import 'package:sportly/domain/use_cases/fetch_teams_use_case.dart';
import 'package:sportly/domain/use_cases/get_disciplines_use_case.dart';
import 'package:sportly/presentation/pages/create_event/create_event_page_action.f.dart';
import 'package:sportly/presentation/pages/create_event/create_event_page_state.f.dart';
import 'package:sportly/utils/extensions/string_extension.dart';

@injectable
class CreateEventPageCubit
    extends ActionCubit<CreateEventPageState, CreateEventPageAction> {
  CreateEventPageCubit(
    this._createEventUseCase,
  ) : super(const CreateEventPageState.loading());

  final CreateEventUseCase _createEventUseCase;

  late final _teamId;

  DateTime? _date;
  String? _title;
  String? _description;

  bool _submitButtonEnabled = false;

  Future<void> init(int teamId, DateTime date) async {
    _date = date;
    _teamId = teamId;

    emit(const CreateEventPageState.idle(submitButtonEnabled: false));
  }

  onTitleChanged(String? value) {
    _title = value;
    _checkIfButtonEnabledAndEmit();
  }

  onDescriptionChanged(String? value) {
    _description = value;
    _checkIfButtonEnabledAndEmit();
  }

  void _checkIfButtonEnabledAndEmit() {
    if (_title.nullOrEmpty || _date == null) {
      _submitButtonEnabled = false;
    } else {
      _submitButtonEnabled = true;
    }
    emit(
      CreateEventPageState.idle(
        submitButtonEnabled: _submitButtonEnabled,
      ),
    );
  }

  Future<void> submit() async {
    if (!_title.nullOrEmpty && _date != null) {
      dispatch(const CreateEventPageAction.showLoader());
      try {
        await _createEventUseCase(
          _teamId,
          CreateEvent(
            date: _date!,
            title: _title!,
            description: _description,
          ),
        );
        dispatch(const CreateEventPageAction.success());
      } catch (e) {
        emit(const CreateEventPageState.error());
      } finally {
        dispatch(const CreateEventPageAction.hideLoader());
      }
    }
  }
}
