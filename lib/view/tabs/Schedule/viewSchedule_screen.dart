import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/app_constants.dart';
import 'package:how_am_i_driving/view/tabs/Schedule/viewSchedule_vm.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_resources.dart';
import '../../../widgets/ScheduleRideCard.dart';

class ViewScheduleScreen extends StatelessWidget {
  static const route = '/ViewScheduleScreen';

  const ViewScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViewScheduleScreenVm()..fetchRideDetails(),
      child: Consumer<ViewScheduleScreenVm>(builder: (context, vm, _) {
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
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 14.h),
                  // Title with Icon and Plus symbol above
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rides' Scheduled",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'arial',
                            color: AppColors.Text_COLOR),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.Text_COLOR.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/calendar-days-solid.png',
                              color: AppColors.Text_COLOR,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                          Positioned(
                            top: -10.h,
                            right: 6,
                            bottom: 12,
                            child: Icon(
                              Icons.add,
                              size: 10.w,
                              color: AppColors.Text_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ],
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

                  // Rides List
                  vm.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: vm.rideList.map((ride) {
                            return ScheduleRideCard(
                              driverName:
                                  ride['driver_name'] ?? 'Driver\'s Name',
                              vehicleName:
                                  ride['vehicle_name'] ?? 'Vehicle\'s Name',
                              dropOffLocation:
                                  ride['address'] ?? 'Drop Off Location',
                              onTap: () {
                                vm.onViewScheduleProfileClicked(context, ride);
                              },
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
