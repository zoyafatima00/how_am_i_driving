import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import '../../../widgets/CustomTextField.dart';
import '../../../widgets/customDateInput.dart';
import '../../../widgets/custom_button.dart';
import 'signup_vm.dart';

class SignUpScreen extends StatelessWidget {
  static const route = '/SignUpScreen';
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpVm>(builder: (context, vm, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Column(
              children: [
                SizedBox(height: 14.h),
                Center(
                  child: Text('Create an Account!',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.Text_COLOR,
                      )),
                ),
                SizedBox(height: 14.h),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.TextFIELD_EYE_COLOR,
                      radius: 45.0.r,
                      child: vm.imageFile != null
                          ? Container(
                              height: 90.h,
                              width: 90.w,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Image.file(
                                    vm.imageFile!,
                                    fit: BoxFit.fill,
                                  )))
                          : Icon(
                              Icons.person,
                              color: AppColors.Text_COLOR,
                              size: 65,
                            ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: -10,
                      child: InkWell(
                        onTap: () => vm.showSheet(context),
                        child: Image.asset(
                          'assets/images/signup_camera.png',
                          height: 35.h,
                          width: 35.w,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: 'Full Name',
                  controllerValue: vm.fullNameController,
                ),
                CustomTextField(
                  hintText: 'Email',
                  controllerValue: vm.emailController,
                ),
                CustomTextField(
                  hintText: 'CNIC',
                  controllerValue: vm.cnicController,
                ),
                CustomDateInputField(
                  hintText: 'Date Of Birth',
                  controller: vm.dobController,
                ),
                CustomTextField(
                  hintText: 'Address',
                  controllerValue: vm.raddressController,
                ),
                CustomTextField(
                  hintText: 'City',
                  controllerValue: vm.cityController,
                ),
                CustomTextField(
                  hintText: 'Contact Number',
                  controllerValue: vm.contactNumberController,
                ),
                CustomTextField(
                  hintText: 'Designation',
                  controllerValue: vm.designationController,
                ),
                CustomTextField(
                  hintText: 'Password',
                  controllerValue: vm.passwordController,
                  isPassword: true,
                ),
                CustomTextField(
                  hintText: 'Re-enter password',
                  controllerValue: vm.reenterPasswordController,
                  isPassword: true,
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  isLoading: vm.isLoading,
                  isEnabled: vm.isDataFilled,
                  buttonText: 'Sign Up',
                  onPressed: () {
                    vm.onSignUpClicked(context);
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
