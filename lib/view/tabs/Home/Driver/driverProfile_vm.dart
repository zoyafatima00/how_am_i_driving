import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../data/repo/auth_repo.dart';

class ViewDriverProfileVm extends ChangeNotifier {
  int? id;
  String? name;
  String? cnic;
  String? contactNumber;
  String? address;
  bool _isLoading = false;
  Map<String, File?> profilePictures = {}; // Use String as the key type

  // Helper function to check if the context is mounted
  bool isContextMounted(BuildContext context) {
    return context.mounted;
  }

  bool get isLoading => _isLoading;

  // Fetch admin details by name
  Future<void> fetchAdminDetails(String name, BuildContext context) async {
    if (_isLoading) return; // Prevent multiple simultaneous requests
    _isLoading = true;
    notifyListeners();

    try {
      final authRepo = Provider.of<AuthRepo>(context, listen: false);
      final response = await authRepo.getAdminDetails(name);

      if (response.response != null && response.response?.statusCode == 200) {
        final data = response.response?.data;
        this.name = data['name'];
        id = data['id'];
        cnic = data['cnic'];
        contactNumber = data['contact_number'];
        address = data['address'];

        // After fetching admin details, fetch the profile picture using the id
        if (id != null) {
          await fetchProfilePicture(id.toString(), context);
        }

        // Ensure the widget is still mounted before calling notifyListeners
        if (context.mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notifyListeners(); // Notify listeners to update the UI
          });
        }
      } else if (response.response?.statusCode == 404) {
        throw Exception("Admin not found");
      } else {
        throw Exception("Failed to fetch admin details");
      }
    } catch (e) {
      print("Error fetching admin details: $e");
    } finally {
      _isLoading = false;
      // Ensure the widget is still mounted before calling notifyListeners
      if (context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      }
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
}
