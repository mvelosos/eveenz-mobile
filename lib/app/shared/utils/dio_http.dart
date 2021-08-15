import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/sign_out_service.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/shared/constants/urls.dart';
import 'package:party_mobile/app/stores/app_store.dart';
import 'package:get/get_navigation/get_navigation.dart';

class DioHttp {
  Dio _dio = Dio();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  AppStore _appStore = locator<AppStore>();

  DioHttp() {
    _dio.options.baseUrl = Urls.apiUrl;
    _dio.interceptors
        .add(InterceptorsWrapper(onError: _onError, onResponse: _onResponse));
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

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _localStorageService.get(Storage.jwtToken).then(
          (value) => {
            if (value != null) {options.headers['Authorization'] = value}
          },
        );
    return handler.next(options);
  }

  _onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  _onError(DioError error, ErrorInterceptorHandler handler) {
    print('########## Response Error');
    print(_appStore.userAuthenticated.value);
    if (error.response?.statusCode == 401 &&
        _appStore.userAuthenticated.value == true) {
      SignOutService.signOutUser();
    }
    return handler.next(error);
  }
}
