import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_resources.dart';
import '../../../widgets/Admin/achievement_card.dart';
import 'achievemnt_vm.dart';

class AchievementScreen extends StatelessWidget {
  static const route = '/AchievementScreen';

  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AchievementVm>(builder: (context, vm, _) {
      return Scaffold(
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
                  "Achievements",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Arial',
                      color: AppColors.Text_COLOR),
                ),
                SizedBox(height: 35.h),

                // Safe Driving Streaks Section
                AchievementCard(
                  title: "Safe Driving Streaks",
                  subtitle: "Days without any violations.",
                  badgeText: '7 days: "Cautious Cruiser" Badge',
                  badgeImage:
                      'assets/images/cautious_cruiser_badge.png', // Change to your image path
                  onTap: () {
                    // Handle Safe Driving Streaks onTap action
                  },
                ),

                // Achievement Badges Section
                AchievementCard(
                  title: "Achievement Badges",
                  subtitle: "For completing 50 days without lane violation",
                  badgeText: '"Lane Champ" Badge',
                  badgeImage:
                      'assets/images/lane_champ_badge.png', // Change to your image path
                  onTap: () {
                    // Handle Achievement Badges onTap action
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
