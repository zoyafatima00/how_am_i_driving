import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_constants.dart';

class AdminActionCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color cardColor;
  final VoidCallback onTap;

  const AdminActionCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.cardColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.getScreenWidth(context) * 0.9,
        height: 110.h,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.25,
              blurRadius: 5,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Centered content (icon + text)
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min, // Take only needed space
                children: [
                  Image.asset(
                    iconPath,
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
            ),
            // Invisible placeholder to ensure consistent left padding
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 40.w + 15.w, // Icon width + spacing
                height: 40.h, // Same as icon height
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
