import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/events_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/api_success_model.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

class EventsRepository implements IEventsRepository {
  DioHttp _dio;

  EventsRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, ApiSuccessModel>> createEvent(
      NewEventVM newEvent) async {
    try {
      var event =
          await _dio.instance.post(Endpoints.events, data: newEvent.getData());
      return Right(ApiSuccessModel.fromJson(event.data));
    } catch (e) {
      if (e.response.data['errors'].length > 0) {
        var errors = e.response.data['errors'].join(', ');
        return Left(CreateEventError(message: errors));
      }
      return Left(CreateEventError(message: 'Unexpected error!'));
    }
  }
}
