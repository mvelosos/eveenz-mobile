import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

abstract class ICategoriesRepositoryInterface {
  Future<Either<Failure, dynamic>> getCategories();
}
