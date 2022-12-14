import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/edit_event.f.dart';
import 'package:sportly/domain/use_cases/edit_event_use_case.dart';
import 'package:sportly/presentation/pages/edit_event/edit_event_page_action.f.dart';
import 'package:sportly/presentation/pages/edit_event/edit_event_page_state.f.dart';
import 'package:sportly/utils/extensions/string_extension.dart';

@injectable
class EditEventPageCubit
    extends ActionCubit<EditEventPageState, EditEventPageAction> {
  EditEventPageCubit(
    this._editEventUseCase,
  ) : super(const EditEventPageState.loading());

  final EditEventUseCase _editEventUseCase;

  late final int _teamId;
  late DateTime _dateTime;

  String? _title;
  String? _description;

  bool _submitButtonEnabled = false;

  Future<void> init(int teamId, DateTime date) async {
    _dateTime = date;
    _teamId = teamId;

    _emitIdle();
  }

  void _emitIdle() {
    emit(
      EditEventPageState.idle(
        selectedDate: _dateTime,
        submitButtonEnabled: _submitButtonEnabled,
      ),
    );
  }

  onTitleChanged(String? value) {
    _title = value;
    _checkIfButtonEnabledAndEmit();
  }

  onDescriptionChanged(String? value) {
    _description = value;
    _checkIfButtonEnabledAndEmit();
  }

  onDateChanged(DateTime dateTime) {
    _dateTime = dateTime;
    _emitIdle();
  }

  void _checkIfButtonEnabledAndEmit() {
    if (_title.nullOrEmpty) {
      _submitButtonEnabled = false;
    } else {
      _submitButtonEnabled = true;
    }
    _emitIdle();
  }

  Future<void> submit() async {
    if (!_title.nullOrEmpty) {
      dispatch(const EditEventPageAction.showLoader());
      try {
        await _editEventUseCase(
          _teamId,
          EditEvent(
            date: _dateTime,
            title: _title!,
            description: _description,
          ),
        );
        dispatch(const EditEventPageAction.success());
      } catch (e) {
        emit(const EditEventPageState.error());
      } finally {
        dispatch(const EditEventPageAction.hideLoader());
      }
    }
  }
}
