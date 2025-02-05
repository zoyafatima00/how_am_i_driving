import 'dart:convert'; // Import this for Base64 encoding
import 'dart:io'; // Import for File

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/base_vm.dart';
import '../../../../utils/app_constants.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/my_snackbar.dart';

class AddDriverScreenVm extends BaseVm {
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String imageData = '';
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
      experienceController.text.isNotEmpty;

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
}
