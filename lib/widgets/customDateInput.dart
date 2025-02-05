import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';

class CustomDateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  CustomDateInputField({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
      child: Container(
        height: 56.0.h,
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: AppColors.TextFIELD_BACKGROUND_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(23.r)),
        ),
        child: GestureDetector(
          onTap: () async {
            // Show Date Picker when the field is tapped
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // If a date is selected, format and update the controller
            if (selectedDate != null) {
              controller.text =
                  "${selectedDate.day.toString().padLeft(2, '0')}/" // Day
                  "${selectedDate.month.toString().padLeft(2, '0')}/" // Month
                  "${selectedDate.year}"; // Year
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 14.sp,
                  fontFamily: 'Arial',
                ),
                prefixIcon: null, // No icon on the left
                suffixIcon: SizedBox(
                  height: 10.h,
                  width: 10.w,
                  child: ImageIcon(
                    const AssetImage(
                        'assets/images/calendar-days-solid.png'), // Replace with your asset path
                    color: Colors.black.withOpacity(0.38),
                    size: 6.sp, // Set size directly using the `size` property
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                labelStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 14.sp,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
