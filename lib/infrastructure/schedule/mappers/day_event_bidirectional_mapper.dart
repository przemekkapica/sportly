import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/schedule/models/day_event.f.dart';
import 'package:sportly/infrastructure/schedule/dtos/day_event_dto.dart';

@injectable
class DayEventBidirectionalMapper extends DataMapper<DayEventDto, DayEvent> {
  DayEventBidirectionalMapper();

  @override
  DayEvent call(DayEventDto data) {
    return DayEvent(
      id: data.id,
      date: DateTime.parse(data.date),
      title: data.title,
      description: data.description,
      editable: data.editable,
    );
  }
}
