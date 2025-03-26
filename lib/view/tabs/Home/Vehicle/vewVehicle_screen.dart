import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/app_constants.dart';
import 'package:how_am_i_driving/view/tabs/Home/Vehicle/viewVehicle_vm.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_resources.dart';
import '../../../../widgets/virewVehicleCard.dart';

class ViewVehicleScreen extends StatelessWidget {
  static const route = '/ViewVehicleScreen';

  const ViewVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewVehicleScreenVm>(builder: (context, vm, _) {
      // Fetch vehicle details if it's empty
      if (vm.vehicleNames.isEmpty) {
        vm.fetchVehicleDetails(
            context); // Fetch the data if not already fetched
      }

      // Debugging: Print vehicleNames and vehicleNumbers here
      print("Vehicle Names: ${vm.vehicleNames}");
      print("Vehicle Numbers: ${vm.vehicleNumbers}");

      // Show a loading spinner if the data is still being fetched
      if (vm.vehicleNames.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

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
            Text.rich(
              TextSpan(
                text: 'How am I ',
                style: const TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Driving?',
                    style: TextStyle(
                      fontSize: 23,
                      color: AppColors.TextMUSTARD_COLOR,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.normal,
                    ),
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
                        "Vehicles",
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
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.Text_COLOR.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/Group 60.png',
                        color: AppColors.Text_COLOR,
                        height: 25.h,
                        width: 26.w,
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
                // Display the list of vehicles
                Consumer<ViewVehicleScreenVm>(
                  builder: (context, vm, _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vm.vehicleNames.length,
                      itemBuilder: (context, index) {
                        final vehicleName = vm.vehicleNames[index];
                        final vehicleNumber = vm.vehicleNumbers[index];
                        final vehicleImage = vm.vehicleImages[vehicleNumber];

                        return ViewVehicleCard(
                          vehicleName: vehicleName,
                          vehicleNumber: vehicleNumber,
                          vehicleImage: vehicleImage, // Pass the File object
                          onTap: () {
                            vm.onViewVehicleProfileClicked(
                                context, vehicleName, vehicleNumber);
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
    });
  }
}
