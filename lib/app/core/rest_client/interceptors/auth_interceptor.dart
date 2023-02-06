import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/context/global_context.dart';
import 'package:dw9_delivery_app/app/core/exceptions/token_expired_exception.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final CustomDio dio;

  AuthInterceptor(this.dio);

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
      try {
        if (err.requestOptions.path != '/auth/refresh') {
          await _refreshToken(err);
          await _retryRequest(err, handler);
        } else {
          GlobalContext.i.loginExpired();
        }
      } catch (e) {
        GlobalContext.i.loginExpired();
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken(DioError err) async {
    try {
      final sharedPefs = await SharedPreferences.getInstance();
      final refreshToken = sharedPefs.getString('refreshToken');

      if (refreshToken == null) {
        return;
      }

      final refreshResult = await dio.auth().put('/auth/refresh', data: {
        'refresh_token': refreshToken,
      });

      sharedPefs.setString('accessToken', refreshResult.data['access_token']);
      sharedPefs.setString('refreshToken', refreshResult.data['refresh_token']);
    } on DioError catch (e, s) {
      log('Erro ao renovar token.', error: e, stackTrace: s);
      throw TokenExpiredException(message: 'Erro ao renovar token.');
    }
  }

  Future<void> _retryRequest(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    final requestResult = await dio.request(
      requestOptions.path,
      options: Options(
        headers: requestOptions.headers,
        method: requestOptions.method,
      ),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: requestResult.data,
        statusCode: requestResult.statusCode,
        statusMessage: requestResult.statusMessage,
      ),
    );
  }
}
