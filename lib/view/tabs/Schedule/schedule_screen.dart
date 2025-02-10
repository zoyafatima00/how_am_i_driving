import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/app_constants.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../widgets/ScheduleRideCard.dart';
import 'schedule_vm.dart'; // Assuming this is the correct file for your ViewModel

class ScheduleScreen extends StatelessWidget {
  static const route = '/ScheduleScreen';

  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleScreenVm>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 14.h),
                // Title with Icon and Plus symbol above
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Rides' Scheduled",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'arial',
                            color: AppColors.Text_COLOR),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: AppColors.Text_COLOR.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/calendar-days-solid.png',
                            color: AppColors.Text_COLOR,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                        Positioned(
                          top: -10.h,
                          right: 6,
                          bottom: 12,
                          child: Icon(
                            Icons.add,
                            size: 10.w,
                            color: AppColors.Text_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 14.h),

                // Search Bar
                Container(
                  width: AppConstants.getScreenWidth(context) * 0.85,
                  height: AppConstants.getScreenWidth(context) * 0.11,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.TextFIELD_COLOR.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_sharp,
                          size: 20.sp,
                          color: AppColors.TextFIELD_COLOR,
                        ),
                        SizedBox(
                            width: 8
                                .w), // Add spacing between the icon and the text field
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search by name or id',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontFamily:
                                  'Arial', // Change the font family here
                              fontSize: 15.sp, // Adjust the font size
                              color: AppColors
                                  .TextFIELD_COLOR, // Change the text color here
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 23.h),

                // Rides List
                Column(
                  children: [
                    ScheduleRideCard(
                      driverName: 'Driver\'s Name',
                      vehicleName: 'vehicle\'s Name',
                      dropOffLocation: 'dropOffLocation',
                      onTap: () {
                        vm.onViewScheduleProfileClicked(context);
                      },
                    ),
                    ScheduleRideCard(
                      driverName: 'Driver\'s Name',
                      vehicleName: 'vehicle\'s Name',
                      dropOffLocation: 'dropOffLocation',
                      onTap: () {
                        vm.onViewScheduleProfileClicked(context);
                      },
                    ),
                    ScheduleRideCard(
                      driverName: 'Driver\'s Name',
                      vehicleName: 'vehicle\'s Name',
                      dropOffLocation: 'dropOffLocation',
                      onTap: () {
                        vm.onViewScheduleProfileClicked(context);
                      },
                    ),
                    ScheduleRideCard(
                      driverName: 'Driver\'s Name',
                      vehicleName: 'vehicle\'s Name',
                      dropOffLocation: 'dropOffLocation',
                      onTap: () {
                        vm.onViewScheduleProfileClicked(context);
                      },
                    ),
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
