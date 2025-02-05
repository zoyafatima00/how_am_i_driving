import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_resources.dart';

class ScheduleRideCard extends StatelessWidget {
  final String driverName; // Driver's name passed from the parent screen
  final String vehicleName; // Vehicle name passed from the parent screen
  final String
      dropOffLocation; // Dropoff location passed from the parent screen
  final VoidCallback onTap; // Function to execute on tap

  const ScheduleRideCard({
    super.key,
    required this.driverName,
    required this.vehicleName,
    required this.dropOffLocation,
    required this.onTap, // Callback for onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Calls the onTap function passed from the parent screen
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.Text_COLOR.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left column: Driver's Name and Vehicle's Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driverName, // Using the dynamic driver name passed
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    vehicleName, // Using the dynamic vehicle name passed
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    dropOffLocation, // Using the dynamic drop-off location passed
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                ],
              ),

              // Right column: Action Icons (view, edit, delete)
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye, // Eye icon for viewing
                    size: 20.sp,
                    color: AppColors.Text_COLOR,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.edit, // Pencil icon for editing
                    size: 20.sp,
                    color: AppColors.Text_COLOR,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.delete_rounded, // Trash bin icon for deletion
                    size: 20.sp,
                    color:
                        AppColors.Text_COLOR, // Red color for the delete icon
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
