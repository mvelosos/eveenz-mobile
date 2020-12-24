import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/search_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/view_models/search_vm.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/models/search_result_model.dart';

class SearchRepository implements ISearchRepository {
  DioHttp _dio;

  SearchRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, SearchResultModel>> search(SearchVM search) async {
    try {
      var result = await _dio
          .withAuth()
          .get("${Endpoints.search}?query=${search.query}");
      return Right(SearchResultModel.fromJson(result.data));
    } catch (e) {
      return Left(RequestError(message: e.response.data['errors']));
    }
  }
}
