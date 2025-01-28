import 'package:flutter/material.dart';
import 'package:how_am_i_driving/view/start/splash_vm.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../utils/color_resources.dart';
import '../../widgets/bg_container.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashVm>(
      builder: (context, vm, _) => Scaffold(
        backgroundColor: AppColors.WHITE,
        body: BGContainer(
          child: Center(
            child: Image.asset(
              'assets/images/splash.png',
            ),
          ),
        ),
      ),
    );
  }
}
