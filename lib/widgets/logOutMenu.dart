import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutMenu extends StatelessWidget {
  final VoidCallback onLogout;
  final Widget child;

  const LogoutMenu({
    super.key,
    required this.onLogout,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40), // Adjust position as needed
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 20.w),
              SizedBox(width: 10.w),
              Text('Logout', style: TextStyle(fontSize: 14.sp)),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'logout') {
          onLogout();
        }
      },
      child: child, // Your person icon goes here
    );
  }
}
