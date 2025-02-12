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
        //margin: const EdgeInsets.symmetric(vertical: 10),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 38.w,
              height: 38.h,
            ),
            const SizedBox(width: 20),
            Center(
              child: Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Arial'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
