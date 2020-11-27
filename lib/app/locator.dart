import 'package:get_it/get_it.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Utils
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DioHttp());

  // Controllers
  locator.registerLazySingleton(() => LoginController());
}
