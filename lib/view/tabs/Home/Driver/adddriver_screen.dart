import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_resources.dart';
import '../../../../widgets/CustomTextField.dart';
import '../../../../widgets/cnicFormatter.dart';
import '../../../../widgets/contactformat.dart';
import '../../../../widgets/customDateInput.dart';
import '../../../../widgets/custom_button.dart';
import 'adddriver_vm.dart';

class AddDriverScreen extends StatelessWidget {
  static const route = '/AddDriverScreen';

  const AddDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddDriverScreenVm>(builder: (context, vm, _) {
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
          child: Column(
            children: [
              SizedBox(height: 14.h),
              Center(
                child: Text(
                  "Add Driver",
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Wrap the CircleAvatar with Container to ensure a fixed size
                  Container(
                    width: 90.w, // Set width for the circle container
                    height: 90.h, // Set height for the circle container
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.TextFIELD_EYE_COLOR.withOpacity(0.4),
                    ),
                    child: Center(
                      child: vm.imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(360),
                              child: Image.file(
                                vm.imageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              color: AppColors.Text_COLOR,
                              size: 65,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: -10,
                    child: InkWell(
                      onTap: () => vm.showSheet(context),
                      child: Image.asset(
                        'assets/images/signup_camera.png',
                        color: AppColors.TextFIELD_EYE_COLOR.withOpacity(0.73),
                        height: 35.h,
                        width: 35.w,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomTextField(
                        hintText: 'First Name',
                        controllerValue: vm.firstNameController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomTextField(
                        hintText: 'Last Name',
                        controllerValue: vm.lastNameController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomTextField(
                        hintText: 'CNIC Number',
                        controllerValue: vm.cnicController,
                        inputFormatters: [
                          CnicInputFormatter()
                        ], // Apply the CNIC formatter here
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomDateInputField(
                        controller: vm.dobController,
                        hintText: 'Date of Birth',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomTextField(
                        hintText: 'Address',
                        controllerValue: vm.addressController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomTextField(
                        hintText: 'City',
                        controllerValue: vm.cityController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomTextField(
                        hintText: 'Contact Number',
                        controllerValue: vm.contactController,
                        inputFormatters: [
                          ContactNumberInputFormatter()
                        ], // Add your formatter here
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomTextField(
                        hintText: 'License Number ',
                        controllerValue: vm.licenseNumberController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomDateInputField(
                        hintText: 'Date of Issue',
                        controller: vm.doiController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomDateInputField(
                        hintText: 'Date of Expiry',
                        controller: vm.doeController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: CustomTextField(
                        hintText: 'Experience',
                        controllerValue: vm.experienceController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0.h),

              // Button Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: CustomButton(
                  isLoading: vm.isLoading,
                  isEnabled: vm.isDataFilled,
                  buttonText: 'Add Driver',
                  onPressed: () {
                    //vm.onNextClicked(context);
                  },
                ),
              ),
              SizedBox(height: 20.0.h),
            ],
          ),
        ),
      );
    });
  }
}
