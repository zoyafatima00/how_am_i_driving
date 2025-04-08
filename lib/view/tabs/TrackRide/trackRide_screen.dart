import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/view/tabs/TrackRide/trackRide_vm.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import '../../../widgets/trackRideCared_widget.dart';

class TrackRideScreen extends StatelessWidget {
  static const route = '/TrackRideScreen';

  const TrackRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TrackRideScreenVm()..fetchRideDetails(),
      child: Consumer<TrackRideScreenVm>(builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 14.h),
                  // Title
                  Text(
                    "Track Ride",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                  SizedBox(height: 25.h),

                  // Rides List
                  vm.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: vm.rideList.map((ride) {
                            return TrackRideCard(
                              driverName:
                                  ride['driver_name'] ?? 'Driver\'s Name',
                              vehicleName:
                                  ride['vehicle_name'] ?? 'Vehicle\'s Name',
                              dropoffLocation:
                                  ride['address'] ?? 'Drop Off Location',
                              onTap: () {
                                vm.onTrackRideProfileClicked(context, ride);
                              },
                              onDetailsTap: () {
                                vm.onTrackRideProfileClicked(context, ride);
                              },
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
