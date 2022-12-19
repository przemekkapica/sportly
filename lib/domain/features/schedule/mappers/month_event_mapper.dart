import 'package:calendar_view/calendar_view.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/schedule/models/month_event.f.dart';

@injectable
class MonthEventMapper extends DataMapper<MonthEvent, CalendarEventData> {
  MonthEventMapper();

  @override
  CalendarEventData<Object?> call(MonthEvent data) {
    return CalendarEventData(
      title: data.title,
      date: data.date,
    );
  }
}
