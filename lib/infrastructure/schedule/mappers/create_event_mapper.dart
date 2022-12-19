import 'package:injectable/injectable.dart';
import 'package:sportly/domain/features/mapper/data_mapper.dart';
import 'package:sportly/domain/features/schedule/models/create_event.f.dart';
import 'package:sportly/infrastructure/schedule/dtos/create_event_dto.dart';

@injectable
class CreateEventMapper extends DataMapper<CreateEvent, CreateEventDto> {
  CreateEventMapper();

  @override
  CreateEventDto call(CreateEvent data) {
    return CreateEventDto(
      eventDate: data.date.toIso8601String(),
      title: data.title,
      description: data.description,
    );
  }
}
