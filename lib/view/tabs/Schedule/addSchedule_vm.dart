import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:how_am_i_driving/data/model/body/addRideBody.dart'; // Ensure this import exists
import 'package:how_am_i_driving/data/model/response/base/api_response.dart';
import 'package:how_am_i_driving/data/repo/auth_repo.dart';
import 'package:how_am_i_driving/widgets/custom_dialog.dart';
import 'package:how_am_i_driving/widgets/my_snackbar.dart';

import '../../../data/model/response/addRideResponse.dart';

class AddScheduleScreenVm extends ChangeNotifier {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  AddRideResponse? _response;

  AddRideResponse? get response => _response;
  bool _isLoading = false;

  // Controllers for form fields
  TextEditingController driverNameController = TextEditingController();
  TextEditingController driverIdController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController supervisorController = TextEditingController();
  TextEditingController allocatedTimeController = TextEditingController();

  // Dropdown lists
  List<String> driverList = ['Driver\'s Name', 'Driver 1', 'Driver 2'];
  List<String> vehicleList = ['Vehicle\'s Name', 'Vehicle 1', 'Vehicle 2'];
  List<String> timeList = ['Time', '10:00 AM', '12:00 PM', '2:00 PM'];
  List<String> taskList = ['Task', 'Task 1', 'Task 2'];
  List<String> supervisorList = ['Supervisor', 'Supervisor 1', 'Supervisor 2'];
  List<String> allocatedTimeList = [
    'Allocated Time for Task',
    '1 Hour',
    '2 Hours'
  ];

  AddScheduleScreenVm() {
    // Add listeners to all controllers
    driverNameController.addListener(_updateButtonState);
    driverIdController.addListener(_updateButtonState);
    vehicleNameController.addListener(_updateButtonState);
    vehicleNumberController.addListener(_updateButtonState);
    dateController.addListener(_updateButtonState);
    timeController.addListener(_updateButtonState);
    taskController.addListener(_updateButtonState);
    addressController.addListener(_updateButtonState);
    supervisorController.addListener(_updateButtonState);
    allocatedTimeController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    // Dispose of all controllers
    driverNameController.dispose();
    driverIdController.dispose();
    vehicleNameController.dispose();
    vehicleNumberController.dispose();
    dateController.dispose();
    timeController.dispose();
    taskController.dispose();
    addressController.dispose();
    supervisorController.dispose();
    allocatedTimeController.dispose();
    super.dispose();
  }

  bool get isLoading => _isLoading;

  bool get isDataFilled =>
      driverNameController.text.isNotEmpty &&
      driverIdController.text.isNotEmpty &&
      vehicleNameController.text.isNotEmpty &&
      vehicleNumberController.text.isNotEmpty &&
      dateController.text.isNotEmpty &&
      timeController.text.isNotEmpty &&
      taskController.text.isNotEmpty &&
      addressController.text.isNotEmpty &&
      supervisorController.text.isNotEmpty &&
      allocatedTimeController.text.isNotEmpty;

  // Method to update the button state
  void _updateButtonState() {
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to handle the "Add Ride" button click
  void onAddRideClicked(BuildContext context) async {
    if (!isDataFilled) {
      customSnack(
        context: context,
        color: Colors.red,
        text: 'Please fill all fields',
      );
      return;
    }

    // Create the AddRideBody object
    AddRideBody body = AddRideBody(
      driverName: driverNameController.text,
      driverId: driverIdController.text,
      vehicleName: vehicleNameController.text,
      vehicleNumber: vehicleNumberController.text,
      date: dateController.text, // Ensure the date is in "dd/MM/yyyy" format
      time: timeController.text,
      task: taskController.text,
      address: addressController.text,
      supervisor: supervisorController.text,
      allocatedTimeForTask: allocatedTimeController.text,
    );

    // Call the API to add the ride
    await addNewRide(body, (bool status, String msg) {
      if (status) {
        customSnack(context: context, color: Colors.green, text: msg);
        // Navigate to another screen or reset the form
        Navigator.pushReplacementNamed(context, '/BottomNavScreen');
      } else {
        customMessageDialog(
          context: context,
          msg: msg,
          isError: true,
          onTap: () => Navigator.pop(context),
        );
      }
    });
  }

  // API call for adding a new ride
  Future<void> addNewRide(AddRideBody body, Function callBack) async {
    _isLoading = true;
    notifyListeners();

    // Call the repository method to add the ride
    ApiResponse apiResponse = await authRepo.addRide(body);

    if (apiResponse.response != null &&
        (apiResponse.response?.statusCode == 200 ||
            apiResponse.response?.statusCode == 201)) {
      // Success
      _response = AddRideResponse.fromJson(apiResponse.response?.data);
      callBack(true, "Ride Added Successfully");
    } else {
      // Error
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        dynamic errorResponse = apiResponse.error;
        errorMessage = errorResponse.message;
      }
      callBack(false, errorMessage ?? "Something went wrong");
    }

    _isLoading = false;
    notifyListeners();
  }
}
