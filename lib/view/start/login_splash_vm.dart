import 'package:flutter/material.dart';

import '../../data/base_vm.dart';
import '../auth/login/admin_login_screen.dart';
import '../auth/login/login_screen.dart';

class LoginOptionScreenVm extends BaseVm {
  // We don't call navigation in the constructor anymore.
  void goToDriverLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, AdminLoginScreen.route);
  }

  void goToAdminLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginScreen.route);
  }
}
