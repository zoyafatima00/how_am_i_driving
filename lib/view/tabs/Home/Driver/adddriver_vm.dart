import 'dart:io'; // Import for File

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:how_am_i_driving/data/model/response/addDriverResponse.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/base_vm.dart';
import '../../../../data/model/body/addDriverBody.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/repo/auth_repo.dart';
import '../../../../utils/app_constants.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/my_snackbar.dart';

class AddDriverScreenVm extends BaseVm {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  AddDriverResponse? _response;

  AddDriverResponse? get response => _response;
  final ImagePicker picker = ImagePicker();
  File? imageFile; // Store the selected image file
  bool _isLoading = false;
  RegExp cnicRegExp = RegExp(r'^\d{5}-\d{7}-\d{1}$');
  String? cnicError;

  bool get isLoading => _isLoading;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController doiController = TextEditingController();
  TextEditingController doeController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  bool get isDataFilled =>
      firstNameController.text.isNotEmpty &&
      lastNameController.text.isNotEmpty &&
      cnicController.text.isNotEmpty &&
      dobController.text.isNotEmpty &&
      addressController.text.isNotEmpty &&
      cityController.text.isNotEmpty &&
      contactController.text.isNotEmpty &&
      licenseNumberController.text.isNotEmpty &&
      doiController.text.isNotEmpty &&
      doeController.text.isNotEmpty &&
      experienceController.text.isNotEmpty &&
      imageFile != null; // Ensure image is selected

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
      }
    } catch (e) {
      customSnack(
          context: context, color: Colors.red, text: "Error picking image: $e");
    }
  }

  void onAddDriverClicked(BuildContext context) async {
    if (!isDataFilled) {
      customSnack(
          context: context,
          color: Colors.red,
          text: 'Please fill all fields and select an image');
      return;
    }

    AddDriverBody body = AddDriverBody(
      fullName: firstNameController.text,
      email: lastNameController.text,
      cnic: cnicController.text,
      dob: dobController.text,
      address: addressController.text,
      city: cityController.text,
      contactNumber: contactController.text,
      licenseNumber: licenseNumberController.text,
      dateOfIssue: doiController.text,
      dateOfExpiry: doeController.text,
      experience: experienceController.text,
    );

    await addNewDriver(body, imageFile!, (bool status, String msg) {
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

  // API call for registering a new driver
  addNewDriver(AddDriverBody body, File imageFile, Function callBack) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.addDriver(body, imageFile);
    if (apiResponse.response != null &&
        (apiResponse.response?.statusCode == 200 ||
            apiResponse.response?.statusCode == 201)) {
      _response = AddDriverResponse.fromJson(apiResponse.response?.data);
      callBack(true, "Driver Added Successfully");
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
}
