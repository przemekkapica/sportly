import 'package:calendar_view/calendar_view.dart';
import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';

@injectable
class EventBidirectionalMapper
    extends BidirectionalDataMapper<CalendarEventData, Event> {
  EventBidirectionalMapper();

  @override
  Event fromDto(CalendarEventData data) {
    return Event(
      date: data.date,
      title: data.title,
      description: data.description,
    );
  }

  @override
  CalendarEventData toDto(Event data) {
    return CalendarEventData(
      date: data.date,
      title: data.title,
      description: data.description ?? '',
    );
  }
}
