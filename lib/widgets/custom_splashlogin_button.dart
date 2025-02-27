import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';

import '../utils/app_constants.dart';

class CustomLoginOptionButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomLoginOptionButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Trigger onPressed when the container is tapped
      child: Container(
        width: AppConstants.getScreenWidth(context) * 0.73,
        height: 53.h,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(40.r), // Match the button's border radius
          color: AppColors.TextMUSTARD_COLOR,
          boxShadow: const [],
        ),
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40), // Border radius
            ),
          ),
          child: Text(buttonText,
              style: GoogleFonts.nunito(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
