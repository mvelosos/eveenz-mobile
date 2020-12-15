import 'package:get_it/get_it.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/stores/login_store.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Utils
  locator.registerLazySingleton(() => DioHttp());
  locator.registerLazySingleton(() => LocalStorageService());
  locator.registerLazySingleton(() => NavigationService());

  // Controllers
  locator.registerLazySingleton(() => LoginController());
  locator.registerLazySingleton(() => ProfileController());

  //Stores
  locator.registerLazySingleton(() => LoginStore());
  locator.registerLazySingleton(() => AuthUserStore());
  locator.registerLazySingleton(() => ProfileStore());
}
