import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../widgets/actionCard_widget.dart';
import '../../../widgets/statusCard_widget.dart'; // Import the ActionCard widget
import 'home_vm.dart'; // Import the StatusCard widget

class HomeScreen extends StatelessWidget {
  static const route = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenVm>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 14.h),
                  Text(
                    "Organization’s Name",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'arial',
                        color: AppColors.Text_COLOR),
                  ),
                  Text(
                    "12th December 2024",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'arial',
                        color: Colors.black),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    "12 Rides Scheduled",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'arial',
                        color: AppColors.TextMUSTARD_COLOR),
                  ),
                  SizedBox(height: 23.h),
                  // First row of Status Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusCard(
                        title: "In Garage",
                        count: 24,
                        color: AppColors.Text_COLOR,
                        imagePath:
                            'assets/images/warehouse-solid.png', // Pass the path of the image
                      ),
                      StatusCard(
                        title: "On the way",
                        count: 15,
                        color: AppColors.Text_COLOR,
                        imagePath:
                            'assets/images/car-side-solid.png', // Pass the path of the image
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  // Action Cards
                  ActionCard(
                    title: "Driver",
                    color: AppColors.TextMUSTARD_COLOR,
                    iconPath: 'assets/images/driver_icon.png',
                    onViewButtonTap: () {
                      vm.onViewDriverClicked(context);
                    },
                    onAddButtonTap: () {
                      vm.onAddDriverClicked(context);
                    },
                  ),

                  SizedBox(height: 20.h),
                  ActionCard(
                    title: "Vehicle",
                    color: AppColors.TextFIELD_COLOR,
                    iconPath: 'assets/images/car-side-solid.png',
                    onViewButtonTap: () {
                      vm.onViewVehicleClicked(context);
                    },
                    onAddButtonTap: () {
                      vm.onAddVehicleClicked(context);
                    },
                  ),
                  SizedBox(height: 20.h),
                  ActionCard(
                    title: "Rides' Schedule",
                    color: Color(0xFFB4B4B4),
                    iconPath: 'assets/images/calendar-days-solid.png',
                    onViewButtonTap: () {
                      vm.onViewScheduleClicked(context);
                    },
                    onAddButtonTap: () {
                      vm.onAddScheduleClicked(context);
                    },
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
