// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

class DioInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // await AppStorage.loadAuthToken();
    // options.headers['cookie'] = AppStorage.authToken;
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
