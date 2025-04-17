import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import 'admin_login_vm.dart';

class AdminLoginScreen extends StatelessWidget {
  static const route = '/AdminLoginScreen';
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminLoginVm>(builder: (context, vm, _) {
      return GestureDetector(
        onTap: () => FocusScope.of(context)
            .unfocus(), // Dismiss keyboard when tapping outside
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.Text_COLOR),
              onPressed: () => vm.onBackArrow(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  20, // Add extra padding
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 600.w,
                  minHeight: MediaQuery.of(context)
                          .size
                          .height - // Ensure minimum height
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 22.h),
                      Image.asset(
                        'assets/images/login_logo.png',
                        height: 120.h,
                      ),
                      SizedBox(height: 10.h),
                      const SizedBox(height: 20),
                      Text('Welcome!',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.Text_COLOR,
                          )),
                      const SizedBox(height: 5),
                      Text(
                        'Login to your account',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: AppColors.TextFIELD_EYE_COLOR,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        hintText: 'Name',
                        controllerValue: vm.nameController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Password',
                        isPassword: true,
                        controllerValue: vm.passwordController,
                      ),
                      // ... rest of your widgets remain the same
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: vm.rememberMe,
                                onChanged: vm.toggleRememberMe,
                                activeColor: AppColors.Text_COLOR,
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => vm.goToForgotPassword(context),
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: AppColors.TextMUSTARD_COLOR,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      CustomButton(
                        buttonText: 'Login',
                        isEnabled: vm.isDataFilled,
                        isLoading: vm.isLoading,
                        onPressed: vm.isLoading
                            ? null
                            : () => vm.onAdminLoginClicked(context),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
