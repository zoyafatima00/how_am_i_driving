import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Future customMessageDialog(
    {required BuildContext context,
    required String msg,
    required bool isError,
    Function()? onTap}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
          child: Material(
        color: Colors.transparent,
        child: Container(
          width: 330.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18.r)),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/svg/msg_$isError.svg'),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        isError ? 'Error' : "Success",
                        style: GoogleFonts.nunito(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: Text(
                          msg,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  height: 1,
                ),
                InkWell(
                  onTap: onTap ?? () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                    child: Center(
                      child: Text(
                        'OK',
                        style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          color: const Color(0xff5D6EA9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    },
  );
}
