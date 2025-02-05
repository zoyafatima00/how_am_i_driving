import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/view/auth/signup/signup_vm.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/color_resources.dart';
import '../../../widgets/CustomTextField.dart';
import '../../../widgets/bg_container.dart';
import '../../../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  static const route = '/SignUpScreen';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpVm>(builder: (context, vm, _) {
      return BGContainer(
        child: Scaffold(
          // backgroundColor: Colors.transparent,
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
                      fontFamily: 'Arial', // Use Arial font family
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.Text_COLOR,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Step 1 of 2',
                    style: TextStyle(
                      fontFamily: 'Arial', // Use Arial font family
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.TextFIELD_EYE_COLOR,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Stack(clipBehavior: Clip.none, children: [
                    CircleAvatar(
                      backgroundColor: AppColors.TextFIELD_EYE_COLOR,
                      radius: 45.0.r,
                      child: vm.imageFile != null
                          ? Container(
                              height: 90.h,
                              width: 90.w,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
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
                            )))
                  ]),
                  SizedBox(
                    height: 15.0.h,
                  ),

                  // Form Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 5.0.h),
                            child: CustomTextField(
                              hintText: 'First Name',
                              controllerValue: vm.firstNameController,
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomTextField(
                              hintText: 'Last Name',
                              controllerValue: vm.lastNameController),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomTextField(
                              hintText: 'CNIC',
                              controllerValue: vm.cnicController),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomTextField(
                              hintText: 'Date of Birth',
                              controllerValue: vm.dobController),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: CustomTextField(
                              hintText: 'Address',
                              controllerValue: vm.raddressController),
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
                      buttonText: 'Next Step',
                      onPressed: () {
                        vm.onNextClicked(context);
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
