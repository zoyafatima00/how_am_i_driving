import 'dart:io'; // Import for File

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_resources.dart';

class ViewVehicleCard extends StatelessWidget {
  final String vehicleName;
  final String vehicleNumber;
  final File? vehicleImage; // Use File for the vehicle image
  final VoidCallback onTap;

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
            children: [
              ClipOval(
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: vehicleImage != null
                      ? Image.file(
                          vehicleImage!, // Use the File object
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        )
                      : Image.asset(
                          'assets/images/modern-black-delivery-van_1311569-447.png', // Fallback image
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicleName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    vehicleNumber,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    size: 20.sp,
                    color: AppColors.Text_COLOR,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.edit,
                    size: 20.sp,
                    color: AppColors.Text_COLOR,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.delete_rounded,
                    size: 20.sp,
                    color: AppColors.Text_COLOR,
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
