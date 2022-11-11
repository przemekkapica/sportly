import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page_state.f.dart';

@injectable
class SchedulePageCubit extends Cubit<SchedulePageState> {
  SchedulePageCubit() : super(const SchedulePageState.loading());

  void init() {
    emit(const SchedulePageState.idle());
  }
}
