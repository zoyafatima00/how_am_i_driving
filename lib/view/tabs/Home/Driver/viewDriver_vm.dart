import 'dart:io';

import 'package:flutter/material.dart';
import 'package:how_am_i_driving/data/base_vm.dart';
import 'package:how_am_i_driving/data/repo/auth_repo.dart';
import 'package:provider/provider.dart';

import 'driverProfile_screen.dart';

class ViewDriverScreenVm extends BaseVm {
  List<String> adminNames = []; // Store admin names
  Map<String, File?> profilePictures = {}; // Use String as the key type

  // Helper function to check if the context is mounted
  bool isContextMounted(BuildContext context) {
    return context.mounted;
  }

  // Fetch admin names from the API
  Future<void> fetchAdminNames(BuildContext context) async {
    try {
      final authRepo = Provider.of<AuthRepo>(context, listen: false);
      final response = await authRepo.getAdminNames();

      if (response.response != null && response.response?.statusCode == 200) {
        adminNames = List<String>.from(response.response?.data['admin_names']);
        notifyListeners();

        for (int i = 0; i < adminNames.length; i++) {
          final adminId = (i + 1).toString(); // Convert to String
          await fetchProfilePicture(adminId, context);
        }
      } else {
        throw Exception("Failed to fetch admin names");
      }
    } catch (e) {
      print("Error fetching admin names: $e");
    }
  }

  // Fetch profile picture for a specific admin ID
  Future<void> fetchProfilePicture(String adminId, BuildContext context) async {
    try {
      final authRepo = Provider.of<AuthRepo>(context, listen: false);
      final response = await authRepo.getProfilePicture(adminId);

      if (response.response != null && response.response?.statusCode == 200) {
        final file = File('${Directory.systemTemp.path}/profile_$adminId.jpg');
        await file.writeAsBytes(response.response?.data);
        if (isContextMounted(context)) {
          profilePictures[adminId] = file;
          notifyListeners();
        }
      } else if (response.response?.statusCode == 404) {
        print("Profile picture not found for admin $adminId");
        if (isContextMounted(context)) {
          profilePictures[adminId] = null;
          notifyListeners();
        }
      } else {
        throw Exception("Failed to fetch profile picture for admin $adminId");
      }
    } catch (e) {
      print("Error fetching profile picture: $e");
    }
  }

  // Navigate to the driver profile screen
  void onViewDriverProfileClicked(BuildContext context, String driverName) {
    print("Navigating with Driver Name: $driverName"); // Debug statement
    Navigator.pushNamed(
      context,
      ViewDriverProfileScreen.route,
      arguments: driverName, // Pass the driverName as an argument
    );
  }
}
