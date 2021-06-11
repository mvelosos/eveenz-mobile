import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/search_result_model.dart';
import 'package:party_mobile/app/repositories/search_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/search_vm.dart';

class SearchController {
  SearchRepository _searchRepository = SearchRepository();

  Future<Either<Failure, SearchResultModel>> search(SearchVM search) async {
    var searchResult = await _searchRepository.search(search);
    return searchResult;
  }
}
