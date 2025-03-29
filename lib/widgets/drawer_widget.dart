import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';

import '../view/bottom_nav/bottom_vm.dart';

class MyDrawer extends StatefulWidget {
  final BottomNavVm vm;

  const MyDrawer({
    required this.vm,
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 60.h),
          // App Header/Logo could be added here
          // _buildAppHeader(),

          // Main navigation items
          _buildDrawerItem(
            title: 'Home',
            icon: Icons.home, // Filled/bold icon
            onTap: () {
              widget.vm.selectedIndex = 0;
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            title: 'Drivers',
            icon: Icons.people_alt, // Filled/bold icon
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            title: 'Vehicles',
            icon: Icons.directions_car_filled, // Filled/bold icon
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            title: 'Schedule',
            icon: Icons.calendar_month, // Filled/bold icon
            onTap: () {
              widget.vm.selectedIndex = 1;
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            title: 'Track Ride',
            icon: Icons.my_location, // Filled/bold icon
            onTap: () {
              widget.vm.selectedIndex = 2;
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            title: 'History',
            icon: Icons.history, // Filled/bold icon
            onTap: () {
              widget.vm.selectedIndex = 3;
              Navigator.pop(context);
            },
          ),

          // Expandable more section with additional items
          ExpansionTile(
            leading: Icon(Icons.more_horiz,
                color: AppColors.TextFIELD_COLOR, weight: 1.5), // Bold icon
            title: Text(
              'More Options',
              style: GoogleFonts.nunito(
                color: AppColors.TextFIELD_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            initiallyExpanded: widget.vm.isMore,
            onExpansionChanged: (expanded) {
              widget.vm.toggleExpansion(expanded);
            },
            children: [
              _buildDrawerItem(
                title: 'How To Use This App',
                icon: Icons.help_center,
                indent: 20,
                onTap: () => _navigateTo(context, '/how-to-use'),
              ),
              _buildDrawerItem(
                title: 'App Tutorials',
                icon: Icons.play_circle_fill,
                indent: 20,
                onTap: () => _navigateTo(context, '/tutorials'),
              ),
              _buildDrawerItem(
                title: 'Safety Guidelines',
                icon: Icons.security,
                indent: 20,
                onTap: () => _navigateTo(context, '/safety'),
              ),
              _buildDrawerItem(
                title: 'Privacy Policy',
                icon: Icons.privacy_tip,
                indent: 20,
                onTap: () => _navigateTo(context, '/privacy'),
              ),
              _buildDrawerItem(
                title: 'Terms of Service',
                icon: Icons.description,
                indent: 20,
                onTap: () => _navigateTo(context, '/terms'),
              ),
              _buildDrawerItem(
                title: 'Rate the App',
                icon: Icons.star_rate,
                indent: 20,
                onTap: () => _launchAppStore(context),
              ),
              _buildDrawerItem(
                title: 'Share App',
                icon: Icons.share,
                indent: 20,
                onTap: () => _shareApp(context),
              ),
            ],
          ),

          // Additional static items
          Divider(color: Colors.grey.shade300, thickness: 1),
          _buildDrawerItem(
            title: 'Settings',
            icon: Icons.settings,
            onTap: () => _navigateTo(context, '/settings'),
          ),
          _buildDrawerItem(
            title: 'Help & Support',
            icon: Icons.help_outline,
            onTap: () => _navigateTo(context, '/support'),
          ),
          _buildDrawerItem(
            title: 'About Us',
            icon: Icons.info,
            onTap: () => _navigateTo(context, '/about'),
          ),
          _buildDrawerItem(
            title: 'Contact Us',
            icon: Icons.contact_mail,
            onTap: () => _navigateTo(context, '/contact'),
          ),
          SizedBox(height: 20.h),
          _buildAppVersion(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    double indent = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.TextFIELD_COLOR,
          weight: 1.5, // Makes icon appear bolder
          size: 24.w, // Slightly larger icons
        ),
        title: Text(
          title,
          style: GoogleFonts.nunito(
            color: AppColors.TextFIELD_COLOR,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildAppVersion() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'Version 1.0.0',
        style: GoogleFonts.nunito(
          color: Colors.grey.shade600,
          fontSize: 12.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Navigation helper methods
  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  void _launchAppStore(BuildContext context) {
    Navigator.pop(context);
    // Implement app store launch logic
  }

  void _shareApp(BuildContext context) {
    Navigator.pop(context);
    // Implement share functionality
  }
}
