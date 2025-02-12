import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../widgets/Admin/admin_action_card.dart';
import 'admin_home_vm.dart'; // Import the StatusCard widget

class AdminHomeScreen extends StatelessWidget {
  static const route = '/AdminHomeScreen';

  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminHomeScreenVm>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    "Organization’s Name",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'arial',
                        color: AppColors.Text_COLOR),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "12th December 2024",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(height: 24.h),
                  Column(
                    children: [
                      AdminActionCard(
                        title: "Rides' Schedule",
                        iconPath: 'assets/images/calendar-days-solid.png',
                        cardColor: AppColors.Text_COLOR, // Customize the color
                        onTap: () {},
                      ),
                      SizedBox(height: 20.h),
                      AdminActionCard(
                        title: "Achievements",
                        iconPath: 'assets/images/medal-solid.png',
                        cardColor: AppColors.TextMUSTARD_COLOR,
                        onTap: () {},
                      ),
                      SizedBox(height: 20.h),
                      AdminActionCard(
                        title: "Violations Record",
                        iconPath:
                            'assets/images/triangle-exclamation-solid.png',
                        cardColor: AppColors.TextFIELD_COLOR,
                        onTap: () {},
                      ),
                      SizedBox(height: 20.h),
                      AdminActionCard(
                        title: "Rides' History",
                        iconPath: 'assets/images/car-solid (1).png',
                        cardColor: AppColors.HISTORY_CARD_COLOR,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
