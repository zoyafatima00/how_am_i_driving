import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:provider/provider.dart';

import '../../utils/app_constants.dart';
import '../../widgets/drawer_widget.dart';
import 'bottom_vm.dart';

class BottomNavScreen extends StatelessWidget {
  static const String route = '/BottomNavScreen';
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavVm>(builder: (context, vm, _) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                'assets/images/menu-burger.png',
                height: 15.h,
                width: 19.w,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
          actions: [
            const Spacer(),
            const Spacer(),
            // Title Section with Text.rich
            Text.rich(
              TextSpan(
                text: 'How am I ', // First part of the text
                style: const TextStyle(
                    fontSize: 23, // Font size for the first part
                    color: Colors.white, // Color for the first part
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Driving?', // Second part of the text
                    style: TextStyle(
                        fontSize: 23, // Font size for the second part (Driving)
                        color: AppColors
                            .TextMUSTARD_COLOR, // Color for the word "Driving"
                        fontFamily:
                            'Pacifico', // Change this to your desired font
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
                      vm.onNotifcationClicked(context);
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
                      'assets/images/person_icon.png', // PNG icon for person/profile
                      height: 21.h,
                      width: 23.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
          elevation: 0,
          flexibleSpace:
              const SizedBox(), // Use an empty container for flexible space
          backgroundColor:
              AppColors.Text_COLOR, // Set the AppBar background color to blue
        ),
        drawer: MyDrawer(
          vm: vm,
        ),
        // Ensure the body background color is white
        backgroundColor: Colors.white,
        body: vm.pages[vm.selectedIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          child: BottomNavigationBar(
            selectedFontSize: 14.sp,
            unselectedFontSize: 12.sp,
            selectedLabelStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: AppColors.Text_COLOR),
            unselectedLabelStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
                color: const Color(0xff5D6EA9).withOpacity(0.5)),
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors
                .BOTTOM_NAV_COLOR, // Set the Bottom Navigation background color to white
            onTap: (index) {
              if (index < vm.pages.length) {
                // Ensure index is within range
                AppConstants.showScreen = false;
                vm.selectedIndex = index;
              }
            },
            currentIndex: vm.selectedIndex,
            unselectedItemColor: AppColors.TextFIELD_COLOR,
            selectedItemColor: AppColors.Text_COLOR,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Image.asset(
                      'assets/images/home.png',
                      color: vm.selectedIndex == 0
                          ? AppColors.Text_COLOR
                          : AppColors.TextFIELD_COLOR,
                    ),
                  ),
                ),
                tooltip: 'Home',
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Image.asset(
                      'assets/images/calendar-days-solid.png',
                      color: vm.selectedIndex == 1
                          ? AppColors.Text_COLOR
                          : AppColors.TextFIELD_COLOR,
                    ),
                  ),
                ),
                tooltip: 'Schedule',
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Image.asset(
                      'assets/images/location-crosshairs-solid.png',
                      color: vm.selectedIndex == 2
                          ? AppColors.Text_COLOR
                          : AppColors.TextFIELD_COLOR,
                    ),
                  ),
                ),
                tooltip: 'Track Ride',
                label: 'Track Ride',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Image.asset(
                      'assets/images/clock-rotate-left-solid.png',
                      color: vm.selectedIndex == 3
                          ? AppColors.Text_COLOR
                          : AppColors.TextFIELD_COLOR,
                    ),
                  ),
                ),
                tooltip: 'History',
                label: 'History',
              ),
            ],
          ),
        ),
      );
    });
  }
}
