import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final String imagePath;

  const StatusCard(
      {super.key,
      required this.title,
      required this.count,
      required this.color,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath, // Load the image based on the path provided
            height: 30.h, // Adjust the size of the image
            width: 30.w, // Adjust the size of the image
          ),
          SizedBox(height: 3.h),
          Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'arial'),
          ),
          SizedBox(height: 5.h),
          Text(
            count.toString(),
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'arial'),
          ),
        ],
      ),
    );
  }
}
