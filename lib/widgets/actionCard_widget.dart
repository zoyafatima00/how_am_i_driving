import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constants.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final Color color;
  final String iconPath;
  final VoidCallback? onCardTap; // New callback for tap event
  final VoidCallback? onViewButtonTap; // New callback for "View" button tap
  final VoidCallback? onAddButtonTap; // New callback for "View" button tap

  const ActionCard(
      {super.key,
      required this.title,
      required this.color,
      required this.iconPath,
      this.onCardTap, // Accept callback for card tap
      this.onViewButtonTap, // Accept callback for "View" button tap
      this.onAddButtonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap, // Use the passed callback to handle the container tap
      child: Container(
        width: AppConstants.getScreenWidth(context) * 0.9,
        height: 120.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25.0.w),
              child: Image.asset(
                iconPath,
                height: 40.h,
                width: 40.w,
              ),
            ),
            SizedBox(width: 30.w),
            Container(
              width: 2.w,
              height: 65.h,
              color: Colors.white,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'arial'),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onAddButtonTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 6.0.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          height: 30.h,
                          width: 75.w,
                          child: const Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      GestureDetector(
                        onTap:
                            onViewButtonTap, // Use the passed callback for the "View" button tap
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 6.0.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          height: 30.h,
                          width: 75.w,
                          child: const Center(
                            child: Text(
                              "View",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }
}
