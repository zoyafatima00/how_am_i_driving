import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../widgets/CustomTextField.dart';
import '../../../widgets/bg_container.dart';
import '../../../widgets/custom_button.dart';
import 'ResetPassword_vm.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const route = '/ResetPasswordScreen';

  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ResetPasswordVm>(builder: (context, vm, _) {
      return Scaffold(
        body: BGContainer(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.0.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          radius: 18.r,
                          child: const Icon(Icons.arrow_back_outlined,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 23.0.h,
                ),
                Text('Set Your New Password',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Please Enter Your New Password',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                    isPassword: true,
                    hintText: 'Create A New Password',
                    controllerValue: vm.newPasswordController),
                Padding(
                  padding: EdgeInsets.only(top: 10.0.h),
                  child: CustomTextField(
                      isPassword: true,
                      hintText: 'Repeat Password',
                      controllerValue: vm.repeatPasswordController),
                ),
                SizedBox(
                  height: 25.sp,
                ),
                CustomButton(
                  isLoading: vm.isLoading,
                  isEnabled: vm.isDataFilled,
                  buttonText: 'Reset Password',
                  onPressed: () {
                    vm.onResetPasswordClicked(context);
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
