import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import 'driverProfile_vm.dart';

class ViewDriverProfileScreen extends StatefulWidget {
  static const route = '/ViewDriverProfileScreen';

  const ViewDriverProfileScreen({super.key});

  @override
  State<ViewDriverProfileScreen> createState() =>
      _ViewDriverProfileScreenState();
}

class _ViewDriverProfileScreenState extends State<ViewDriverProfileScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch driver profile data when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final driverName = ModalRoute.of(context)?.settings.arguments as String?;
      if (driverName != null) {
        final vm = Provider.of<ViewDriverProfileVm>(context, listen: false);
        vm.fetchAdminDetails(driverName, context);

        // Check if the profile picture has already been fetched
        if (vm.id != null &&
            !vm.profilePictures.containsKey(vm.id.toString())) {
          vm.fetchProfilePicture(
              vm.id.toString(), context); // Fetch the profile picture
        }
      } else {
        // Handle the case where driver name is null
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Driver details not found")),
        );
        Navigator.pop(context); // Navigate back
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ViewDriverProfileVm>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Driver Profile'),
      ),
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
                      textAlign: TextAlign.center,
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
              SizedBox(height: 14.h),
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(
                          5.w), // Slightly reduce padding for a tighter fit
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.Text_COLOR.withOpacity(
                            0.1), // Light background color
                      ),
                      child: ClipOval(
                        child: vm.profilePictures[vm.id.toString()] != null
                            ? Image.file(
                                vm.profilePictures[vm.id.toString()]!,
                                fit: BoxFit
                                    .cover, // Ensure the image covers the whole area
                                width: 100
                                    .w, // Ensure the width and height are consistent
                                height: 100
                                    .h, // Circle shape needs to match the width and height
                              )
                            : Image.asset(
                                'assets/images/driver_image.png',
                                fit: BoxFit
                                    .cover, // Make sure the image is scaled properly
                                width: 100.w,
                                height: 100.h, // Ensure it's a perfect circle
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vm.name ?? 'Loading...',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          color: AppColors.TextFIELD_EYE_COLOR,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text('Driver\'s Id: ${vm.id ?? 'Loading...'}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Arial',
                            color: AppColors.TextFIELD_EYE_COLOR,
                          )),
                      Text('CNIC: ${vm.cnic ?? 'Loading...'}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Arial',
                            color: AppColors.TextFIELD_EYE_COLOR,
                          )),
                      Text('Contact: ${vm.contactNumber ?? 'Loading...'}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Arial',
                            color: AppColors.TextFIELD_EYE_COLOR,
                          )),
                      Text(
                        'Address:\n${(vm.address ?? 'Loading...').replaceFirst(',', '\n')}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Arial',
                          color: AppColors.TextFIELD_EYE_COLOR,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.h),
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
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5.h),
                      Text('16',
                          style: TextStyle(
                            color: AppColors.Text_COLOR,
                            fontFamily: 'Arial',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          )),
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
                            color: AppColors.Text_COLOR,
                          )),
                      SizedBox(height: 5.h),
                      Text('1',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.Text_COLOR,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
                decoration: BoxDecoration(
                  color: AppColors.TextFIELD_COLOR.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 25.w),
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
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
                decoration: BoxDecoration(
                  color: AppColors.TextFIELD_COLOR.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.error_outlined, color: AppColors.Text_COLOR),
                        SizedBox(width: 3.h),
                        Text('Violations',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              color: AppColors.Text_COLOR,
                            )),
                      ],
                    ),
                    SizedBox(height: 7.h),
                    Row(
                      children: [
                        SizedBox(width: 25.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text('No Violation Reported',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColors.Text_COLOR,
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
  }
}
