import 'package:get_it/get_it.dart';
import 'package:party_mobile/app/controllers/categories_controller.dart';
import 'package:party_mobile/app/controllers/events_controller.dart';
import 'package:party_mobile/app/controllers/home_controller.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/controllers/notifications_controller.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/controllers/passwords_controller.dart';
import 'package:party_mobile/app/controllers/request_categories_controller.dart';
import 'package:party_mobile/app/controllers/search_controller.dart';
import 'package:party_mobile/app/controllers/accounts_controller.dart';
import 'package:party_mobile/app/controllers/signup_controller.dart';
import 'package:party_mobile/app/controllers/users_controller.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/stores/app_store.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/stores/notifications_store.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Controllers
  locator.registerLazySingleton(() => AccountsController());
  locator.registerLazySingleton(() => CategoriesController());
  locator.registerLazySingleton(() => EventsController());
  locator.registerLazySingleton(() => HomeController());
  locator.registerLazySingleton(() => LoginController());
  locator.registerLazySingleton(() => NotificationsController());
  locator.registerLazySingleton(() => PasswordsController());
  locator.registerLazySingleton(() => ProfileController());
  locator.registerLazySingleton(() => RequestCategoriesController());
  locator.registerLazySingleton(() => SearchController());
  locator.registerLazySingleton(() => SignUpController());
  locator.registerLazySingleton(() => UsersController());

  // Navigator Keys
  locator.registerLazySingleton(() => RootNavigatorKey());
  locator.registerLazySingleton(() => HomeNavigatorKey());
  locator.registerLazySingleton(() => SearchNavigatorKey());
  locator.registerLazySingleton(() => MapNavigatorKey());
  locator.registerLazySingleton(() => NotificationsNavigatorKey());
  locator.registerLazySingleton(() => ProfileNavigatorKey());

  //Stores
  locator.registerLazySingleton(() => AppStore());
  locator.registerLazySingleton(() => AuthUserStore());
  locator.registerLazySingleton(() => NotificationsStore());
  locator.registerLazySingleton(() => ProfileStore());

  // Utils
  locator.registerLazySingleton(() => DioHttp());
  locator.registerLazySingleton(() => LocalStorageService());
}
