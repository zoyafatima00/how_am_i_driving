import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../data/base_vm.dart';
import '../../../data/model/body/resetPasswordBody.dart';
import '../../../data/model/response/base/api_response.dart';
import '../../../data/repo/auth_repo.dart';
import '../../../helpers/pref_init.dart';
import '../../../utils/shared_prefs_keys.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/my_snackbar.dart';
import '../forgot_password/forgotPassword_screen.dart';
import '../login/login_screen.dart';

class ResetPasswordVm extends BaseVm {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  ResetPasswordBody? _resetPasswordBody;

  bool _isLoading = false;
  ResetPasswordBody? get body => _resetPasswordBody;

  bool get isLoading => _isLoading;
  bool get isDataFilled =>
      newPasswordController.text.isNotEmpty &&
      repeatPasswordController.text.isNotEmpty;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  ResetPasswordVm(BuildContext context) {
    initializer(context);
    newPasswordController.addListener(() {
      notifyListeners();
    });
    repeatPasswordController.addListener(() {
      notifyListeners();
    });
  }
  initializer(BuildContext context) {
    Future.delayed(const Duration(minutes: 30), () {
      customSnack(
          context: context, color: Colors.red, text: 'Token has been expired');
      Navigator.pushNamedAndRemoveUntil(
          context, ForgotPasswordScreen.route, (route) => false);
    });
  }

  onResetPasswordClicked(BuildContext context) async {
    if (newPasswordController.text.isEmpty) {
      customSnack(
          context: context, color: Colors.red, text: 'Please enter password');
      return;
    }
    if (repeatPasswordController.text.isEmpty) {
      customSnack(
          context: context,
          color: Colors.red,
          text: 'Please enter Repeat Password');
      return;
    }
    if (newPasswordController.text.length < 6) {
      customSnack(
          context: context,
          color: Colors.red,
          text: 'Password length must be of 6 characters');
      return;
    }
    if (newPasswordController.text != repeatPasswordController.text) {
      customSnack(
          context: context, color: Colors.red, text: 'Password not matched');
      return;
    }
    String? email = await MyPrefs.getStringShared(SharedPrefsKeys.OTPEMAIL);
    ResetPasswordBody body = ResetPasswordBody(
        email: email,
        newPassword: newPasswordController.text,
        confirmPassword: repeatPasswordController.text);
    await resetPassword(body, (bool status, String msg) {
      if (status) {
        customMessageDialog(
          context: context,
          msg: msg,
          isError: false,
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.route, (route) => false);
          },
        );
      } else {
        customMessageDialog(context: context, msg: msg, isError: true);
      }
    });
  }

  //API CALLS
  resetPassword(ResetPasswordBody body, Function callBack) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.resetPassword(body);
    if (apiResponse.response != null &&
            apiResponse.response?.statusCode == 200 ||
        apiResponse.response?.statusCode == 201) {
      callBack(true, "Your password is updated!");
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      notifyListeners();
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        dynamic errorResponse = apiResponse.error;
        errorMessage = errorResponse.message;
      }
      callBack(false, errorMessage!);
      _isLoading = false;
      notifyListeners();
    }
  }
}
