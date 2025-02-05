import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/base_vm.dart';

class ForgotPasswordVm extends BaseVm {
  //AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  final bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool get isDataFilled => emailController.text.isNotEmpty;

  TextEditingController emailController = TextEditingController();

  ForgotPasswordVm() {
    emailController.addListener(() {
      notifyListeners();
    });
  }

  // goToVerification(BuildContext context) {
  //   if (emailController.text.isEmpty) {
  //     customSnack(
  //       context: context,
  //       color: Colors.white.withOpacity(0.3),
  //       text: 'Please enter your email',
  //     );
  //     return;
  //   }
  //   forgettingPassword(emailController.text.toString(),
  //       (bool status, String mssg) {
  //     if (status) {
  //       customSnack(
  //           context: context,
  //           color: Colors.green,
  //           text: 'Code sent to ${emailController.text.trim()}');
  //       Navigator.pushNamed(context, VerificationScreen.route);
  //     } else {
  //       customMessageDialog(
  //         context: context,
  //         msg: mssg,
  //         isError: true,
  //         onTap: () => Navigator.pop(context),
  //       );
  //     }
  //   });
  // }
  //
  // //API CALLS
  // forgettingPassword(String email, Function callBack) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   ApiResponse apiResponse = await authRepo.forgotPassword(email);
  //   if (apiResponse.response != null &&
  //           apiResponse.response?.statusCode == 200 ||
  //       apiResponse.response?.statusCode == 201) {
  //     callBack(true, "Code send");
  //     await MyPrefs.setStringShared(SharedPrefsKeys.OTPEMAIL, email);
  //     _isLoading = false;
  //     notifyListeners();
  //   } else {
  //     String? errorMessage;
  //     if (apiResponse.error is String) {
  //       errorMessage = apiResponse.error.toString();
  //     } else {
  //       MyErrorResponse errorResponse = apiResponse.error;
  //       errorMessage = errorResponse.message[0];
  //     }
  //     _isLoading = false;
  //     callBack(false, errorMessage);
  //     notifyListeners();
  //   }
  // }
}
