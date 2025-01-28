import 'dart:developer';

import 'package:dio/dio.dart';

/// [LogInterceptor] is used to print logs during network requests.
/// It's better to add [LogInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('*** Request ***');
    _printKV('uri', options.uri);
    options.headers;

    if (request) {
      _printKV('method', options.method);
      _printKV('responseType', options.responseType.toString());
      _printKV('followRedirects', options.followRedirects);
      _printKV('connectTimeout', options.connectTimeout);
      _printKV('sendTimeout', options.sendTimeout);
      _printKV('receiveTimeout', options.receiveTimeout);
      _printKV(
          'receiveDataWhenStatusError', options.receiveDataWhenStatusError);
      _printKV('extra', options.extra);
    }
    if (requestHeader) {
      log('headers:');
      options.headers.forEach((key, v) => _printKV(' $key', v));
    }
    if (requestBody) {
      log('data:');
      _printAll(options.data);
    }
    log('');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // log('*** Response ***');
    // _printResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (error) {
      log('*** DioError ***:');
      log('uri: ${err.requestOptions.uri}');
      log('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      }
      log('');
    }

    handler.next(err);
  }

  void _printResponse(Response response) {
    _printKV('uri', response.requestOptions.uri);
    if (responseHeader) {
      _printKV('statusCode', response.statusCode);
      if (response.isRedirect == true) {
        _printKV('redirect', response.realUri);
      }

      log('headers:');
      response.headers.forEach((key, v) => _printKV(' $key', v.join('\r\n\t')));
    }
    if (responseBody) {
      log('Response Text:');
      _printAll(response.toString());
    }
    log('');
  }

  void _printKV(String key, Object? v) {
    log('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(log);
  }
}


/*
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("--> ${options.method} ${options.baseUrl + options.path}");
    print("Headers: ${options.headers.toString()}");
    log("Params: ${json.encode(options.data)}");
    print("<-- END HTTP");

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.baseUrl + response.requestOptions.path}  ${response.headers}  ${response.requestOptions.data}");

    String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }

    print("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    return super.onError(err, handler);
  }
}
*/
