import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/schedule/models/update_event.f.dart';
import 'package:sportly/infrastructure/schedule/dtos/update_event_dto.dart';

@injectable
class UpdateEventMapper extends DataMapper<UpdateEvent, UpdateEventDto> {
  UpdateEventMapper();

  @override
  UpdateEventDto call(UpdateEvent data) {
    return UpdateEventDto(
      date: data.date.toIso8601String(),
      title: data.title,
      description: data.description,
    );
  }
}
