import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_resources.dart';

class TrackRideCard extends StatelessWidget {
  final VoidCallback onTap; // Callback for the entire card
  final VoidCallback onDetailsTap; // Callback for the "View Details" button
  final String driverName;
  final String vehicleName;
  final String dropoffLocation;

  const TrackRideCard({
    super.key,
    required this.onTap,
    required this.onDetailsTap,
    required this.driverName,
    required this.vehicleName,
    required this.dropoffLocation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              // Left column: Driver's name, Vehicle's name, and Dropoff location
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driverName,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    vehicleName,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    dropoffLocation,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                ],
              ),

              // Right column: View Details button
              ElevatedButton(
                onPressed: onDetailsTap, // Use the custom callback
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Text_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  "View Details",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
