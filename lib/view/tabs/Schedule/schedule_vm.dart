import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:how_am_i_driving/data/model/response/base/api_response.dart';
import 'package:how_am_i_driving/data/repo/auth_repo.dart';
import 'package:how_am_i_driving/view/tabs/Schedule/scheduleProfile_screen.dart';

class ScheduleScreenVm extends ChangeNotifier {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  List<Map<String, dynamic>> _rideList = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get rideList => _rideList;
  bool get isLoading => _isLoading;

  // Method to fetch ride details from the API
  Future<void> fetchRideDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      ApiResponse apiResponse = await authRepo.getRideList();
      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        // Parse the response data
        _rideList = List<Map<String, dynamic>>.from(apiResponse.response?.data);
      } else {
        // Handle API error
        throw Exception("Failed to fetch ride details");
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to fetch detailed ride information
  Future<Map<String, dynamic>> fetchDetailedRideInfo({
    required String vehicleName,
    required String driverName,
    required String address,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      ApiResponse apiResponse = await authRepo.getRideDetails(
        vehicleName: vehicleName,
        driverName: driverName,
        address: address,
      );

      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        // Parse the response data
        return Map<String, dynamic>.from(apiResponse.response?.data);
      } else {
        // Handle API error
        throw Exception("Failed to fetch detailed ride information");
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  onViewScheduleProfileClicked(
      BuildContext context, Map<String, dynamic> ride) async {
    try {
      // Fetch detailed ride information
      Map<String, dynamic> detailedRideInfo = await fetchDetailedRideInfo(
        vehicleName: ride['vehicle_name'],
        driverName: ride['driver_name'],
        address: ride['address'],
      );

      // Navigate to the profile screen with the detailed ride information
      Navigator.pushNamed(
        context,
        ViewScheduleProfileScreen.route,
        arguments: detailedRideInfo,
      );
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch ride details: $e")),
      );
    }
  }
}
