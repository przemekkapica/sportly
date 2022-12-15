import 'package:calendar_view/calendar_view.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';

@injectable
class EventBidirectionalMapper extends DataMapper<Event, CalendarEventData> {
  EventBidirectionalMapper();

  @override
  CalendarEventData<Object?> call(Event data) {
    return CalendarEventData(
      title: data.title,
      date: data.date,
    );
  }
}
