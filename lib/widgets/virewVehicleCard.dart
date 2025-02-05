import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_resources.dart';

class ViewVehicleCard extends StatelessWidget {
  final String vehicleName; // Driver's name passed from the parent screen
  final String vehicleNumber; // Driver's name passed from the parent screen
  final String
      vehicleImage; // Image URL or asset path passed from the parent screen
  final VoidCallback onTap; // Function to execute on tap

  const ViewVehicleCard({
    super.key,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.vehicleImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Triggers the onTap function when the container is tapped
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
            children: [
              ClipOval(
                child: Container(
                  width: 36.w, // Set the size of the avatar (adjust as needed)
                  height: 36.w, // Set the size of the avatar (adjust as needed)
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(vehicleImage,
                      fit: BoxFit.cover, alignment: Alignment.bottomRight),
                ),
              ),

              SizedBox(width: 16.w), // Space between image and text

              // Column for Driver's Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicleName, // Using the dynamic name passed
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    vehicleNumber, // Using the dynamic name passed
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR,
                    ),
                  ),
                ],
              ),

              // Right side: Action Icons (view, edit, delete)
              Spacer(), // Pushes the icons to the right side
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
