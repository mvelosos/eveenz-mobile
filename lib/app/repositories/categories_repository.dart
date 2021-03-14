import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/categories_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';

class CategoriesRepository implements ICategoriesRepositoryInterface {
  DioHttp _dio;

  CategoriesRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, dynamic>> getCategories() async {
    try {
      var url = '${Endpoints.categories}?paginate=false';
      var result = await _dio.withAuth().get(url);
      return Right(result.data);
    } catch (e) {
      return Left(RequestError(message: e.response.data['errors']));
    }
  }
}
