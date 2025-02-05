import 'dart:convert'; // Import this for Base64 encoding
import 'dart:io'; // Import for File

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/base_vm.dart';
import '../../../data/model/body/signUpBody.dart';
import '../../../data/model/response/base/api_response.dart';
import '../../../data/model/response/signUpResponse.dart';
import '../../../data/repo/auth_repo.dart';
import '../../../helpers/pref_init.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/shared_prefs_keys.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/my_snackbar.dart';
import '../../bottom_nav/bottom_nav_screen.dart';
import '../login/login_screen.dart';

class SignUpTwoVm extends BaseVm {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  MyPrefs pref = MyPrefs();
  SignUpResponse? _response;

  SignUpResponse? get response => _response;

  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController reenterPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String imageData = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isDataFilled =>
      passwordController.text.isNotEmpty &&
      reenterPasswordController.text.isNotEmpty &&
      cityController.text.isNotEmpty &&
      contactNumberController.text.isNotEmpty &&
      designationController.text.isNotEmpty;

  // Lists for dropdowns
  List<String> cityList = ['New York', 'Los Angeles', 'Chicago', 'Houston'];
  List<String> designationList = ['Manager', 'Developer', 'Designer', 'Tester'];

  SignUpVm() {
    passwordController.addListener(() {
      notifyListeners();
    });
    reenterPasswordController.addListener(() {
      notifyListeners();
    });
    cityController.addListener(() {
      notifyListeners();
    });
    contactNumberController.addListener(() {
      notifyListeners();
    });
    designationController.addListener(() {
      notifyListeners();
    });
  }

  void onCreateAccountClicked(BuildContext context) {
    if (cityController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter City');
      return;
    }
    if (contactNumberController.text.isEmpty) {
      customSnack(
          context: context,
          color: Colors.red,
          text: 'Enter Contact Information');
      return;
    }
    if (designationController.text.isEmpty) {
      customSnack(
          context: context, color: Colors.red, text: 'Enter Designation');
      return;
    }
    if (passwordController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter  Password');
      return;
    }
    if (reenterPasswordController.text.isEmpty) {
      customSnack(
          context: context, color: Colors.red, text: 'Enter Confirm Password');
      return;
    }

    Navigator.pushReplacementNamed(context, LoginScreen.route);

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

  goToSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginScreen.route);
  }

  showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: AppConstants.getScreenHeight(context) * 0.32,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff406098),
                  Color(0xff323F80),
                ],
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      selectImage(ImageSource.gallery, context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff29326B),
                          borderRadius: BorderRadius.circular(12.r)),
                      height: 60.h,
                      child: Row(
                        children: [
                          SizedBox(width: 28.w),
                          SvgPicture.asset('assets/svg/gallery.svg'),
                          SizedBox(width: 19.04.w),
                          Text(
                            'Upload Photo',
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 19.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      selectImage(ImageSource.camera, context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff29326B),
                          borderRadius: BorderRadius.circular(10.r)),
                      height: 60.h,
                      child: Row(
                        children: [
                          SizedBox(width: 28.w),
                          SvgPicture.asset('assets/svg/camera.svg'),
                          SizedBox(width: 19.04.w),
                          Text(
                            'Take a Photo',
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 19.h),
                  CustomButton(
                      isEnabled: true,
                      buttonText: 'Cancel',
                      onPressed: () {
                        Navigator.pop(ctx);
                      })
                ],
              ),
            ),
          );
        });
  }

  selectImage(ImageSource source, BuildContext context) async {
    try {
      XFile? image = await picker.pickImage(
          source: source, imageQuality: 70, requestFullMetadata: false);
      if (image != null) {
        imageFile = File(image.path); // Save the selected image as a File
        notifyListeners(); // Notify listeners to update UI

        Uint8List imageBytes = await image.readAsBytes();
        imageData = uint8ListToBase64(imageBytes); // Convert to Base64
        notifyListeners();
      }
    } catch (e) {
      customSnack(
          context: context, color: Colors.red, text: "Error picking image: $e");
    }
  }

  String uint8ListToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  onSignUpClicked(BuildContext context) async {
    if (passwordController.text.isEmpty) {
      customSnack(
          context: context, color: Colors.red, text: 'Please enter password');
      return;
    }
    if (reenterPasswordController.text.isEmpty) {
      customSnack(
          context: context,
          color: Colors.red,
          text: 'Please enter confirm password');
      return;
    }
    if (cityController.text.isEmpty) {
      customSnack(
          context: context, color: Colors.red, text: 'Please enter city');
      return;
    }
    if (contactNumberController.text.isEmpty) {
      customSnack(
          context: context,
          color: Colors.red,
          text: 'Please enter your contact number');
      return;
    }
    if (designationController.text.isEmpty) {
      customSnack(
          context: context,
          color: Colors.red,
          text: 'Please enter your designation');
      return;
    }
    if (passwordController.text.length < 6) {
      customSnack(
          context: context,
          color: Colors.red,
          text: 'Password length must be 6 characters');
      return;
    }
    if (passwordController.text != reenterPasswordController.text) {
      customSnack(
          context: context, color: Colors.red, text: 'Password not matched');
      return;
    }

    SignUpBody body = SignUpBody(
        imageBase64: imageData == '' ? null : imageData,
        password: passwordController.text,
        confirmPassword: reenterPasswordController.text,
        city: cityController.text,
        contactNumber: contactNumberController.text,
        designation: designationController.text);
    await registerNewUser(body, (bool status, String msg) {
      if (status) {
        customSnack(context: context, color: Colors.green, text: msg);
        Navigator.pushReplacementNamed(context, BottomNavScreen.route);
      } else {
        customMessageDialog(
          context: context,
          msg: msg,
          isError: true,
          onTap: () => Navigator.pop(context),
        );
      }
    });
  }

  registerNewUser(SignUpBody body, Function callBack) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.signUpUser(body);
    if (apiResponse.response != null &&
            apiResponse.response?.statusCode == 200 ||
        apiResponse.response?.statusCode == 201) {
      _response = SignUpResponse.fromJson(apiResponse.response?.data);
      await MyPrefs.setStringShared(SharedPrefsKeys.TOKEN, response!.token!);
      callBack(true, "Registered Successfully");
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
      callBack(false, errorMessage);
      _isLoading = false;
      notifyListeners();
    }
  }
}
