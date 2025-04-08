import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackMapWidget extends StatefulWidget {
  final String destinationAddress;

  const TrackMapWidget({Key? key, required this.destinationAddress})
      : super(key: key);

  @override
  _TrackMapWidgetState createState() => _TrackMapWidgetState();
}

class _TrackMapWidgetState extends State<TrackMapWidget> {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;
  LatLng? _destinationLatLng;
  final Set<Marker> _markers = {};
  bool _isLoading = true;
  double? _currentSpeed; // in m/s
  StreamSubscription<Position>? _positionStream;
  bool _isSpeedInKmph = true; // toggle between km/h and m/s

  @override
  void initState() {
    super.initState();
    _initializeLocations();
    _startListeningToPositionUpdates();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  void _startListeningToPositionUpdates() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 5, // Update every 5 meters
    );
    _positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      if (mounted) {
        setState(() {
          _currentSpeed = position.speed; // Speed in m/s
          _currentLatLng = LatLng(position.latitude, position.longitude);
          _updateMarkers();
        });
      }
    });
  }

  String _getFormattedSpeed() {
    if (_currentSpeed == null || _currentSpeed! < 0) {
      return '0.0 ${_isSpeedInKmph ? 'km/h' : 'm/s'}';
    }

    final speed = _isSpeedInKmph
        ? (_currentSpeed! * 3.6) // Convert m/s to km/h
        : _currentSpeed!;

    return '${speed.toStringAsFixed(1)} ${_isSpeedInKmph ? 'km/h' : 'm/s'}';
  }

  Future<void> _initializeLocations() async {
    await _getCurrentLocation();
    await _getDestinationLatLng();
    setState(() => _isLoading = false);
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        print('Location permissions permanently denied');
        return;
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          print('Location permission denied');
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      print('Current Location: ${position.latitude}, ${position.longitude}');

      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
        _updateMarkers();
        _updateCamera();
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> _getDestinationLatLng() async {
    try {
      print("Looking up destination: ${widget.destinationAddress}");

      List<Location> locations =
          await locationFromAddress(widget.destinationAddress);

      if (locations.isEmpty) {
        print("No location found for address: ${widget.destinationAddress}");
        return;
      }

      Location destination = locations.first;
      print(
          "Destination Found: ${destination.latitude}, ${destination.longitude}");

      setState(() {
        _destinationLatLng =
            LatLng(destination.latitude, destination.longitude);
        _updateMarkers();
        _updateCamera();
      });
    } catch (e) {
      print("Geocoding error: $e");
    }
  }

  void _updateMarkers() {
    if (_currentLatLng == null || _destinationLatLng == null) return;

    setState(() {
      _markers
        ..clear()
        ..add(Marker(
          markerId: const MarkerId('current'),
          position: _currentLatLng!,
          infoWindow: const InfoWindow(title: 'Current Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          onTap: () => _launchGoogleMaps(_currentLatLng!),
        ))
        ..add(Marker(
          markerId: const MarkerId('destination'),
          position: _destinationLatLng!,
          infoWindow: InfoWindow(title: widget.destinationAddress),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () => _launchGoogleMaps(_destinationLatLng!),
        ));
    });
  }

  void _updateCamera() {
    if (_currentLatLng == null ||
        _destinationLatLng == null ||
        _mapController == null) {
      return;
    }

    final bounds =
        _boundsFromLatLngList([_currentLatLng!, _destinationLatLng!]);
    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  Future<void> _launchGoogleMaps(LatLng location) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch Google Maps");
    }
  }

  Future<void> _launchMapDirections() async {
    if (_currentLatLng == null || _destinationLatLng == null) {
      print("Locations not available");
      return;
    }

    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=${_currentLatLng!.latitude},${_currentLatLng!.longitude}'
      '&destination=${_destinationLatLng!.latitude},${_destinationLatLng!.longitude}'
      '&travelmode=driving',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch Google Maps directions");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _isLoading || _currentLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLatLng!,
                    zoom: 14,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                    if (_currentLatLng != null && _destinationLatLng != null) {
                      _updateCamera();
                    }
                  },
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  onTap: (LatLng position) {
                    _launchMapDirections();
                  },
                ),
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _launchMapDirections,
                    behavior: HitTestBehavior.translucent,
                  ),
                ),
                // Speed display widget
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _isSpeedInKmph = !_isSpeedInKmph),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.speed,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            _getFormattedSpeed(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
