import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart'; // Add this package
import 'package:geolocator/geolocator.dart'; // Add this package
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import 'TrackRideProfile_vm.dart';

class TrackRideProfileScreen extends StatefulWidget {
  static const route = '/TrackRideProfileScreen';
  final Map<String, dynamic> rideDetails;

  const TrackRideProfileScreen({super.key, required this.rideDetails});

  @override
  _TrackRideProfileScreenState createState() => _TrackRideProfileScreenState();
}

class _TrackRideProfileScreenState extends State<TrackRideProfileScreen> {
  String _currentLocation =
      'Fetching location...'; // Variable to store the current location

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch the current location when the screen loads
  }

  // Method to fetch the current location
  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentLocation = 'Location services are disabled';
        });
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentLocation = 'Location permissions are denied';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentLocation = 'Location permissions are permanently denied';
        });
        return;
      }

      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert coordinates to a human-readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _currentLocation = 'City: ${place.locality}, Street: ${place.street}';
        });
      } else {
        setState(() {
          _currentLocation = 'Unable to fetch address';
        });
      }
    } catch (e) {
      setState(() {
        _currentLocation = 'Error fetching location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackRideProfileVm>(builder: (context, vm, _) {
      String formattedDate = _formatDate(widget.rideDetails['date']);
      // Log the rideDetails for debugging
      print("Ride Details in TrackRideProfileScreen: ${widget.rideDetails}");
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            const Spacer(),
            const Spacer(),
            Text.rich(
              TextSpan(
                text: 'How am I ',
                style: const TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Driving?',
                    style: TextStyle(
                        fontSize: 23,
                        color: AppColors.TextMUSTARD_COLOR,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/bell-solid.png',
                      height: 21.h,
                      width: 23.h,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/person_icon.png',
                      height: 21.h,
                      width: 23.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
          elevation: 0,
          flexibleSpace: const SizedBox(),
          backgroundColor: AppColors.Text_COLOR,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 18.h),
                // Title
                Text(
                  "Track Ride",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR),
                ),
                SizedBox(height: 20.h),
                _buildTrackDetails(widget.rideDetails),
                SizedBox(height: 20.h),
                _buildTrackVideo(),
                SizedBox(height: 20.h),
                _buildCurrentLocation(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Updated method to display the real current location
  Widget _buildCurrentLocation() {
    return BlueCardWidget(
      title: 'Current Location',
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 8.0), // Consistent padding
        child: Text(
          _currentLocation, // Display the fetched location
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Arial',
            fontSize: 16.sp, // Consistent font size
          ),
        ),
      ),
    );
  }
}

// Accept rideDetails as a parameter
Widget _buildTrackDetails(Map<String, dynamic> rideDetails) {
  return BlueCardWidget(
    title: 'Ride Details',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Ride Id', '${rideDetails['id']}'),
        _buildDetailRow('Date & Time', '2025-02-10 12:00 PM'),
        Divider(),
        _buildDetailRow('Driver Id', '${rideDetails['driver_id']}'),
        _buildDetailRow('Driver Name', '${rideDetails['driver_name']}'),
        Divider(),
        _buildDetailRow('Vehicle Id', '${rideDetails['vehicle_number']}'),
        _buildDetailRow('Vehicle Name', '${rideDetails['vehicle_name']}'),
        Divider(),
        _buildDetailRow('Task', '${rideDetails['task']}'),
        _buildDetailRow('Address', '${rideDetails['address']}'),
      ],
    ),
  );
}

Widget _buildTrackVideo() {
  return BlueCardWidget(
    title: 'Track Ride',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
              'assets/images/gps-satellite-navigation-system-screen_184220-480.png'), // Replace with actual video thumbnail
        ),
      ],
    ),
  );
}

Widget _buildCurrentLocation() {
  return BlueCardWidget(
    title: 'Current Location',
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Consistent padding
      child: Text(
        'City: Example City, Street: Example Street',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Arial',
          fontSize: 16.sp, // Consistent font size
        ),
      ),
    ),
  );
}

Widget _buildViewReport() {
  return BlueCardWidget(
    title: 'View Report',
    child: GestureDetector(
      onTap: () {
        // Handle "View Report" action
      },
      child: Text(
        'View Report',
        style: TextStyle(color: Colors.blue, fontFamily: 'Arial'),
      ),
    ),
  );
}

// Helper method to format the date
String _formatDate(String dateString) {
  try {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  } catch (e) {
    return dateString; // Return the original string if parsing fails
  }
}

Widget _buildDetailRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Arial'),
      ),
      Text(value, style: TextStyle(color: Colors.white, fontFamily: 'Arial')),
    ],
  );
}

class BlueCardWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const BlueCardWidget({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.Text_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Ensure consistent padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Arial'),
            ),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
