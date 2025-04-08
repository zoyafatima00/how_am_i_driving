import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import '../../../widgets/TrackMapWidget.dart';
import 'TrackRideProfile_vm.dart';

class TrackRideProfileScreen extends StatefulWidget {
  static const route = '/TrackRideProfileScreen';
  final Map<String, dynamic> rideDetails;
  const TrackRideProfileScreen({super.key, required this.rideDetails});
  @override
  _TrackRideProfileScreenState createState() => _TrackRideProfileScreenState();
}

class _TrackRideProfileScreenState extends State<TrackRideProfileScreen> {
  String? _currentLocation;
  bool _isLocationLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentLocation = 'Location services are disabled';
          _isLocationLoading = false;
        });
        return;
      } // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentLocation = 'Location permissions are denied';
            _isLocationLoading = false;
          });
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentLocation = 'Location permissions are permanently denied';
          _isLocationLoading = false;
        });
        return;
      } // Fetch position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      // Get placemarks
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = _formatPlacemark(place); // New formatting method
        setState(() {
          _currentLocation = address.isNotEmpty
              ? address
              : 'Rawalpindi, Punjab, Pakistan'; // Fallback_isLocationLoading = false;
        });
      } else {
        setState(() {
          _currentLocation = 'Rawalpindi, Punjab, Pakistan';
          _isLocationLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _currentLocation = 'Rawalpindi, Punjab, Pakistan';
        _isLocationLoading = false;
      });
    }
  }

// New helper method to format the address
  String _formatPlacemark(Placemark place) {
    final addressParts = [
      if (place.street?.isNotEmpty ?? false) place.street,
      if (place.subLocality?.isNotEmpty ?? false) place.subLocality,
      if (place.locality?.isNotEmpty ?? false) place.locality,
      if (place.administrativeArea?.isNotEmpty ?? false)
        place.administrativeArea,
      if (place.country?.isNotEmpty ?? false) place.country,
    ].whereType<String>().toList();
    return addressParts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackRideProfileVm>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
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
                _buildTrackVideo(widget.rideDetails['address'] ?? ''),
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

  Widget _buildCurrentLocation() {
    return BlueCardWidget(
      title: 'Current Location',
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: _isLocationLoading
            ? _buildLoadingIndicator()
            : _buildLocationText(),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      children: [
        SizedBox(
          width: 20.w,
          height: 20.w,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          'Detecting your location...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_pin, color: Colors.white, size: 18.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            _currentLocation ?? 'Location unavailable',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

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

  Widget _buildTrackVideo(String destinationAddress) {
    return BlueCardWidget(
      title: 'Track Ride',
      child: TrackMapWidget(
        destinationAddress: destinationAddress,
      ),
    );
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
        padding: const EdgeInsets.all(16.0),
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
