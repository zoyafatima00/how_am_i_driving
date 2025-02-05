import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:how_am_i_driving/view/tabs/Schedule/scheduleProfile_vm.dart';
import 'package:provider/provider.dart';

class ViewcheduleProfileScreen extends StatelessWidget {
  static const route = '/ViewScheduleProfileScreen';

  const ViewcheduleProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewScheduleProfileScreenVm>(builder: (context, vm, _) {
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
          padding: EdgeInsets.all(16.w),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.Text_COLOR.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 6.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: ListView(
              children: [
                _buildDetailRow("Ride Number", "12345", "Date", "01/01/2025",
                    "Time", "10:00 AM"),
                _buildDetailRow(
                    "Driver", "Driver's ID", "Driver's Name", "", "", ""),
                _buildDetailRow(
                    "Vehicle", "Vehicle's ID", "Vehicle's Name", "", "", ""),
                _buildDetailRow("Task", "Details", "", "", "", ""),
                _buildDetailRow("Address", "Address", "", "", "", ""),
                _buildDetailRow(
                    "Supervisor", "Sup.'s ID", "Supervisor's Name", "", "", ""),
                _buildDetailRow("Time Allocated", "Time", "", "", "", ""),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDetailRow(String title, String id, String name, String dateLabel,
      String dateValue, String timeLabel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 6.h),
              Text(id,
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.normal)),
              SizedBox(height: 6.h),
              Text(name,
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.normal)),
              SizedBox(height: 6.h),
              dateLabel.isNotEmpty
                  ? Text(dateLabel,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.normal))
                  : SizedBox(),
              dateValue.isNotEmpty
                  ? Text(dateValue,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.normal))
                  : SizedBox(),
              timeLabel.isNotEmpty
                  ? Text(timeLabel,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.normal))
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
