import 'package:dio/dio.dart';
import 'package:party_mobile/app/shared/constants/urls.dart';

class DioHttp {
  Dio _dio;

  DioHttp() {
    _dio = Dio();
    _dio.options.baseUrl = Urls().apiUrl;
    _dio.interceptors.add(InterceptorsWrapper(onError: _onError));
  }

  Dio get instance => _dio;

  Dio withAuth() {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onRespose, onError: _onError));

    return _dio;
  }

  _onRequest(RequestOptions options) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.get('token');
    // options.headers['Authorization'] = token;
  }

  _onRespose(Response e) {
    print(e.data);
  }

  _onError(DioError e) {
    print('########## Response Error');
  }
}
