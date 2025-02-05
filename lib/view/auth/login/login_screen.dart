import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import 'login_vm.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginVm>(builder: (context, vm, _) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 22.h),
                  Image.asset(
                    'assets/images/login_logo.png',
                    height: 120.h,
                  ),
                  SizedBox(height: 10.h),
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'How am I ',
                  //     style: GoogleFonts.nunito(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.teal[700],
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: 'Driving?',
                  //         style: GoogleFonts.nunito(
                  //           fontSize: 24,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.amber[700],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontFamily: 'Arial', // Use Arial font family
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.Text_COLOR,
                    ),
                  ),

                  const SizedBox(height: 5),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontFamily: 'Arial', // Use Arial font family
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.TextFIELD_EYE_COLOR,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'UserName',
                controllerValue: vm.emailController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Password',
                isPassword: true,
                controllerValue: vm.passwordController,
              ),
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
                      )
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
                onPressed:
                    vm.isLoading ? null : () => vm.onLoginClicked(context),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppColors.TextFIELD_EYE_COLOR),
                  ),
                  InkWell(
                    onTap: () => vm.goToSignUp(context),
                    child: Text(
                      'Create an account.',
                      style: TextStyle(
                        color: AppColors.TextMUSTARD_COLOR,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: AppColors.TextFIELD_EYE_COLOR, // Line color
                      thickness: 2, // Line thickness
                      endIndent: 8, // Space at the end of the line
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or Signup using",
                      style: TextStyle(color: AppColors.TextFIELD_EYE_COLOR),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.TextFIELD_EYE_COLOR, // Line color
                      thickness: 2, // Line thickness
                      indent: 8, // Space at the start of the line
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset('assets/images/facebook_icon.png'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/google.png'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/twitter icon.png'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
