import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/view/tabs/Schedule/scheduleProfile_vm.dart';
import 'package:intl/intl.dart'; // Add this import
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';

class ViewScheduleProfileScreen extends StatelessWidget {
  static const route = '/ViewScheduleProfileScreen';

  final Map<String, dynamic> rideDetails;

  const ViewScheduleProfileScreen({super.key, required this.rideDetails});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewScheduleProfileScreenVm>(builder: (context, vm, _) {
      String formattedDate = _formatDate(rideDetails['date']);
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
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.Text_COLOR,
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
                              "Ride Number: ${rideDetails['id']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Date: $formattedDate", // Use the formatted date here
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            Text(
                              "Time: ${rideDetails['time']}",
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
                      _buildSection("Driver", [
                        "Driver's ID: ${rideDetails['driver_id']}",
                        "Driver's Name: ${rideDetails['driver_name']}"
                      ]),
                      _buildSection("Vehicle", [
                        "Vehicle's ID: ${rideDetails['vehicle_number']}",
                        "Vehicle's Name: ${rideDetails['vehicle_name']}"
                      ]),
                      _buildSection(
                          "Task", ["Details: ${rideDetails['task']}"]),
                      _buildSection(
                          "Address", ["Address: ${rideDetails['address']}"]),
                      _buildSection("Supervisor",
                          ["Supervisor's Name: ${rideDetails['supervisor']}"]),
                      _buildSection("Time Allocated",
                          ["Time: ${rideDetails['allocated_time_for_task']}"]),
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
          SizedBox(height: 5.h),
          Wrap(
            spacing: 12.w,
            children: values
                .map((text) => Text(
                      text,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Colors.white, // Set underline color explicitly
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  // Helper method to format the date
  String _formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return dateString; // Return the original string if parsing fails
    }
  }
}
