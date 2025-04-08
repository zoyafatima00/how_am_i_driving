import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:how_am_i_driving/view/start/login_splash.dart';

import '../../../data/base_vm.dart';
import '../../../data/repo/auth_repo.dart';
import '../../../helpers/pref_init.dart';
import '../../../utils/shared_prefs_keys.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/my_snackbar.dart';
import '../../bottom_nav/admin_bottom_nav.dart';
import '../forgot_password/forgotPassword_screen.dart';
import '../signup/signup_screen.dart';

class AdminLoginVm extends BaseVm {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  MyPrefs pref = MyPrefs();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _rememberMe = false;

  bool get isLoading => _isLoading;
  bool get isDataFilled =>
      nameController.text.isNotEmpty && passwordController.text.isNotEmpty;
  bool get rememberMe => _rememberMe;

  AdminLoginVm() {
    nameController.addListener(() {
      notifyListeners();
    });
    passwordController.addListener(() {
      notifyListeners();
    });
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  void goToForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, ForgotPasswordScreen.route);
  }

  void onBackArrow(BuildContext context) {
    Navigator.pushNamed(context, LoginOptionScreen.route);
  }

  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, SignUpScreen.route);
  }

  void onAdminLoginClicked(BuildContext context) {
    if (nameController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter email');
      return;
    }
    if (passwordController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter password');
      return;
    }

    _loginUser(nameController.text, passwordController.text,
        (bool status, String message) {
      if (status) {
        Navigator.pushReplacementNamed(context, AdminBottomNavScreen.route);
      } else {
        customMessageDialog(
          context: context,
          msg: message,
          isError: true,
          onTap: () => Navigator.pop(context),
        );
      }
    });
  }

  Future<void> _loginUser(String full_name, String password,
      Function(bool, String) callback) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await authRepo.loginDriver(full_name, password);
      if (response.response != null) {
        if (response.response?.statusCode == 200 ||
            response.response?.statusCode == 201) {
          final loginData = response.response?.data;

          // Store full_name in SharedPreferences
          await MyPrefs.setStringShared(SharedPrefsKeys.FULL_NAME, full_name);

          callback(true, "Login Successful");
        } else if (response.response?.statusCode == 404) {
          callback(false, "Invalid credentials. Please try again.");
        } else {
          callback(false, "Something went wrong. Please try again.");
        }
      } else {
        final errorMessage = response.error is String
            ? response.error.toString()
            : response.error?.message?.toString() ??
                "Invalid credentials. Please try again.";
        callback(false, errorMessage);
      }
    } catch (e) {
      callback(false, "An error occurred. Please try again.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
