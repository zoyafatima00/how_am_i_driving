import 'package:flutter/cupertino.dart';
import 'package:how_am_i_driving/view/tabs/Home/Vehicle/vehicleProfile_screen.dart';

import '../../../../data/base_vm.dart';

class ViewVehicleScreenVm extends BaseVm {
  onViewVehicleProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewVehicleProfileScreen.route);
  }
}
