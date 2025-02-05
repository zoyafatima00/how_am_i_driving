import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controllerValue;
  final bool? isPassword;
  final ValueChanged<String>? onChanged; // Add onChanged parameter
  final List<TextInputFormatter>? inputFormatters; // Add inputFormatters parameter

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controllerValue,
    this.isPassword,
    this.onChanged, // Make onChanged optional
    this.inputFormatters, // Make inputFormatters optional
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hideText = true;

  @override
  void initState() {
    hideText = widget.isPassword ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
      child: Container(
        height: 60.0.h,
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: AppColors.TextFIELD_BACKGROUND_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(23.r)),
        ),
        child: TextField(
          obscureText: hideText,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            labelText: widget.hintText,
            labelStyle: TextStyle(
                color: Colors.black.withOpacity(0.5), fontSize: 14.sp),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffix: (widget.isPassword ?? false)
                ? IconButton(
              icon: Icon(
                hideText ? Icons.visibility : Icons.visibility_off,
                color: AppColors.TextFIELD_EYE_COLOR,
              ),
              onPressed: () {
                setState(() {
                  hideText = !hideText;
                });
              },
            )
                : null,
          ),
          controller: widget.controllerValue,
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
          onChanged: widget.onChanged, // Pass the onChanged callback to TextField
          inputFormatters: widget.inputFormatters, // Pass inputFormatters here
        ),
      ),
    );
  }
}
