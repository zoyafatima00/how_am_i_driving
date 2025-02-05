import 'package:flutter/material.dart';

class AddScheduleScreenVm extends ChangeNotifier {
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
}
