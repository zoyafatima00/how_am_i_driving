import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/app_constants.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../widgets/violationCard_widget.dart';
import 'history_vm.dart'; // Assuming this is the correct file for your ViewModel

class HistoryScreen extends StatelessWidget {
  static const route = '/HistoryScreen';

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryScreenVm>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 14.h),
                // Title
                Text(
                  "Violation History",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR),
                ),
                SizedBox(height: 14.h),

                // Search Bar
                Container(
                  width: AppConstants.getScreenWidth(context) * 0.85,
                  height: AppConstants.getScreenWidth(context) * 0.11,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.TextFIELD_COLOR.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_sharp,
                          size: 20.sp,
                          color: AppColors.TextFIELD_COLOR,
                        ),
                        SizedBox(
                            width: 8
                                .w), // Add spacing between the icon and the text field
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search by name or id',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontFamily:
                                  'Arial', // Change the font family here
                              fontSize: 15.sp, // Adjust the font size
                              color: AppColors
                                  .TextFIELD_COLOR, // Change the text color here
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 23.h),

                // Date and Time label
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DD/MM/YY",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Arial',
                          color: Colors.black),
                    ),
                    Text(
                      "Time",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Arial',
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Violation Records List
                Column(
                  children: [
                    ViolationCard(
                      onTap: () {
                        vm.onHistoryProfileClicked(context);
                      },
                    ),
                    ViolationCard(
                      onTap: () {
                        vm.onHistoryProfileClicked(context);
                      },
                    ),
                    ViolationCard(
                      onTap: () {
                        vm.onHistoryProfileClicked(context);
                      },
                    ),
                    ViolationCard(
                      onTap: () {
                        vm.onHistoryProfileClicked(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
