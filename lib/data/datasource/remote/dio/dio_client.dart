import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor? loggingInterceptor;
  final SharedPreferences? sharedPreferences;

  showLog(String text) {
    if (kDebugMode) {
      log(text);
    }
  }

  late Dio dio;
  String? token;
  late String countryCode;

  DioClient(
    this.baseUrl,
    Dio dioC, {
    this.loggingInterceptor,
    this.sharedPreferences,
  }) {
    // token = sharedPreferences?.getString(SharedPrefsKeys.TOKEN);
    print('token in inti $token');

    dio = dioC;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 30000)
      ..options.receiveTimeout = const Duration(milliseconds: 30000)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
    dio.interceptors.add(loggingInterceptor!);
  }

  void updateToken() {
    // updateHeader(getUserObject()?.jwtToken, null);
  }

  void updateHeader(String? token, String? countryCode) {
    // token = token ?? this.token;
    countryCode = countryCode == null
        ? this.countryCode == 'US'
            ? 'en'
            : this.countryCode.toLowerCase()
        : countryCode == 'US'
            ? 'en'
            : countryCode.toLowerCase();
    this.token = token;
    this.countryCode = countryCode;
    print('===Country code====>$countryCode token=>$token');
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      showLog(
          'Uri ${dio.options.baseUrl}$uri \nheaders ${dio.options.headers} \nqueryParameters $queryParameters \nResponse $response');

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e, s) {
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      showLog(
          'Uri ${dio.options.baseUrl}$uri \nheaders ${dio.options.headers} \ndata $data \nResponse $response');

      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      showLog(
          'Uri ${dio.options.baseUrl}$uri \nheaders ${dio.options.headers} \ndata $data \nResponse $response');

      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      showLog(
          'Uri ${dio.options.baseUrl}$uri \nheaders ${dio.options.headers} \ndata $data \nResponse $response');

      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<MultipartFile> multipartFile(
    String uri,
    File file, {
    data,
  }) async {
    try {
      var response = await MultipartFile.fromFile(
        uri,
        filename: data,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
