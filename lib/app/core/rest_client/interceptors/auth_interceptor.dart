import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final accessToken = sharedPrefs.getString('accessToken');
    options.headers['Authorization'] = "Bearer $accessToken";

    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      //HOME
      final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.clear();

      handler.next(err);
    } else {
      handler.next(err);
    }
  }
}