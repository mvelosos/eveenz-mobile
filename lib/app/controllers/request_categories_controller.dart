import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/repositories/request_categories_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/new_request_category_vm.dart';

class RequestCategoriesController {
  RequestCategoriesRepository _requestCategoriesRepository;

  RequestCategoriesController() {
    _requestCategoriesRepository = RequestCategoriesRepository();
  }

  Future<Either<Failure, dynamic>> newRequestCategory(
      NewRequestCategoryVM newRequestCategory) async {
    var result = await _requestCategoriesRepository
        .newRequestCategory(newRequestCategory);
    return Right(result);
  }
}
