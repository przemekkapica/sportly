import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/bidirectional_mapper.dart';
import 'package:sportly/domain/features/schedule/models/event.f.dart';
import 'package:sportly/infrastructure/schedule/dtos/event_dto.dart';

@injectable
class EventBidirectionalMapper
    extends BidirectionalDataMapper<EventDto, Event> {
  EventBidirectionalMapper();

  @override
  Event fromDto(EventDto dto) {
    return Event(
      date: DateTime.parse(dto.date),
      title: dto.title,
      description: dto.description,
    );
  }

  @override
  EventDto toDto(Event data) {
    return EventDto(
      date: 'data.',
      title: 'date.title',
      description: ' date.de',
    );
  }
}
