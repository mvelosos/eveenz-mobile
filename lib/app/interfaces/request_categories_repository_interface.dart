import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/new_request_category_vm.dart';

abstract class IRequestCategoriesRepositoryInterface {
  Future<Either<Failure, dynamic>> newRequestCategory(
      NewRequestCategoryVM newRequestCategory);
}
