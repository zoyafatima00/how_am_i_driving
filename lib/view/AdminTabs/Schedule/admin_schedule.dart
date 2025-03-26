import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import '../../../widgets/trackRideCared_widget.dart';
import 'admin_schedule_vm.dart';

class AdminScheduleScreen extends StatelessWidget {
  static const route = '/AdminScheduleScreen';

  const AdminScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminScheduleVm>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                // Title
                Text(
                  "Rides' Scheduled",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR),
                ),
                SizedBox(height: 35.h),

                // Violation Records List
                Column(
                  children: [
                    TrackRideCard(
                      onTap: () {},
                      onDetailsTap: () {},
                      driverName: "dummy", // Custom driver's name
                      vehicleName: "dummy", // Custom vehicle's name
                      dropoffLocation: "dummy", // Custom dropoff location
                    )
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
