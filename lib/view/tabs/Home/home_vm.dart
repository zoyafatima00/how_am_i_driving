import 'package:flutter/material.dart';
import 'package:how_am_i_driving/view/tabs/Home/Driver/viewDriver_screen.dart';

import '../../../data/base_vm.dart';
import '../Schedule/addSchedule_screen.dart';
import '../Schedule/viewSchedule_screen.dart';
import 'Driver/adddriver_screen.dart';
import 'Vehicle/addvehicle_screen.dart';
import 'Vehicle/vewVehicle_screen.dart';

class HomeScreenVm extends BaseVm {
  onViewDriverClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewDriverScreen.route);
  }

  onViewVehicleClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewVehicleScreen.route);
  }

  onViewScheduleClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewScheduleScreen.route);
  }

  onAddDriverClicked(BuildContext context) {
    Navigator.pushNamed(context, AddDriverScreen.route);
  }

  onAddVehicleClicked(BuildContext context) {
    Navigator.pushNamed(context, AddVehicleScreen.route);
  }

  onAddScheduleClicked(BuildContext context) {
    Navigator.pushNamed(context, AddScheduleScreen.route);
  }
}
