import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_am_i_driving/view/tabs/Notification/notification_screen.dart';
import 'package:provider/provider.dart';

import '../../data/base_vm.dart';
import '../start/login_splash.dart';
import '../tabs/History/history_screen.dart';
import '../tabs/History/history_vm.dart';
import '../tabs/Home/home_screen.dart';
import '../tabs/Home/home_vm.dart';
import '../tabs/Schedule/schedule_screen.dart';
import '../tabs/Schedule/schedule_vm.dart';
import '../tabs/TrackRide/trackRide_screen.dart';
import '../tabs/TrackRide/trackRide_vm.dart';

class BottomNavVm extends BaseVm {
  late final BuildContext context;
  late final int? index;
  BottomNavVm();
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
        create: (context) => HomeScreenVm(), child: const HomeScreen()),
    ChangeNotifierProvider(
        create: (context) => ScheduleScreenVm(), child: const ScheduleScreen()),
    ChangeNotifierProvider(
        create: (context) => TrackRideScreenVm(),
        child: const TrackRideScreen()),
    ChangeNotifierProvider(
        create: (context) => HistoryScreenVm(), child: const HistoryScreen()),
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

  // List<String> monthlyOffers = [
  //   'Create an unlimited number of hypnosis meditation audios',
  //   'Use 100’s of expert written, pre-recorded self-help suggestions',
  //   'Select suggestions from over a dozen common areas of need and improvement',
  //   'Multiple pre-recorded relaxation inductions to choose from',
  //   'Calming background music options',
  //   'New content added every month',
  //   'Cancel at any time',
  // ];
  List<String> moreList = [
    'How To Use This App',
    'About Hypnosis Meditation',
    'More Tools For Change',
    'About Dawn Grant',
  ];

  onLogOutClicked(BuildContext context) {
    Navigator.pushNamed(context, LoginOptionScreen.route);
  }
}
