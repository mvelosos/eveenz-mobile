import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/category_model.dart';
import 'package:party_mobile/app/repositories/categories_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

class CategoriesController {
  CategoriesRepository _categoriesRepository = CategoriesRepository();

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    List<CategoryModel> categoriesList = [];
    var result = await _categoriesRepository.getCategories();
    if (result.isRight()) {
      dynamic resultList = result.getOrElse(() => {});
      if (resultList['categories'] != null || resultList['categories'] != []) {
        resultList['categories'].forEach(
          (category) => categoriesList.add(
            CategoryModel.fromJson(category),
          ),
        );
      }
    }
    return Right(categoriesList);
  }
}
