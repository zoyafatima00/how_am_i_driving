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
    return Consumer<TrackRideScreenVm>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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

                // Violation Records List
                const Column(
                  children: [
                    TrackRideCard(),
                    TrackRideCard(),
                    TrackRideCard(),
                    TrackRideCard(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
