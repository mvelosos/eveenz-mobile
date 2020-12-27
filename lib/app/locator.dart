import 'package:get_it/get_it.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/controllers/search_controller.dart';
import 'package:party_mobile/app/controllers/accounts_controller.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/stores/login_store.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Controllers
  locator.registerLazySingleton(() => LoginController());
  locator.registerLazySingleton(() => ProfileController());
  locator.registerLazySingleton(() => SearchController());
  locator.registerLazySingleton(() => AccountsController());

  // Navigator Keys
  locator.registerLazySingleton(() => RootNavigatorKey());
  locator.registerLazySingleton(() => HomeNavigatorKey());
  locator.registerLazySingleton(() => SearchNavigatorKey());
  locator.registerLazySingleton(() => MapNavigatorKey());
  locator.registerLazySingleton(() => NotificationsNavigatorKey());
  locator.registerLazySingleton(() => ProfileNavigatorKey());

  //Stores
  locator.registerLazySingleton(() => LoginStore());
  locator.registerLazySingleton(() => AuthUserStore());
  locator.registerLazySingleton(() => ProfileStore());

  // Utils
  locator.registerLazySingleton(() => DioHttp());
  locator.registerLazySingleton(() => LocalStorageService());
}
