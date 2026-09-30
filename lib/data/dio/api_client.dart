import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'api_response.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {"Content-Type": "application/json"},
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    T Function(dynamic json)? fromJsonT,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
        options: Options(headers: headers),
      );

      return ApiResponse.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    T Function(dynamic json)? fromJsonT,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          headers: headers,
        ),
      );

      return ApiResponse.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      print(e.error);
      if (e.response != null && e.response?.data != null) {
        return ApiResponse.fromJson(e.response!.data, fromJsonT);
      }

      return ApiResponse(
        code: 500,
        message: e.message ?? 'Unknown error',
        status: false,
        body: null,
      );
    }
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    T Function(dynamic json)? fromJsonT,
  }) async {
    try {
      final response = await _dio.put(path, data: data);

      return ApiResponse.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String path,
    T Function(dynamic json)? fromJsonT,
  ) async {
    try {
      final response = await _dio.delete(path);

      return ApiResponse.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  ApiResponse<T> _handleError<T>(DioException e) {
    return ApiResponse(
      code: e.response?.statusCode ?? 500,
      message: e.response?.statusMessage ?? e.message ?? "Server error",
      status: false,
      body: null,
    );
  }
}
