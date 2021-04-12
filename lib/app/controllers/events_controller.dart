import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/repositories/events_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

class EventsController {
  EventsRepository _eventsRepository;

  EventsController() {
    _eventsRepository = EventsRepository();
  }

  Future<Either<Failure, dynamic>> createEvent(NewEventVM newEvent) async {
    var result = await _eventsRepository.createEvent(newEvent);
    return result;
  }
}
