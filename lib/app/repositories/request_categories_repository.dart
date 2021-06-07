import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party_mobile/app/interfaces/request_categories_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/view_models/new_request_category_vm.dart';

class RequestCategoriesRepository
    implements IRequestCategoriesRepositoryInterface {
  DioHttp _dio = locator<DioHttp>();

  @override
  Future<Either<Failure, dynamic>> newRequestCategory(
      NewRequestCategoryVM newRequestCategory) async {
    try {
      var result = await _dio.withAuth().post(Endpoints.requestCategories,
          data: newRequestCategory.getData());
      return Right(result.data);
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['errors']));
    }
  }
}
