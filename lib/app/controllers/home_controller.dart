import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/repositories/home_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

class HomeController {
  HomeRepository _homeRepository = HomeRepository();

  Future<Either<Failure, dynamic>> getCards(double lat, double lon) async {
    var result = await _homeRepository.getCards(lat, lon);
    return result;
  }
}
