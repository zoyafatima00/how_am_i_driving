import 'package:flutter/material.dart';
import 'package:how_am_i_driving/view/tabs/Home/Driver/viewDriver_vm.dart';
import 'package:how_am_i_driving/view/tabs/Home/Vehicle/addvehicle_screen.dart';
import 'package:how_am_i_driving/view/tabs/Home/Vehicle/addvehicle_vm.dart';
import 'package:how_am_i_driving/view/tabs/Home/Vehicle/viewVehicle_vm.dart';
import 'package:provider/provider.dart';

import '../view/AdminTabs/Achievements/achievement_screen.dart';
import '../view/AdminTabs/Achievements/achievemnt_vm.dart';
import '../view/AdminTabs/Home/admin_home_screen.dart';
import '../view/AdminTabs/Home/admin_home_vm.dart';
import '../view/AdminTabs/Schedule/admin_schedule.dart';
import '../view/AdminTabs/Schedule/admin_schedule_vm.dart';
import '../view/AdminTabs/Violations/admin_viloation_screen.dart';
import '../view/AdminTabs/Violations/admin_violation_vm.dart';
import '../view/auth/forgot_password/forgotPassword_screen.dart';
import '../view/auth/forgot_password/forgotPassword_vm.dart';
import '../view/auth/login/admin_login_screen.dart';
import '../view/auth/login/admin_login_vm.dart';
import '../view/auth/login/login_screen.dart';
import '../view/auth/login/login_vm.dart';
import '../view/auth/reset_password/ResetPassword_vm.dart';
import '../view/auth/reset_password/resetPassword_screen.dart';
import '../view/auth/signup/signup_screen.dart';
import '../view/auth/signup/signup_screen2.dart';
import '../view/auth/signup/signup_two_vm.dart';
import '../view/auth/signup/signup_vm.dart';
import '../view/bottom_nav/admin_bottom_nav.dart';
import '../view/bottom_nav/admin_bottom_nav_vm.dart';
import '../view/bottom_nav/bottom_nav_screen.dart';
import '../view/bottom_nav/bottom_vm.dart';
import '../view/start/splash_screen.dart';
import '../view/start/splash_vm.dart';
import '../view/tabs/History/history_screen.dart';
import '../view/tabs/History/history_vm.dart';
import '../view/tabs/History/violationHistory_screen.dart';
import '../view/tabs/History/violationHistory_vm.dart';
import '../view/tabs/Home/Driver/adddriver_screen.dart';
import '../view/tabs/Home/Driver/adddriver_vm.dart';
import '../view/tabs/Home/Driver/driverProfile_screen.dart';
import '../view/tabs/Home/Driver/driverProfile_vm.dart';
import '../view/tabs/Home/Driver/viewDriver_screen.dart';
import '../view/tabs/Home/Vehicle/vehicleProfile_screen.dart';
import '../view/tabs/Home/Vehicle/vehicleProfile_vm.dart';
import '../view/tabs/Home/Vehicle/vewVehicle_screen.dart';
import '../view/tabs/Home/home_screen.dart';
import '../view/tabs/Home/home_vm.dart';
import '../view/tabs/Notification/notificationProfile_screen.dart';
import '../view/tabs/Notification/notificationProfile_vm.dart';
import '../view/tabs/Notification/notification_screen.dart';
import '../view/tabs/Notification/notification_vm.dart';
import '../view/tabs/Schedule/addSchedule_screen.dart';
import '../view/tabs/Schedule/addSchedule_vm.dart';
import '../view/tabs/Schedule/scheduleProfile_screen.dart';
import '../view/tabs/Schedule/scheduleProfile_vm.dart';
import '../view/tabs/Schedule/schedule_screen.dart';
import '../view/tabs/Schedule/schedule_vm.dart';
import '../view/tabs/Schedule/viewSchedule_screen.dart';
import '../view/tabs/Schedule/viewSchedule_vm.dart';
import '../view/tabs/TrackRide/TrackRideProfile_screen.dart';
import '../view/tabs/TrackRide/TrackRideProfile_vm.dart';
import '../view/tabs/TrackRide/trackRide_screen.dart';
import '../view/tabs/TrackRide/trackRide_vm.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => SplashVm(), child: const SplashScreen()));

    case LoginScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => LoginVm(), child: const LoginScreen()));

    case AdminLoginScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AdminLoginVm(), child: const AdminLoginScreen()));

    case ForgotPasswordScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => ForgotPasswordVm(),
              child: const ForgotPasswordScreen()));

    case SignUpScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => SignUpVm(), child: const SignUpScreen()));

    case SignUpTwoScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => SignUpTwoVm(),
              child: const SignUpTwoScreen()));

    case ResetPasswordScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => ResetPasswordVm(context),
              child: const ResetPasswordScreen()));
    case BottomNavScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => BottomNavVm(),
              child: const BottomNavScreen()));
    case AdminBottomNavScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AdminBottomNavVm(),
              child: const AdminBottomNavScreen()));

    case HomeScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => HomeScreenVm(), child: const HomeScreen()));

    case AdminHomeScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AdminHomeScreenVm(), child: const AdminHomeScreen()));

    case  AdminScheduleScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) =>  AdminScheduleVm(), child: const  AdminScheduleScreen()));

    case AdminViolationScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AdminViolationVm(), child: const AdminViolationScreen()));

    case AchievementScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AchievementVm(), child: const AchievementScreen()));

    case ViewDriverScreen.route:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) =>
              ViewDriverScreenVm(), // Provide ViewDriverScreenVm here
          child: const ViewDriverScreen(),
        ),
      );

    case AddDriverScreen.route:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) =>
              AddDriverScreenVm(), // Provide ViewDriverScreenVm here
          child: const AddDriverScreen(),
        ),
      );

    case ViewDriverProfileScreen.route:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) =>
              ViewDriverProfileVm(), // Provide ViewDriverScreenVm here
          child: const ViewDriverProfileScreen(),
        ),
      );

    case ViewVehicleScreen.route:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) =>
              ViewVehicleScreenVm(), // Provide ViewDriverScreenVm here
          child: const ViewVehicleScreen(),
        ),
      );

    case AddVehicleScreen.route:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) =>
              AddVehicleScreenVm(), // Provide ViewDriverScreenVm here
          child: const AddVehicleScreen(),
        ),
      );

    case ViewVehicleProfileScreen.route:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) =>
              ViewVehicleProfileScreenVm(), // Provide ViewDriverScreenVm here
          child: const ViewVehicleProfileScreen(),
        ),
      );

    case ScheduleScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => ScheduleScreenVm(),
              child: const ScheduleScreen()));

    case ViewScheduleProfileScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => ViewScheduleProfileScreenVm(),
              child: ViewScheduleProfileScreen()));

    case AddScheduleScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AddScheduleScreenVm(),
              child: const AddScheduleScreen()));

    case ViewScheduleScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => ViewScheduleScreenVm(),
              child: const ViewScheduleScreen()));

    case TrackRideScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => TrackRideScreenVm(),
              child: const TrackRideScreen()));

    case TrackRideProfileScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => TrackRideProfileVm(),
              child: TrackRideProfileScreen()));

    case HistoryScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => HistoryScreenVm(),
              child: const HistoryScreen()));

    case ViewHistoryProfileScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => ViewHistoryProfileVm(),
              child: ViewHistoryProfileScreen()));

    case NotificationScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => NotificationScreenVm(),
              child: const NotificationScreen()));

    case NotificationProfileScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => NotificationProfileVm(),
              child: NotificationProfileScreen()));

    default:
      return errorRoute();
  }
}

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Arggg!'),
        ),
        body: const Center(
          child: Text('Oh No! You should not be here! '),
        ),
      );
    },
  );
}
