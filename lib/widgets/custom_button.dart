import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';

import '../utils/app_constants.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  bool? isLoading;
  bool? isEnabled;
  Widget? widget;
  VoidCallback? onPressed;
  CustomButton(
      {this.isLoading,
      this.isEnabled,
      this.widget,
      super.key,
      required this.buttonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled != null && isEnabled! == true ? 1 : 0.65,
      child: Container(
        width: AppConstants.getScreenWidth(context) * 0.4,
        height: 48.23.h,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(40.r), // Match the button's border radius
          boxShadow: const [],
        ),
        child: ElevatedButton(
          onPressed: (isEnabled ?? false) ? onPressed : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.Text_COLOR, // Text color
            disabledBackgroundColor: AppColors.Text_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40), // Border radius
            ),
          ),
          child: isLoading != null && isLoading! == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : widget ??
                  Text(buttonText,
                      style: GoogleFonts.nunito(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
        ),
      ),
    );
  }
}
