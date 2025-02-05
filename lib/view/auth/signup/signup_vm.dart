import 'dart:convert'; // Import this for Base64 encoding
import 'dart:io'; // Import for File

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:how_am_i_driving/view/auth/signup/signup_screen2.dart';
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
import '../../../widgets/my_snackbar.dart';
import '../login/login_screen.dart';

class SignUpVm extends BaseVm {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  MyPrefs pref = MyPrefs();
  SignUpResponse? _response;

  SignUpResponse? get response => _response;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController raddressController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String imageData = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isDataFilled =>
      firstNameController.text.isNotEmpty &&
      lastNameController.text.isNotEmpty &&
      cnicController.text.isNotEmpty &&
      dobController.text.isNotEmpty &&
      raddressController.text.isNotEmpty;

  SignUpVm() {
    firstNameController.addListener(() {
      notifyListeners();
    });
    lastNameController.addListener(() {
      notifyListeners();
    });
    cnicController.addListener(() {
      notifyListeners();
    });
    dobController.addListener(() {
      notifyListeners();
    });
    raddressController.addListener(() {
      notifyListeners();
    });
  }

  goToSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginScreen.route);
  }

  void onNextClicked(BuildContext context) {
    if (firstNameController.text.isEmpty) {
      customSnack(
          context: context, color: Colors.red, text: 'Enter First Name');
      return;
    }
    if (lastNameController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter Last Name');
      return;
    }
    if (cnicController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter CNIC');
      return;
    }
    if (dobController.text.isEmpty) {
      customSnack(
          context: context, color: Colors.red, text: 'Enter Date Of Birth');
      return;
    }
    if (raddressController.text.isEmpty) {
      customSnack(context: context, color: Colors.red, text: 'Enter Address');
      return;
    }

    Navigator.pushReplacementNamed(context, SignUpTwoScreen.route);

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

  showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
              // h: AppConstants.getScreenHeight(context) * 0.32,
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 22.0),
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
                            SizedBox(
                              width: 28.w,
                            ),
                            SvgPicture.asset('assets/svg/gallery.svg'),
                            SizedBox(
                              width: 19.04.w,
                            ),
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
                    SizedBox(
                      height: 19.h,
                    ),
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
                            SizedBox(
                              width: 28.w,
                            ),
                            SvgPicture.asset('assets/svg/camera.svg'),
                            SizedBox(
                              width: 19.04.w,
                            ),
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
                    SizedBox(
                      height: 19.h,
                    ),
                    CustomButton(
                        isEnabled: true,
                        buttonText: 'Cancel',
                        onPressed: () {
                          Navigator.pop(ctx);
                        })
                  ],
                ),
              ));
        });
  }

  // Method to select an image using ImagePicker
  selectImage(ImageSource source, BuildContext context) async {
    try {
      XFile? image = await picker.pickImage(
          source: source, imageQuality: 70, requestFullMetadata: false);
      if (image != null) {
        imageFile = File(image.path); // Save the selected image as a File
        notifyListeners(); // Notify listeners to update UI

        // Read the image bytes and convert to Base64
        Uint8List imageBytes = await image.readAsBytes();
        imageData = uint8ListToBase64(imageBytes); // Convert to Base64
        notifyListeners();
      }
    } catch (e) {
      customSnack(
          context: context, color: Colors.red, text: "Error picking image: $e");
    }
  }

  // Method to convert Uint8List to Base64
  String uint8ListToBase64(Uint8List bytes) {
    return base64Encode(bytes); // Converts the byte data to Base64 string
  }

  //API CALLS
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
