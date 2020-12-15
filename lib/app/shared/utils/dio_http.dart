import 'package:dio/dio.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/shared/constants/urls.dart';

class DioHttp {
  Dio _dio;
  LocalStorageService _localStorageService;

  DioHttp() {
    _dio = Dio();
    _dio.options.baseUrl = Urls().apiUrl;
    _dio.interceptors
        .add(InterceptorsWrapper(onError: _onError, onResponse: _onResponse));
    _localStorageService = locator<LocalStorageService>();
  }

  Dio withAuth() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );

    return _dio;
  }

  Dio get instance => _dio;

  _onRequest(RequestOptions options) async {
    _localStorageService.get(Storage.jwtToken).then(
          (value) => {
            if (value != null) {options.headers['Authorization'] = value}
          },
        );
  }

  _onResponse(Response e) {
    print(e.data);
  }

  _onError(DioError e) {
    print('########## Response Error');
  }
}
