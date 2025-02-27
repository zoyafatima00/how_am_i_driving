import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/app_constants.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:how_am_i_driving/view/tabs/Home/Driver/viewDriver_vm.dart';
import 'package:how_am_i_driving/widgets/viewDriverCard.dart';
import 'package:provider/provider.dart';

class ViewDriverScreen extends StatelessWidget {
  static const route = '/ViewDriverScreen';

  const ViewDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ViewDriverScreenVm>(context, listen: false);

    // Fetch admin names when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vm.adminNames.isEmpty) {
        // Only fetch data if it hasn't been fetched yet
        vm.fetchAdminNames(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Drivers'),
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
                      "Drivers",
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
                      'assets/images/Group 92.png',
                      color: AppColors.Text_COLOR,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Container(
                width: AppConstants.getScreenWidth(context) * 0.85,
                height: AppConstants.getScreenWidth(context) * 0.11,
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
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
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search by name or id',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 15.sp,
                            color: AppColors.TextFIELD_COLOR,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 23.h),
              // Use Consumer to limit rebuilds to the list of drivers
              Consumer<ViewDriverScreenVm>(
                builder: (context, vm, _) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vm.adminNames.length,
                    itemBuilder: (context, index) {
                      final adminId =
                          (index + 1).toString(); // Convert to String
                      return ViewDriverCard(
                        driverName: vm.adminNames[index],
                        driverImageFile:
                            vm.profilePictures[adminId], // Use String key
                        onTap: () {
                          final driverName =
                              vm.adminNames[index]; // Get the driver name
                          print("Driver Name: $driverName"); // Debug statement
                          vm.onViewDriverProfileClicked(
                              context, driverName); // Pass driverName
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
