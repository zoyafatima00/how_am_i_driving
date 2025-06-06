import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import 'notificationProfile_vm.dart';

class NotificationProfileScreen extends StatelessWidget {
  static const route = '/NotificationProfileScreen';
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProfileVm>(builder: (context, vm, _) {
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 18.h),
                // Title
                Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR),
                ),
                SizedBox(height: 20.h),
                _buildViolationDetails(),
                SizedBox(height: 20.h),
                // _buildViolationVideo(),
                SizedBox(height: 20.h),
                //_buildCurrentLocation(),
                SizedBox(height: 20.h),
                // CustomButton(
                //     isEnabled: true,
                //     buttonText: 'View Report',
                //     onPressed: () {
                //       // Navigator.pop();
                //     }),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildViolationDetails() {
    return BlueCardWidget(
      title: 'Violation Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Violation ID', '01'),
          _buildDetailRow('Violation Type', 'Over Speeding'),
          _buildDetailRow('Date & Time', '2025-04-07 12:00 PM'),
          Divider(),
          _buildDetailRow('Driver Id', '03'),
          _buildDetailRow('Driver Name', 'Rashid Khan'),
          Divider(),
          _buildDetailRow('Vehicle Id', 'RIL-8472'),
          _buildDetailRow('Vehicle Name', 'Suzuki Bolan'),
          Divider(),
          //_buildDetailRow('Task', 'Over Speeding'),
          _buildDetailRow('Details', 'Speed exceeded 100 km/h over limit'),
        ],
      ),
    );
  }

  Widget _buildViolationVideo() {
    return BlueCardWidget(
      title: 'Violation Video',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
                'assets/images/overhead-traffic-lights-high-street-miami-florida_127089-34685.png'), // Replace with actual video thumbnail
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentLocation() {
    return BlueCardWidget(
      title: 'Current Location',
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 8.0), // Consistent padding
        child: Text(
          'City: Example City, Street: Example Street',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Arial',
            fontSize: 16.sp, // Consistent font size
          ),
        ),
      ),
    );
  }

  Widget _buildViewReport() {
    return BlueCardWidget(
      title: 'View Report',
      child: GestureDetector(
        onTap: () {
          // Handle "View Report" action
        },
        child: Text(
          'View Report',
          style: TextStyle(color: Colors.blue, fontFamily: 'Arial'),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial'),
        ),
        Text(value, style: TextStyle(color: Colors.white, fontFamily: 'Arial')),
      ],
    );
  }
}

class BlueCardWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const BlueCardWidget({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.Text_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Ensure consistent padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Arial'),
            ),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
