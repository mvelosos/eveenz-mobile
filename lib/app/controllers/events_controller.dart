import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/event_model.dart';
import 'package:party_mobile/app/repositories/events_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

class EventsController {
  EventsRepository _eventsRepository = EventsRepository();

  Future<Either<Failure, EventModel>> getEvent(String uuid) async {
    var eventResult = await _eventsRepository.getEvent(uuid);
    return eventResult;
  }

  Future<Either<Failure, dynamic>> createEvent(NewEventVM newEvent) async {
    var result = await _eventsRepository.createEvent(newEvent);
    return result;
  }
}
