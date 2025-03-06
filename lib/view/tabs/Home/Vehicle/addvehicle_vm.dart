import 'dart:io'; // For File

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:how_am_i_driving/data/base_vm.dart';
import 'package:how_am_i_driving/data/model/body/addVehicleBody.dart'; // AddVehicleBody model
import 'package:image_picker/image_picker.dart';

import '../../../../data/model/response/base/addVehicleResponse.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/repo/auth_repo.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/my_snackbar.dart';

class AddVehicleScreenVm extends BaseVm {
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  bool _isLoading = false;
  String? integrationValue = '';
  final ImagePicker picker = ImagePicker();

  AddVehicleResponse? _response;

  AddVehicleResponse? get response => _response;

  // Image variables to store selected images
  File? rearImage;
  File? frontImage;
  List<File?> images = [null, null, null, null, null]; // For Images 3, 4, 5, 6

  bool get isLoading => _isLoading;

  // Text controllers for vehicle details
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
      addedByController.text.isNotEmpty &&
      rearImage != null &&
      frontImage != null; // Ensure image is selected

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

  // Show bottom sheet for image selection
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
                        child: const Row(
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

  // Method to handle adding a new vehicle
  void onAddVehicleClicked(BuildContext context) async {
    if (!isDataFilled) {
      customSnack(
        context: context,
        color: Colors.red,
        text: 'Please fill all fields and upload all required images.',
      );
      return;
    }

    // Create FormData object with fields and files
    final formData = FormData.fromMap({
      ...AddVehicleBody(
        vehicleOwner: ownerNameController.text,
        vehicleName: vehicleNameController.text,
        model: modelController.text,
        number: numberController.text,
        engineNumber: engineNumberController.text,
        vehicleType: vehicleTypeController.text,
        role: roleController.text,
        integration: integrationValue,
        milage: double.parse(milageController.text),
        fuelType: fuelTypeController.text,
        dateOfJoining: dateOfJoiningController.text,
        addedBy: addedByController.text,
      ).toJson(), // Spread all fields from the body
      "image_rear": await MultipartFile.fromFile(
        rearImage!.path,
        filename: 'image_rear.jpg',
      ),
      "image_front": await MultipartFile.fromFile(
        frontImage!.path,
        filename: 'image_front.jpg',
      ),
      "image_3": images[0] != null
          ? await MultipartFile.fromFile(
              images[0]!.path,
              filename: 'image_3.jpg',
            )
          : null,
      "image_4": images[1] != null
          ? await MultipartFile.fromFile(
              images[1]!.path,
              filename: 'image_4.jpg',
            )
          : null,
      "image_5": images[2] != null
          ? await MultipartFile.fromFile(
              images[2]!.path,
              filename: 'image_5.jpg',
            )
          : null,
      "image_6": images[3] != null
          ? await MultipartFile.fromFile(
              images[3]!.path,
              filename: 'image_6.jpg',
            )
          : null,
    });

    // Call the addVehicle method with FormData
    ApiResponse apiResponse = await authRepo.addVehicle(formData);

    // Handle the API response
    if (apiResponse.response != null) {
      customSnack(
        context: context,
        color: Colors.green,
        text: "Vehicle added successfully!",
      );
      Navigator.pushReplacementNamed(context, '/VehicleListScreen');
    } else {
      customMessageDialog(
        context: context,
        msg: apiResponse.error ?? "Something went wrong.",
        isError: true,
        onTap: () => Navigator.pop(context),
      );
    }
  }

  // API call to add the new vehicle
  addVehicle(
      AddVehicleBody body, List<File> imageFiles, Function callBack) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Log the request body and image files
      print("Request Body: ${body.toJson()}");
      print("Image Files: ${imageFiles.map((file) => file.path).toList()}");

      // Create a FormData object
      var formData = FormData.fromMap({
        ...body.toJson(), // Add all fields from the body
        'image_rear': await MultipartFile.fromFile(imageFiles[0].path),
        'image_front': await MultipartFile.fromFile(imageFiles[1].path),
        'image_3': await MultipartFile.fromFile(imageFiles[2].path),
        'image_4': await MultipartFile.fromFile(imageFiles[3].path),
        'image_5': await MultipartFile.fromFile(imageFiles[4].path),
        'image_6': await MultipartFile.fromFile(imageFiles[5].path),
      });

      // Make the API call with FormData
      ApiResponse apiResponse = await authRepo.addVehicle(formData);

      // Log the API response
      print("API Response: ${apiResponse.response?.data}");

      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        _response = AddVehicleResponse.fromJson(apiResponse.response?.data);
        callBack(true, "Vehicle Added Successfully");
      } else {
        String? errorMessage;

        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else if (apiResponse.error != null) {
          dynamic errorResponse = apiResponse.error;
          errorMessage = errorResponse.message ?? "Something went wrong";
        } else {
          // Handle the case where the server returns a 422 or other error status codes
          if (apiResponse.response?.statusCode == 422) {
            // Parse the response body to get the validation errors
            var responseData = apiResponse.response?.data;
            if (responseData is Map<String, dynamic>) {
              errorMessage = responseData['message'] ?? "Validation error";
            } else {
              errorMessage = "Validation error";
            }
          } else {
            errorMessage = "Something went wrong";
          }
        }

        callBack(false, errorMessage ?? "Something went wrong");
      }
    } catch (e) {
      callBack(false, "An error occurred: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
