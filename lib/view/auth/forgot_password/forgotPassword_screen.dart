import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../widgets/bg_container.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import 'forgotPassword_vm.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const route = '/ForgotPasswordScreen';

  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordVm>(builder: (context, vm, _) {
      return BGContainer(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.w, 50.h, 0, 0),
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
                  height: 20.h,
                ),
                Container(
                  height: 200.h,
                  width: 200.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffF7FBFF).withOpacity(0.30),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
                    child: Image.asset(
                      'assets/images/forgotpassword.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                Text(
                  'Forgot Password?',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Please Enter Your Registered Email Address',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                    hintText: 'Your Email',
                    controllerValue: vm.emailController),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  isLoading: vm.isLoading,
                  isEnabled: vm.isDataFilled,
                  buttonText: 'Submit',
                  onPressed: vm.isLoading
                      ? null
                      : () {
                          //vm.goToVerification(context);
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
