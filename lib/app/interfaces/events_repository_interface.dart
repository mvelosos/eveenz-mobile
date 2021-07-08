import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/api_success_model.dart';
import 'package:party_mobile/app/models/event_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

abstract class IEventsRepository {
  Future<Either<Failure, EventModel>> getEvent(String uuid);

  Future<Either<Failure, ApiSuccessModel>> createEvent(NewEventVM newEvent);
}
