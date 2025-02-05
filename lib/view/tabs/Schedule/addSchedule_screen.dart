import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/CustomTextField.dart';
import '../../../../widgets/customDateInput.dart';
import '../../../../widgets/custom_button.dart';
import '../../../utils/color_resources.dart';
import '../../../widgets/custom_dropdown.dart';
import 'addSchedule_vm.dart';

class AddScheduleScreen extends StatelessWidget {
  static const route = '/AddScheduleScreen';

  const AddScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddScheduleScreenVm>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Navigator.pop(context); // Navigate back to the HomeScreen
            },
          ),
          actions: [
            const Spacer(),
            const Spacer(),
            Text.rich(
              TextSpan(
                text: 'How am I ',
                style: const TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Driving?',
                    style: TextStyle(
                        fontSize: 23,
                        color: AppColors.TextMUSTARD_COLOR,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Handle notification tap
                    },
                    child: Image.asset(
                      'assets/images/bell-solid.png',
                      height: 21.h,
                      width: 23.h,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      // Handle profile tap
                    },
                    child: Image.asset(
                      'assets/images/person_icon.png',
                      height: 21.h,
                      width: 23.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
          elevation: 0,
          flexibleSpace: const SizedBox(),
          backgroundColor: AppColors.Text_COLOR,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Column(
              children: [
                SizedBox(height: 14.h),
                Center(
                  child: Text(
                    "Schedule Ride",
                    textAlign: TextAlign.center, // Centers the text itself
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'arial',
                      color: AppColors.Text_COLOR,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                CustomDropdown(
                  hintText: 'Driver\'s Name',
                  controllerValue: vm.driverNameController,
                  dropdownItems: vm.driverList, // ['Driver 1', 'Driver 2']
                  selectedValue: vm.driverNameController.text.isEmpty
                      ? vm.driverList[0]
                      : vm.driverNameController.text,
                  onChanged: (value) {
                    vm.driverNameController.text = vm.driverList[0];
                  },
                ),

                CustomTextField(
                  hintText: 'Driver\'s Id',
                  controllerValue: vm.driverIdController,
                ),
                CustomDropdown(
                  hintText: 'Vehicle\'s Name',
                  controllerValue: vm.vehicleNameController,
                  dropdownItems: vm.vehicleList,
                  selectedValue: vm.vehicleNameController.text.isEmpty
                      ? vm.vehicleList[0]
                      : vm.vehicleNameController.text,
                  onChanged: (value) {
                    vm.vehicleNameController.text = vm.vehicleList[0];
                  },
                ),
                CustomTextField(
                  hintText: 'Vehicle\'s Number',
                  controllerValue: vm.vehicleNumberController,
                ),
                CustomDateInputField(
                  controller: vm.dateController,
                  hintText: 'Date',
                ),
                CustomDropdown(
                  hintText: 'Time',
                  controllerValue: vm.timeController,
                  dropdownItems: vm.timeList,
                  selectedValue: vm.timeController.text.isEmpty
                      ? vm.timeList[0]
                      : vm.timeController.text,
                  onChanged: (value) {
                    vm.timeController.text = vm.timeList[0];
                  },
                ),

                CustomDropdown(
                  hintText: 'Task',
                  controllerValue: vm.taskController,
                  dropdownItems: vm.taskList,
                  selectedValue: vm.taskController.text.isEmpty
                      ? vm.taskList[0]
                      : vm.taskController.text,
                  onChanged: (value) {
                    vm.taskController.text = vm.taskList[0];
                  },
                ),
                CustomTextField(
                  hintText: 'Address',
                  controllerValue: vm.addressController,
                ),
                CustomDropdown(
                  hintText: 'Supervisor',
                  controllerValue: vm.supervisorController,
                  dropdownItems: vm.supervisorList,
                  selectedValue: vm.supervisorController.text.isEmpty
                      ? vm.supervisorList[0]
                      : vm.supervisorController.text,
                  onChanged: (value) {
                    vm.supervisorController.text = vm.supervisorList[0];
                  },
                ),
                CustomDropdown(
                  hintText: 'Allocated Time for Task',
                  controllerValue: vm.allocatedTimeController,
                  dropdownItems: vm.allocatedTimeList,
                  selectedValue: vm.allocatedTimeController.text.isEmpty
                      ? vm.allocatedTimeList[0]
                      : vm.allocatedTimeController.text,
                  onChanged: (value) {
                    vm.allocatedTimeController.text =
                        value ?? vm.allocatedTimeList[0];
                  },
                ),
                SizedBox(height: 20.h),

                // Submit Button
                CustomButton(
                  isLoading: vm.isLoading,
                  isEnabled: vm.isDataFilled,
                  buttonText: 'Add Ride',
                  onPressed: () {
                    // Implement the add ride functionality
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
