import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:how_am_i_driving/data/model/response/base/api_response.dart';
import 'package:how_am_i_driving/data/repo/auth_repo.dart';
import 'package:how_am_i_driving/view/tabs/Schedule/scheduleProfile_screen.dart';

class ViewScheduleScreenVm extends ChangeNotifier {
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

  onViewScheduleProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewScheduleProfileScreen.route);
  }
}
