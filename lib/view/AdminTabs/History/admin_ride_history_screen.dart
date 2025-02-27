import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/widgets/trackRideCared_widget.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/color_resources.dart';
import 'admin_ride_history_vm.dart';

class AdminRideHistoryScreen extends StatelessWidget {
  static const route = '/AdminRideHistoryScreen';

  const AdminRideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminRideHistoryVm>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            const Spacer(),
            const Spacer(),
            Text.rich(
              TextSpan(
                text: 'How am I ',
                style: const TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Driving?',
                    style: TextStyle(
                        fontSize: 23,
                        color: AppColors.TextMUSTARD_COLOR,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/bell-solid.png',
                      height: 21.h,
                      width: 23.h,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/person_icon.png',
                      height: 21.h,
                      width: 23.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
          elevation: 0,
          flexibleSpace: const SizedBox(),
          backgroundColor: AppColors.Text_COLOR,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                // Title
                Text(
                  "Violations' Record",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR),
                ),
                SizedBox(height: 16.h),

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
                    TrackRideCard(onTap: () {
                      vm.onHistoryCardClicked(context);
                    }),
                    TrackRideCard(onTap: () {
                      vm.onHistoryCardClicked(context);
                    }),
                    TrackRideCard(onTap: () {
                      vm.onHistoryCardClicked(context);
                    }),
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
