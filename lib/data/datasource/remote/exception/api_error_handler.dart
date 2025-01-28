import 'package:dio/dio.dart';

import 'my_error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    try {
      if (error is Exception) {
        try {
          if (error is DioException) {
            switch (error.type) {
              case DioExceptionType.cancel:
                errorDescription = "Request to API server was cancelled";
                break;
              case DioExceptionType.connectionTimeout:
                errorDescription = "Connection timeout with API server";
                break;
              case DioExceptionType.unknown:
                errorDescription =
                    "Connection to API server failed due to internet connection";
                break;
              case DioExceptionType.receiveTimeout:
                errorDescription =
                    "Receive timeout in connection with API server";
                break;
              case DioExceptionType.badResponse:
                switch (error.response?.statusCode) {
                  case 404:
                    MyMethodErrorResponse myMethodErrorResponse =
                        MyMethodErrorResponse.fromJson(error.response?.data);
                    if (myMethodErrorResponse.message.isNotEmpty) {
                      errorDescription = myMethodErrorResponse;
                    } else {
                      dynamic mError = error.response?.data;
                      errorDescription = mError['error'];
                    }
                    break;
                  case 400:
                    MyMethodErrorResponse myMethodErrorResponse =
                        MyMethodErrorResponse.fromJson(error.response?.data);
                    if (myMethodErrorResponse.message.isNotEmpty) {
                      errorDescription = myMethodErrorResponse;
                    } else {
                      dynamic mError = error.response?.data;
                      errorDescription = mError['error'];
                    }
                    break;
                  case 500:
                  case 503:
                    errorDescription = error.response?.statusMessage;
                    break;
                  case 401:
                    MyMethodErrorResponse myMethodErrorResponse =
                        MyMethodErrorResponse.fromJson(error.response?.data);
                    if (myMethodErrorResponse.message.isNotEmpty) {
                      errorDescription = myMethodErrorResponse;
                    } else {
                      dynamic mError = error.response?.data;
                      errorDescription = mError['error'];
                    }
                    break;
                  case 402:
                    MyMethodErrorResponse myMethodErrorResponse =
                        MyMethodErrorResponse.fromJson(error.response?.data);
                    if (myMethodErrorResponse.message.isNotEmpty) {
                      errorDescription = myMethodErrorResponse;
                    } else {
                      errorDescription =
                          "Failed to load data - status code: ${error.response?.statusCode}";
                    }
                    break;
                  default:
                    try {
                      MyErrorResponse errorResponse =
                          MyErrorResponse.fromJson(error.response?.data);
                      if (errorResponse.message.isNotEmpty) {
                        errorDescription = errorResponse;
                      } else {
                        errorDescription =
                            "Something went wrong - status code: ${error.response?.statusCode}";
                      }
                    } catch (e) {
                      errorDescription =
                          "Unknown API error - status code: ${error.response?.statusCode}";
                    }
                }
                break;
              case DioExceptionType.sendTimeout:
                errorDescription = "Send timeout with server";
                break;
              default:
                errorDescription = "Unexpected error occurred";
            }
          } else {
            errorDescription = "Unexpected error occurred";
          }
        } on FormatException catch (e) {
          errorDescription = e.toString();
        }
      } else {
        errorDescription = "Error is not a subtype of Exception";
      }
    } catch (e) {
      errorDescription =
          "Something went wrong - status code: ${error is DioException ? error.response?.statusCode : 'Unknown'}";
    }
    return errorDescription;
  }
}
