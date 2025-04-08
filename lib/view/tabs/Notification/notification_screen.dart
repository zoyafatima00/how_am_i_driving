import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import '../../../widgets/violationCard_widget.dart';
import 'notification_vm.dart';

class NotificationScreen extends StatelessWidget {
  static const route = '/NotificationScreen';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationScreenVm>(builder: (context, vm, _) {
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
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial'),
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
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 14.h),
                // Title
                Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR),
                ),
                SizedBox(height: 16.h),

                // Date and Time label
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "07/04/2025",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Arial',
                          color: Colors.black),
                    ),
                    Text(
                      "12:00 AM",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Arial',
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Violation Records List
                Column(
                  children: [
                    ViolationCard(
                      onTap: () {
                        vm.onNotificationCardClicked(context);
                      },
                      violationType: "Over Speeding",
                      driverName: "Rashid Khan",
                      vehicleName: "Suzuki Bolan",
                    ),
                    ViolationCard(
                      onTap: () {
                        vm.onNotificationCardClicked(context);
                      },
                      violationType: "Traffic Light Violation",
                      driverName: "Rashid Khan",
                      vehicleName: "Suzuki Bolan",
                    ),
                    ViolationCard(
                      onTap: () {
                        vm.onNotificationCardClicked(context);
                      },
                      violationType: "Zebra Crossing Violation",
                      driverName: "Rashid Khan",
                      vehicleName: "Suzuki Bolan",
                    ),
                    ViolationCard(
                      onTap: () {
                        vm.onNotificationCardClicked(context);
                      },
                      violationType: "Lane Violation",
                      driverName: "Rashid Khan",
                      vehicleName: "Suzuki Bolan",
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
