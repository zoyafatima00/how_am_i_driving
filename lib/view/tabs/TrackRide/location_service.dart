import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Check if location services are enabled
  Future<bool> _checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false; // Location services are disabled
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false; // Permissions are denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false; // Permissions are permanently denied
    }

    return true;
  }

  // Get the current location
  Future<Position?> getCurrentLocation() async {
    bool hasPermission = await _checkLocationPermissions();
    if (!hasPermission) {
      return null; // Permissions are not granted
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  // Convert coordinates to a human-readable address
  Future<String?> getAddressFromCoordinates(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return 'City: ${place.locality}, Street: ${place.street}';
      }
    } catch (e) {
      print("Error converting coordinates to address: $e");
    }
    return null;
  }
}
