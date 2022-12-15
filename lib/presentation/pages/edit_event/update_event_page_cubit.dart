import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/update_event.f.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';
import 'package:sportly/domain/use_cases/update_event_use_case.dart';
import 'package:sportly/presentation/pages/edit_event/update_event_page_action.f.dart';
import 'package:sportly/presentation/pages/edit_event/update_event_page_state.f.dart';
import 'package:sportly/utils/extensions/string_extension.dart';

@injectable
class UpdateEventPageCubit
    extends ActionCubit<UpdateEventPageState, UpdateEventPageAction> {
  UpdateEventPageCubit(
    this._updateEventUseCase,
  ) : super(const UpdateEventPageState.loading());

  final UpdateEventUseCase _updateEventUseCase;

  late final int _teamId;
  late DateTime _dateTime;

  String? title;
  String? description;

  bool _submitButtonEnabled = false;

  Future<void> init(int teamId, Event event) async {
    title = event.title;
    description = event.description;
    _dateTime = event.date;
    _teamId = teamId;

    _emitIdle();
  }

  void _emitIdle() {
    emit(
      UpdateEventPageState.idle(
        selectedDate: _dateTime,
        submitButtonEnabled: _submitButtonEnabled,
      ),
    );
  }

  onTitleChanged(String? value) {
    title = value;
    _checkIfButtonEnabledAndEmit();
  }

  onDescriptionChanged(String? value) {
    description = value;
    _checkIfButtonEnabledAndEmit();
  }

  onDateChanged(DateTime dateTime) {
    _dateTime = dateTime;
    _emitIdle();
  }

  void _checkIfButtonEnabledAndEmit() {
    if (title.nullOrEmpty) {
      _submitButtonEnabled = false;
    } else {
      _submitButtonEnabled = true;
    }
    _emitIdle();
  }

  Future<void> submit() async {
    if (!title.nullOrEmpty) {
      dispatch(const UpdateEventPageAction.showLoader());
      try {
        await _updateEventUseCase(
          _teamId,
          UpdateEvent(
            date: _dateTime,
            title: title!,
            description: description,
          ),
        );
        dispatch(const UpdateEventPageAction.success());
      } catch (e) {
        emit(const UpdateEventPageState.error());
      } finally {
        dispatch(const UpdateEventPageAction.hideLoader());
      }
    }
  }
}
