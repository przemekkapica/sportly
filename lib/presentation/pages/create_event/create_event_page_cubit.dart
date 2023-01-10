import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/domain/use_cases/create_event_use_case.dart';
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
      CreateEventPageState.idle(
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
      dispatch(const CreateEventPageAction.showLoader());
      try {
        await _createEventUseCase(
          _teamId,
          CreateEvent(
            date: _dateTime,
            title: _title!,
            description: _description,
          ),
        );
        dispatch(CreateEventPageAction.success(date: _dateTime));
      } catch (e, st) {
        FirebaseCrashlytics.instance.recordError(e, st);
        log(e.toString());
        emit(const CreateEventPageState.error());
      } finally {
        dispatch(const CreateEventPageAction.hideLoader());
      }
    }
  }
}
