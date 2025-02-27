import 'package:flutter/material.dart';
import 'package:how_am_i_driving/view/start/login_splash.dart';

import '../../data/base_vm.dart';

class SplashVm extends BaseVm {
  // We don't call navigation in the constructor anymore.
  void goToLoginOption(BuildContext context) {
    // We use this method for navigation now, which will be triggered after build.
    Future.delayed(const Duration(milliseconds: 3050), () {
      Navigator.pushReplacementNamed(context, LoginOptionScreen.route);
    });
  }
}
