import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_resources.dart';

class ViolationCard extends StatelessWidget {
  final VoidCallback onTap; // Custom function to handle tap event
  final String violationType; // Violation type
  final String driverName; // Driver's name
  final String vehicleName; // Vehicle's name

  // Constructor now takes parameters for dynamic data
  const ViolationCard({
    super.key,
    required this.onTap,
    required this.violationType,
    required this.driverName,
    required this.vehicleName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap, // Trigger the passed onTap function when the container is tapped
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
              // Left column: Type of violation, Driver's name, and Vehicle's name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    violationType, // Use the dynamic violation type
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    driverName, // Use the dynamic driver's name
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    vehicleName, // Use the dynamic vehicle's name
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                        color: AppColors.Text_COLOR),
                  ),
                ],
              ),

              // Right column: View Details button
              ElevatedButton(
                onPressed:
                    onTap, // Trigger the passed onTap function when clicked
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Text_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  "View Details",
                  style: TextStyle(
                      fontSize: 14.sp,
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
