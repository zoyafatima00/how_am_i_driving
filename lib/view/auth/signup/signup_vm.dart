import 'dart:convert'; // Import this for Base64 encoding
import 'dart:io'; // Import for File

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/my_snackbar.dart';

class SignUpVm extends BaseVm {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  MyPrefs pref = MyPrefs();
  SignUpResponse? _response;

  SignUpResponse? get response => _response;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController raddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reenterPasswordController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String imageData = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isDataFilled =>
      fullNameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      cnicController.text.isNotEmpty &&
      dobController.text.isNotEmpty &&
      raddressController.text.isNotEmpty &&
      cityController.text.isNotEmpty &&
      contactNumberController.text.isNotEmpty &&
      designationController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      reenterPasswordController.text.isNotEmpty;

  SignUpVm() {
    fullNameController.addListener(() {
      notifyListeners();
    });
    emailController.addListener(() {
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
    cityController.addListener(() {
      notifyListeners();
    });
    contactNumberController.addListener(() {
      notifyListeners();
    });
    designationController.addListener(() {
      notifyListeners();
    });
    passwordController.addListener(() {
      notifyListeners();
    });
    reenterPasswordController.addListener(() {
      notifyListeners();
    });
  }

  // Method to go to SignIn screen
  goToSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/SignInScreen');
  }

  // Method to select an image for the user
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

  // Method to handle sign up button click
  void onSignUpClicked(BuildContext context) async {
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
    if (passwordController.text != reenterPasswordController.text) {
      customSnack(
          context: context, color: Colors.red, text: 'Password not matched');
      return;
    }

    SignUpBody body = SignUpBody(
      fullName: fullNameController.text,
      email: emailController.text,
      cnic: cnicController.text,
      dob: dobController.text,
      address: raddressController.text,
      city: cityController.text,
      contactNumber: contactNumberController.text,
      designation: designationController.text,
      password: passwordController.text,
      confirmPassword: reenterPasswordController.text,
      // imageBase64:
      //     imageData == '' ? null : imageData, // Add image data if available
    );

    await registerNewUser(body, (bool status, String msg) {
      if (status) {
        customSnack(context: context, color: Colors.green, text: msg);
        Navigator.pushReplacementNamed(context, '/BottomNavScreen');
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

  // API call for registering a new user
  registerNewUser(SignUpBody body, Function callBack) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.signUpUser(body);
    if (apiResponse.response != null &&
        (apiResponse.response?.statusCode == 200 ||
            apiResponse.response?.statusCode == 201)) {
      _response = SignUpResponse.fromJson(apiResponse.response?.data);
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
      callBack(false, errorMessage ?? "Something went wrong");
      _isLoading = false;
      notifyListeners();
    }
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
}
