import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:how_am_i_driving/view/tabs/Home/Driver/driverProfile_vm.dart';
import 'package:provider/provider.dart';

class ViewDriverProfileScreen extends StatelessWidget {
  static const route = '/ViewDriverProfileScreen';

  const ViewDriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewDriverProfileVm>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Navigator.pop(context); // Navigate back to the HomeScreen
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
                    onTap: () {
                      // Handle notification tap
                    },
                    child: Image.asset(
                      'assets/images/bell-solid.png',
                      height: 21.h,
                      width: 23.h,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      // Handle profile tap
                    },
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
            child: Column(
              children: [
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Profile",
                        textAlign: TextAlign.center, // Centers the text itself
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'arial',
                          color: AppColors.Text_COLOR,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: AppColors.Text_COLOR.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/user-pen-solid.png',
                        color: AppColors.Text_COLOR,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ],
                ),
                // Profile Section
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(
                            15.w), // Add padding here to create space
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.Text_COLOR.withOpacity(
                              0.1), // Outer circle color
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/driver_image.png', // Path to your image
                            fit: BoxFit
                                .cover, // Ensures the image covers the entire circle
                            width: 80
                                .w, // Image width (adjust this value based on your needs)
                            height: 105
                                .h
                                .w, // Image height (adjust this value based on your needs)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      children: [
                        Text(
                          'Usama',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              color: AppColors.TextFIELD_EYE_COLOR),
                        ),
                        SizedBox(height: 4.h),
                        Text('Driver\'s Id',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Arial',
                                color: AppColors.TextFIELD_EYE_COLOR)),
                        Text('CNIC: xxxxx-xxxxxxx-x',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Arial',
                                color: AppColors.TextFIELD_EYE_COLOR)),
                        Text('Contact Number',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Arial',
                                color: AppColors.TextFIELD_EYE_COLOR)),
                        Text('Address',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Arial',
                                color: AppColors.TextFIELD_EYE_COLOR)),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Total Number of Rides',
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.Text_COLOR,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.h),
                        Text('16',
                            style: TextStyle(
                                color: AppColors.Text_COLOR,
                                fontFamily: 'Arial',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Number of Violations',
                            style: TextStyle(
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: AppColors.Text_COLOR)),
                        SizedBox(height: 5.h),
                        Text('1',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColors.Text_COLOR,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                // Achievements Section
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: AppColors.TextFIELD_COLOR.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row for the title "Achievements" with the icon
                      Row(
                        children: [
                          Icon(Icons.emoji_events, color: AppColors.Text_COLOR),
                          SizedBox(width: 3.h),
                          Text('Achievements',
                              style: TextStyle(
                                color: AppColors.Text_COLOR,
                                fontFamily: 'Arial',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      SizedBox(height: 7.h),

                      // Wrap the text in a Row and use Expanded to align it properly
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left side indentation to align with the "Achievements" title
                          SizedBox(
                              width: 25
                                  .w), // Adjust this value to control alignment with the "Achievements"
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Safe Driving Streaks',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.TextMUSTARD_COLOR,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Arial',
                                    )),
                                SizedBox(height: 5.h),
                                Text('Achievement Badges',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.TextMUSTARD_COLOR,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Arial',
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: AppColors.TextFIELD_COLOR.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row for the title "Achievements" with the icon
                      Row(
                        children: [
                          Icon(Icons.error_outlined,
                              color: AppColors.Text_COLOR),
                          SizedBox(width: 3.h),
                          Text('Violation Details',
                              style: TextStyle(
                                color: AppColors.Text_COLOR,
                                fontFamily: 'Arial',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      SizedBox(height: 7.h),

                      // Wrap the text in a Row and use Expanded to align it properly
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left side indentation to align with the "Achievements" title
                          SizedBox(
                              width: 25
                                  .w), // Adjust this value to control alignment with the "Achievements"
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Weekly/Monthly Summary',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.TextMUSTARD_COLOR,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Arial',
                                    )),
                                Text(
                                    'Graphs showing trends in violations, scores, and driving hours.',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.TextFIELD_EYE_COLOR)),
                                SizedBox(height: 5.h),
                                Text('Corrective Actions Taken',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.TextMUSTARD_COLOR,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Arial',
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
