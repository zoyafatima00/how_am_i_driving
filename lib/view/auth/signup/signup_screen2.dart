import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/view/auth/signup/signup_two_vm.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/color_resources.dart';
import '../../../widgets/CustomTextField.dart';
import '../../../widgets/bg_container.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown.dart';

class SignUpTwoScreen extends StatelessWidget {
  static const route = '/SignUpTwoScreen';

  const SignUpTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpTwoVm>(builder: (context, vm, _) {
      return BGContainer(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 60.h, bottom: 10.h),
              height: AppConstants.getScreenHeight(context),
              width: AppConstants.getScreenWidth(context),
              child: Column(
                children: [
                  // Title Section
                  SizedBox(
                    height: 35.h,
                  ),
                  Text(
                    'Create an account!',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.Text_COLOR,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Step 2 of 2',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.TextFIELD_EYE_COLOR,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  // Form Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      children: [
                        // City Dropdown
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomDropdown(
                              hintText: 'City',
                              controllerValue: vm.cityController,
                              dropdownItems: vm.cityList,
                              selectedValue: vm.cityController.text.isEmpty
                                  ? vm.cityList[0] // default to first value
                                  : vm.cityController.text,
                              onChanged: (value) {
                                vm.cityController.text =
                                    value ?? vm.cityList[0];
                              }),
                        ),
                        // Contact Number Text Field
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomTextField(
                              hintText: 'Contact Number',
                              controllerValue: vm.contactNumberController),
                        ),
                        // Designation Dropdown
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomDropdown(
                              hintText: 'Designation',
                              controllerValue: vm.designationController,
                              dropdownItems: vm.designationList,
                              selectedValue:
                                  vm.designationController.text.isEmpty
                                      ? vm.designationList[
                                          0] // default to first value
                                      : vm.designationController.text,
                              onChanged: (value) {
                                vm.designationController.text =
                                    value ?? vm.designationList[0];
                              }),
                        ),
                        // Password Text Field
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomTextField(
                              hintText: 'Password',
                              controllerValue: vm.passwordController,
                              isPassword: true),
                        ),
                        // Re-enter Password Text Field
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomTextField(
                              hintText: 'Re-enter password',
                              controllerValue: vm.reenterPasswordController,
                              isPassword: true),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),

                  // Button Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: CustomButton(
                      isLoading: vm.isLoading,
                      isEnabled: vm.isDataFilled,
                      buttonText: 'SignUp',
                      onPressed: () {
                        vm.onCreateAccountClicked(context);
                      },
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already Have An Account?',
                        style: TextStyle(color: AppColors.TextFIELD_EYE_COLOR),
                      ),
                      TextButton(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.TextMUSTARD_COLOR,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          vm.goToSignIn(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
