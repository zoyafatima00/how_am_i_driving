import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/bottom_nav/admin_bottom_nav_vm.dart';

class MyAdminDrawer extends StatefulWidget {
  final AdminBottomNavVm vm;

  const MyAdminDrawer({
    required this.vm,
    super.key,
  });

  @override
  State<MyAdminDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyAdminDrawer> {
  @override
  Widget build(BuildContext context) {
    var moreList = [
      if (widget.vm.isMore)
        for (int i = 0; i < widget.vm.moreList.length; i++)
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10.h,
                  top: 2.h,
                  left: 60.w,
                ),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    widget.vm.moreList[i],
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.white,
                      height: 1.5.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white60,
            ),
            child: Column(
              children: [
                // Removed the CircleAvatar for profile picture
                SizedBox(height: 5),
                // Text(
                //   'Admin Name', // Replace with dynamic admin name if available
                //   style: TextStyle(color: Colors.white, fontSize: 18.sp),
                // ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              widget.vm.selectedIndex = 0;
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text('Schedule'),
            onTap: () {
              widget.vm.selectedIndex = 1;
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Violations'),
            onTap: () {
              widget.vm.selectedIndex = 2;
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text('Achievements'),
            onTap: () {
              widget.vm.selectedIndex = 3;
              Navigator.pop(context); // Close the drawer
            },
          ),
          if (widget.vm.isMore) ...moreList, // More options if expanded
        ],
      ),
    );
  }
}
