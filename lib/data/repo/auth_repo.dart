import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_end_points.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/resetPasswordBody.dart';
import '../model/body/signUpBody.dart';
import '../model/response/base/api_response.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> loginUser(String email, String password) async {
    try {
      final response = await dioClient.post(ApiEndPoints.LOGIN_URI,
          data: {"email": email, "password": password});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> signUpUser(SignUpBody body) async {
    try {
      final response =
          await dioClient.post(ApiEndPoints.SIGNUP_URI, data: body.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> forgotPassword(String email) async {
    try {
      final response = await dioClient
          .post(ApiEndPoints.FORGOTPASSWOTRD_URI, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> VarifyOtp(String email, String otp) async {
    try {
      final response = await dioClient
          .post(ApiEndPoints.VERIFYOTP_URI, data: {"email": email, "otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(ResetPasswordBody body) async {
    try {
      final response = await dioClient.post(ApiEndPoints.RESETPASSWORD_URI,
          data: body.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
