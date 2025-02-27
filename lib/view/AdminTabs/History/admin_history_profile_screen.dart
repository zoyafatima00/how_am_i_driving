import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import 'admin_hostory_profile_vm.dart';

class AdminHistoryProfileScreen extends StatelessWidget {
  static const route = '/AdminHistoryProfileScreen';

  const AdminHistoryProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminHistoryProfileVm>(builder: (context, vm, _) {
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
                SizedBox(height: 14.h),
                Text(
                  textAlign: TextAlign.center,
                  "Rides' Scheduled",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'arial',
                      color: AppColors.Text_COLOR),
                ),
                SizedBox(height: 25.h),
                Text(
                  textAlign: TextAlign.center,
                  "Successfully Completed!",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'arial',
                      color: AppColors.TextMUSTARD_COLOR),
                ),
                SizedBox(height: 14.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.TextMUSTARD_COLOR,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 6.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Ride Number",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            Text(
                              "Time",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildSection("Driver", ["Driver's ID", "Driver's Name"]),
                      _buildSection(
                          "Vehicle", ["Vehicle's ID", "Vehicle's Name"]),
                      _buildSection("Task", ["Details"]),
                      _buildSection("Address", ["Address"]),
                      _buildSection(
                          "Supervisor", ["Sup.'s ID", "Supervisor's Name"]),
                      _buildSection("Time Allocated", ["Time"]),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSection(String title, List<String> values) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Wrap(
            spacing: 12.w,
            children: values
                .map((text) => Text(
                      text,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ))
                .toList(),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
