import 'dart:io';

import 'package:dio/dio.dart';
import 'package:how_am_i_driving/data/model/body/addDriverBody.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_end_points.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/addRideBody.dart';
import '../model/body/resetPasswordBody.dart';
import '../model/body/signUpBody.dart';
import '../model/response/base/api_response.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> signUpUser(SignUpBody body) async {
    try {
      final response =
          await dioClient.post(ApiEndPoints.SIGNUP_URI, data: body.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addDriver(AddDriverBody body, File imageFile) async {
    try {
      // Create FormData object with fields and file
      final formData = FormData.fromMap({
        ...body.toJson(), // Spread all fields from the body
        "profile_picture": await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_picture.jpg', // Optional: Provide a filename
        ),
      });

      // Send POST request with the correct content type (multipart/form-data)
      final response =
          await dioClient.post(ApiEndPoints.ADDDRIVER_URI, data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getAdminNames() async {
    try {
      final response = await dioClient.get(ApiEndPoints.ADMIN_NAMES_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // Fetch profile picture for a specific admin ID
  Future<ApiResponse> getProfilePicture(String adminId) async {
    try {
      final response = await dioClient.get(
        '${ApiEndPoints.ADMIN_PROFILE_PICTURE_URI}/$adminId/profile-picture', // Ensure the correct endpoint
        options: Options(responseType: ResponseType.bytes), // Fetch as bytes
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getAdminDetails(String name) async {
    try {
      final response = await dioClient.get(
        ApiEndPoints.ADMIN_DETAILS_URI,
        queryParameters: {'name': name}, // Pass the name as a query parameter
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //vehicle

  Future<ApiResponse> addVehicle(FormData formData) async {
    try {
      // Send POST request with the correct content type (multipart/form-data)
      final response = await dioClient.post(
        ApiEndPoints.ADD_VEHICLE_URI,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data', // Ensure the correct content type
        ),
      );

      // Log the API response for debugging
      print("API Response: ${response.data}");

      // Return the API response with success
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      // Handle Dio errors (e.g., 422 Unprocessable Entity)
      if (e.response?.statusCode == 422) {
        // Log the validation errors
        print("Validation Errors: ${e.response?.data}");
        return ApiResponse.withError(
          e.response?.data['message'] ??
              "Validation error: Please check your input.",
        );
      } else {
        // Handle other Dio errors
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    } catch (e) {
      // Handle any other exceptions
      return ApiResponse.withError("An unexpected error occurred: $e");
    }
  }

  Future<ApiResponse> getVehicleNames() async {
    try {
      final response = await dioClient.get(ApiEndPoints.VEHICLE_NAMES_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getVehicleImage(
      String vehicleNumber, String imageType) async {
    try {
      // Correct URL construction with query parameters
      final url =
          '${ApiEndPoints.VEHICLE_PROFILE_PICTURE_URI}?vehicle_number=$vehicleNumber&image_type=$imageType';

      final response = await dioClient.get(
        url,
        options: Options(responseType: ResponseType.bytes), // Fetch as bytes
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getVehicleDetails({String? name, int? vehicleId}) async {
    try {
      final response = await dioClient.get(
        ApiEndPoints.VEHICLE_DETAILS_URI,
        queryParameters: {
          if (name != null) 'name': name,
          if (vehicleId != null) 'vehicle_id': vehicleId,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //ride
  Future<ApiResponse> addRide(AddRideBody body) async {
    try {
      // Send POST request with the correct content type (multipart/form-data)
      final response = await dioClient.post(
        ApiEndPoints.ADD_RIDE_URI,
        data: body.toJson(),
        options: Options(
          contentType: 'application/json', // Ensure the correct content type
        ),
      );

      // Log the API response for debugging
      print("API Response: ${response.data}");

      // Return the API response with success
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      // Handle Dio errors (e.g., 422 Unprocessable Entity)
      if (e.response?.statusCode == 422) {
        // Log the validation errors
        print("Validation Errors: ${e.response?.data}");
        return ApiResponse.withError(
          e.response?.data['message'] ??
              "Validation error: Please check your input.",
        );
      } else {
        // Handle other Dio errors
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    } catch (e) {
      // Handle any other exceptions
      return ApiResponse.withError("An unexpected error occurred: $e");
    }
  }

  Future<ApiResponse> getRideList() async {
    try {
      final response = await dioClient.get(ApiEndPoints.RIDE_LIST_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRideDetails(
      {String? vehicleName, String? driverName, String? address}) async {
    try {
      final response = await dioClient.get(
        ApiEndPoints.RIDE_DETAILS_URI,
        queryParameters: {
          if (vehicleName != null) 'vehicle_name': vehicleName,
          if (driverName != null) 'driver_name': driverName,
          if (address != null) 'address': address,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //login
  Future<ApiResponse> loginUser(String email, String password) async {
    try {
      final response = await dioClient.post(ApiEndPoints.LOGIN_URI,
          data: {"email": email, "password": password});
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
