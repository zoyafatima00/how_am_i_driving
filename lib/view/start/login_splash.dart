import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_splashlogin_button.dart';
import 'login_splash_vm.dart';

class LoginOptionScreen extends StatelessWidget {
  static const route = '/LoginOptionScreen';

  const LoginOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginOptionScreenVm>(
      builder: (context, vm, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.Text_COLOR,
          body: Center(
            // Centering the whole screen's content
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Ensures horizontal centering
                children: [
                  SizedBox(height: 22.h),
                  Image.asset(
                    'assets/images/white_car.png',
                    height: 125.h,
                  ),
                  SizedBox(height: 10.h),
                  const SizedBox(height: 23),
                  const Text(
                    'Login As',
                    style: TextStyle(
                      fontFamily: 'Arial', // Use Arial font family
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  CustomLoginOptionButton(
                    buttonText: 'Admin',
                    onPressed: () {
                      vm.goToAdminLogin(context);
                    },
                  ),
                  SizedBox(height: 22.h),
                  CustomLoginOptionButton(
                    buttonText: 'Driver',
                    onPressed: () {
                      vm.goToDriverLogin(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
