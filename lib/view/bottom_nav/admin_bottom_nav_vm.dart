import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_am_i_driving/view/AdminTabs/Home/admin_home_vm.dart';
import 'package:how_am_i_driving/view/tabs/Notification/notification_screen.dart';
import 'package:provider/provider.dart';

import '../../data/base_vm.dart';
import '../AdminTabs/Achievements/achievement_screen.dart';
import '../AdminTabs/Achievements/achievemnt_vm.dart';
import '../AdminTabs/Home/admin_home_screen.dart';
import '../AdminTabs/Schedule/admin_schedule.dart';
import '../AdminTabs/Schedule/admin_schedule_vm.dart';
import '../AdminTabs/Violations/admin_viloation_screen.dart';
import '../AdminTabs/Violations/admin_violation_vm.dart';
import '../tabs/History/history_screen.dart';
import '../tabs/History/history_vm.dart';
import '../tabs/TrackRide/trackRide_screen.dart';
import '../tabs/TrackRide/trackRide_vm.dart';

class AdminBottomNavVm extends BaseVm {
  late final BuildContext context;
  late final int? index;
  AdminBottomNavVm();
  int _selectedIndex = 0;
  set selectedIndex(int value) {
    if (value >= 0 && value < _pages.length) {
      // Prevents invalid index selection
      _selectedIndex = value;
      notifyListeners();
    }
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isMore = false;

  bool get isMore => _isMore;

  set isMore(bool value) {
    _isMore = value;
  }

  void toggleExpansion(bool expanded) {
    _isMore = expanded;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex; // List of screens

  List<Widget> _pages = [
    ChangeNotifierProvider(
        create: (context) => AdminHomeScreenVm(),
        child: const AdminHomeScreen()),
    ChangeNotifierProvider(
        create: (context) => AdminScheduleVm(),
        child: const AdminScheduleScreen()),
    ChangeNotifierProvider(
        create: (context) => AdminViolationVm(),
        child: const AdminViolationScreen()),
    ChangeNotifierProvider(
        create: (context) => AchievementVm(), child: const AchievementScreen()),
  ];

  List<Widget> get pages => _pages;
  set pages(List<Widget> p) {
    _pages = p;
    print(p.length);
    notifyListeners();
  }

  onNotifcationClicked(BuildContext context) {
    Navigator.pushNamed(context, NotificationScreen.route);
  }
}
