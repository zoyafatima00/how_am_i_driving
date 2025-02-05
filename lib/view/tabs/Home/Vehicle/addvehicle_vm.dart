import 'dart:convert'; // For Base64 encoding
import 'dart:io'; // For File

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_am_i_driving/data/base_vm.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/custom_button.dart';
import '../../../../widgets/my_snackbar.dart';

class AddVehicleScreenVm extends BaseVm {
  final ImagePicker picker = ImagePicker();
  bool _isLoading = false;
  String? integrationValue = '';

  // Image variables to store selected images
  File? rearImage;
  File? frontImage;
  List<File?> images = [null, null, null, null, null]; // For Images 3, 4, 5, 6

  bool get isLoading => _isLoading;

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController engineNumberController = TextEditingController();
  TextEditingController milageController = TextEditingController();
  TextEditingController fuelTypeController = TextEditingController();
  TextEditingController dateOfJoiningController = TextEditingController();
  TextEditingController addedByController = TextEditingController();

  // Controllers for dropdowns
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  // Lists for dropdowns
  List<String> vehicleTypeList = ['Car', 'Truck', 'Bike'];
  List<String> roleList = ['Driver', 'Admin'];

  bool get isDataFilled =>
      ownerNameController.text.isNotEmpty &&
      vehicleNameController.text.isNotEmpty &&
      modelController.text.isNotEmpty &&
      numberController.text.isNotEmpty &&
      engineNumberController.text.isNotEmpty &&
      milageController.text.isNotEmpty &&
      fuelTypeController.text.isNotEmpty &&
      dateOfJoiningController.text.isNotEmpty &&
      addedByController.text.isNotEmpty;

  // Function to add image to the list
  void addImage(String imageType, File image) {
    if (imageType == 'rear') {
      rearImage = image;
    } else if (imageType == 'front') {
      frontImage = image;
    } else if (imageType.startsWith('image')) {
      int index = int.parse(imageType.replaceAll('image', '')) - 3;
      images[index] = image;
    }
    notifyListeners(); // Notify the UI to update when images are added
  }

  // Function to show bottom sheet to upload photos
  void showSheet(BuildContext context, String imageType) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
              height: 270,
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
                        selectImage(imageType, ImageSource.gallery, context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff29326B),
                            borderRadius: BorderRadius.circular(12)),
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(width: 28),
                            Icon(Icons.image, color: Colors.white),
                            SizedBox(width: 19),
                            Text(
                              'Upload Photo',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 19),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx);
                        selectImage(imageType, ImageSource.camera, context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff29326B),
                            borderRadius: BorderRadius.circular(10)),
                        height: 60,
                        child: const Row(
                          children: [
                            SizedBox(width: 28),
                            Icon(Icons.camera_alt, color: Colors.white),
                            SizedBox(width: 19),
                            Text(
                              'Take a Photo',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 19),
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

  // Method to select an image and update the corresponding image variable
  Future<void> selectImage(
      String imageType, ImageSource source, BuildContext context) async {
    try {
      XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        File selectedImage = File(image.path);
        addImage(imageType, selectedImage);
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
