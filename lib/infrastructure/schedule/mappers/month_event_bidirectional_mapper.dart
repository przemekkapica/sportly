import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/schedule/models/month_event.f.dart';
import 'package:sportly/infrastructure/schedule/dtos/month_event_dto.dart';

@injectable
class MonthEventBidirectionalMapper
    extends DataMapper<MonthEventDto, MonthEvent> {
  MonthEventBidirectionalMapper();

  @override
  MonthEvent call(MonthEventDto data) {
    return MonthEvent(
      id: data.id,
      date: DateTime.parse(data.date),
      title: data.title,
    );
  }
}
