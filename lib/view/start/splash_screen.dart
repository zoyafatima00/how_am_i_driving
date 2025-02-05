import 'package:flutter/material.dart';
import 'package:how_am_i_driving/view/start/splash_vm.dart';
import 'package:provider/provider.dart';

import '../../utils/color_resources.dart';
import '../../widgets/bg_container.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // Using Consumer to access SplashVm
    return Consumer<SplashVm>(
      builder: (context, vm, _) {
        // Use WidgetsBinding to trigger navigation after the current build is finished
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Call the method to navigate after the widget has been built
          vm.goToLogin(context);
        });

        return Scaffold(
          backgroundColor: AppColors.PRIMARY_COLOR,
          body: BGContainer(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Image.asset(
                  'assets/images/splash.png',
                  height: 430,
                  width: 700,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
