import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../data/base_vm.dart';
import '../../../data/repo/auth_repo.dart';
import '../../../helpers/pref_init.dart';
import '../../../utils/shared_prefs_keys.dart';
import '../../../widgets/my_snackbar.dart';
import '../../bottom_nav/bottom_nav_screen.dart';
import '../../start/login_splash.dart';
import '../forgot_password/forgotPassword_screen.dart';
import '../signup/signup_screen.dart';

class LoginVm extends BaseVm {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  MyPrefs pref = MyPrefs();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _rememberMe = false;

  bool get isLoading => _isLoading;
  bool get isDataFilled =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  bool get rememberMe => _rememberMe;

  LoginVm() {
    emailController.addListener(() {
      notifyListeners();
    });
    passwordController.addListener(() {
      notifyListeners();
    });
  }

  void onBackArrow(BuildContext context) {
    Navigator.pushNamed(context, LoginOptionScreen.route);
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  void goToForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, ForgotPasswordScreen.route);
  }

  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, SignUpScreen.route);
  }

  void onLoginClicked(BuildContext context) {
    if (emailController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter email');
      return;
    }
    if (passwordController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter password');
      return;
    }

    Navigator.pushReplacementNamed(context, BottomNavScreen.route);

    // _loginUser(emailController.text, passwordController.text,
    //     (bool status, String message) {
    //   if (status) {
    //     Navigator.pushReplacementNamed(context, BottomNavScreen.route);
    //   } else {
    //     customMessageDialog(
    //       context: context,
    //       msg: message,
    //       isError: true,
    //       onTap: () => Navigator.pop(context),
    //     );
    //   }
    // });
  }

  Future<void> _loginUser(
      String email, String password, Function(bool, String) callback) async {
    _isLoading = true;
    notifyListeners();

    final response = await authRepo.loginDriver(email, password);
    if (response.response != null &&
        (response.response?.statusCode == 200 ||
            response.response?.statusCode == 201)) {
      final loginData = response.response?.data;
      await MyPrefs.setStringShared(SharedPrefsKeys.TOKEN, loginData["token"]);
      await MyPrefs.setStringShared(
          SharedPrefsKeys.USERNAME, loginData["username"]);
      await MyPrefs.setStringShared(
          SharedPrefsKeys.USERPROFILE, loginData["image"]);

      _isLoading = false;
      notifyListeners();
      callback(true, "Login Successful");
    } else {
      final errorMessage = response.error is String
          ? response.error.toString()
          : response.error.message[0];
      _isLoading = false;
      notifyListeners();
      callback(false, errorMessage);
    }
  }
}
