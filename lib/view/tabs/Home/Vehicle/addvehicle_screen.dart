import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_resources.dart';
import '../../../../widgets/CustomTextField.dart';
import '../../../../widgets/customDateInput.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dropdown.dart';
import 'addvehicle_vm.dart';

class AddVehicleScreen extends StatelessWidget {
  static const route = '/AddVehicleScreen';

  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddVehicleScreenVm>(builder: (context, vm, _) {
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Column(
              children: [
                SizedBox(height: 14.h),
                Center(
                  child: Text(
                    "Add Vehicle",
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
                CustomTextField(
                  hintText: 'Owner\'s Name',
                  controllerValue: vm.ownerNameController,
                ),
                CustomTextField(
                  hintText: 'Vehicle\'s Name',
                  controllerValue: vm.vehicleNameController,
                ),
                CustomTextField(
                  hintText: 'Model',
                  controllerValue: vm.modelController,
                ),
                CustomTextField(
                  hintText: 'Number',
                  controllerValue: vm.numberController,
                ),
                CustomTextField(
                  hintText: 'Engine Number',
                  controllerValue: vm.engineNumberController,
                ),
                // Vehicle Type Dropdown
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0.h),
                  child: CustomDropdown(
                    hintText: 'Vehicle Type',
                    controllerValue: vm.vehicleTypeController,
                    dropdownItems: vm.vehicleTypeList,
                    selectedValue: vm.vehicleTypeController.text.isEmpty
                        ? vm.vehicleTypeList[0] // default to first value
                        : vm.vehicleTypeController.text,
                    onChanged: (value) {
                      vm.vehicleTypeController.text =
                          value ?? vm.vehicleTypeList[0];
                    },
                  ),
                ),
                // Role Dropdown
                // Role Dropdown
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0.h),
                  child: CustomDropdown(
                    hintText: 'Role',
                    controllerValue: vm.roleController,
                    dropdownItems: vm.roleList, // Without 'Select' in the list
                    selectedValue: vm.roleController.text.isEmpty
                        ? vm.roleList[0] // default to 'Select' if it's empty
                        : vm.roleController.text,
                    onChanged: (value) {
                      vm.roleController.text =
                          value ?? vm.roleList[0]; // fallback to 'Select'
                    },
                  ),
                ),
                // Integration Radio Buttons
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Integration',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Arial',
                              color: AppColors.TextFIELD_EYE_COLOR)),
                      Row(
                        children: [
                          // GPS Radio Button
                          Radio<String>(
                              value: 'GPS',
                              groupValue: vm.integrationValue,
                              onChanged: (value) {
                                vm.integrationValue = value!;
                                vm.notifyListeners();
                              },
                              activeColor: vm.integrationValue == 'GPS'
                                  ? AppColors.Text_COLOR
                                  : AppColors
                                      .TextFIELD_EYE_COLOR // Black if selected, otherwise grey
                              ),
                          Text(
                            'GPS',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: vm.integrationValue == 'GPS'
                                    ? Colors.black
                                    : AppColors
                                        .TextFIELD_EYE_COLOR // Black if selected, otherwise grey
                                ),
                          ),
                          // Dashcam Radio Button
                          Radio<String>(
                              value: 'Dashcam',
                              groupValue: vm.integrationValue,
                              onChanged: (value) {
                                vm.integrationValue = value!;
                                vm.notifyListeners();
                              },
                              activeColor: vm.integrationValue == 'Dashcam'
                                  ? AppColors.Text_COLOR
                                  : AppColors
                                      .TextFIELD_EYE_COLOR // Black if selected, otherwise grey
                              ),
                          Text(
                            'Dashcam',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: vm.integrationValue == 'Dashcam'
                                  ? Colors.black
                                  : Colors
                                      .grey, // Black if selected, otherwise grey
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                CustomTextField(
                  hintText: 'Milage',
                  controllerValue: vm.milageController,
                ),
                CustomTextField(
                  hintText: 'Fuel Type',
                  controllerValue: vm.fuelTypeController,
                ),
                CustomDateInputField(
                  controller: vm.dateOfJoiningController,
                  hintText: 'Date of Joining',
                ),
                CustomTextField(
                  hintText: 'Added by',
                  controllerValue: vm.addedByController,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text('Add Images',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Arial',
                        color: AppColors.TextFIELD_EYE_COLOR)),
                SizedBox(
                  height: 8.h,
                ),
                // Image Section
                // Image Section for Rear and Front Images
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  child: Column(
                    children: [
                      // First row: Rear, Front, and Image 3
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Rear Image
                          Expanded(
                            child: vm.rearImage != null
                                ? Container(
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(vm.rearImage!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      vm.showSheet(context, 'rear');
                                    },
                                    child: Text('Rear'),
                                  ),
                          ),
                          SizedBox(width: 10),

                          // Front Image
                          Expanded(
                            child: vm.frontImage != null
                                ? Container(
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(vm.frontImage!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      vm.showSheet(context, 'front');
                                    },
                                    child: Text('Front'),
                                  ),
                          ),
                          SizedBox(width: 10),

                          // Image 3
                          Expanded(
                            child: vm.images[0] != null
                                ? Container(
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(vm.images[0]!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      vm.showSheet(context, 'image3');
                                    },
                                    child: Text('Image 3'),
                                  ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      // Second row: Image 4, Image 5, and Image 6
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image 4
                          Expanded(
                            child: vm.images[1] != null
                                ? Container(
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(vm.images[1]!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      vm.showSheet(context, 'image4');
                                    },
                                    child: Text('Image 4'),
                                  ),
                          ),
                          SizedBox(width: 10),

                          // Image 5
                          Expanded(
                            child: vm.images[2] != null
                                ? Container(
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(vm.images[2]!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      vm.showSheet(context, 'image5');
                                    },
                                    child: Text('Image 5'),
                                  ),
                          ),
                          SizedBox(width: 10),

                          // Image 6
                          Expanded(
                            child: vm.images[3] != null
                                ? Container(
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(vm.images[3]!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      vm.showSheet(context, 'image6');
                                    },
                                    child: Text('Image 6'),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
                CustomButton(
                  isLoading: vm.isLoading,
                  isEnabled: vm.isDataFilled,
                  buttonText: 'Add Vehicle',
                  onPressed: () {
                    vm.onAddVehicleClicked(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
