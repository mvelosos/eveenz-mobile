import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/search_result_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/search_vm.dart';

abstract class ISearchRepository {
  Future<Either<Failure, SearchResultModel>> search(SearchVM search);
}
