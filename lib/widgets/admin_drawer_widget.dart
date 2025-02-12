import 'package:flutter/material.dart';

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
    // var moreList = [
    //   if (widget.vm.isMore)
    //     for (int i = 0; i < widget.vm.moreList.length; i++)
    //       Row(
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.only(
    //               bottom: 10.h,
    //               top: 2.h,
    //               left: 60.w,
    //             ),
    //             child: InkWell(
    //               onTap: () {},
    //               child: Text(
    //                 widget.vm.moreList[i],
    //                 style: GoogleFonts.nunito(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 12.sp,
    //                     color: Colors.white,
    //                     height: 1.5.h),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    // ];
    return const Drawer();
  }
}
