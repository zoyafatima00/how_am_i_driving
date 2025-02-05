import 'package:flutter/material.dart';

import '../../data/base_vm.dart';
import '../auth/login/login_screen.dart';

class SplashVm extends BaseVm {
  SplashVm();

  // We don't call navigation in the constructor anymore.
  void goToLogin(BuildContext context) {
    // We use this method for navigation now, which will be triggered after build.
    Future.delayed(const Duration(milliseconds: 3050), () {
      Navigator.pushReplacementNamed(context, LoginScreen.route);
    });
  }
}
