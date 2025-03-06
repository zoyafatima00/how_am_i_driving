import 'dart:io'; // Import for File

import 'package:flutter/material.dart';
import 'package:how_am_i_driving/data/base_vm.dart';
import 'package:how_am_i_driving/data/repo/auth_repo.dart';
import 'package:how_am_i_driving/view/tabs/Home/Vehicle/vehicleProfile_screen.dart';
import 'package:provider/provider.dart';

class ViewVehicleScreenVm extends BaseVm {
  List<String> vehicleNames = [];
  List<String> vehicleNumbers = [];
  Map<String, File?> vehicleImages = {}; // Use File for vehicle images

  // Helper function to check if the context is mounted
  bool isContextMounted(BuildContext context) {
    return context.mounted;
  }

  // Fetch vehicle details
  Future<void> fetchVehicleDetails(BuildContext context) async {
    try {
      final authRepo = Provider.of<AuthRepo>(context, listen: false);
      final response = await authRepo.getVehicleNames();

      if (response.response != null && response.response?.statusCode == 200) {
        final vehicleData = response.response?.data['vehicle_details'];

        vehicleNames = List<String>.from(
            vehicleData.map((vehicle) => vehicle['vehicle_name']));
        vehicleNumbers = List<String>.from(
            vehicleData.map((vehicle) => vehicle['vehicle_number']));

        // Fetch vehicle images using the vehicle numbers
        for (int i = 0; i < vehicleNumbers.length; i++) {
          final vehicleNumber = vehicleNumbers[i];
          await fetchVehicleImage(vehicleNumber, context);
        }

        notifyListeners();
      } else {
        throw Exception("Failed to fetch vehicle names");
      }
    } catch (e) {
      print("Error fetching vehicle details: $e");
    }
  }

  // Fetch vehicle image for a specific vehicle
  Future<void> fetchVehicleImage(
      String vehicleNumber, BuildContext context) async {
    try {
      final authRepo = Provider.of<AuthRepo>(context, listen: false);
      final response = await authRepo.getVehicleImage(vehicleNumber, 'front');

      if (response.response != null && response.response?.statusCode == 200) {
        final file =
            File('${Directory.systemTemp.path}/vehicle_$vehicleNumber.jpg');
        await file.writeAsBytes(response.response?.data);
        if (isContextMounted(context)) {
          vehicleImages[vehicleNumber] = file;
          notifyListeners();
        }
      } else if (response.response?.statusCode == 404) {
        print("Vehicle image not found for $vehicleNumber");
        if (isContextMounted(context)) {
          vehicleImages[vehicleNumber] = null;
          notifyListeners();
        }
      } else {
        throw Exception("Failed to fetch vehicle image for $vehicleNumber");
      }
    } catch (e) {
      print("Error fetching vehicle image: $e");
    }
  }

  // Navigate to vehicle profile screen
  void onViewVehicleProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewVehicleProfileScreen.route);
  }
}
