import 'package:flutter/cupertino.dart';

import '../../../../data/base_vm.dart';
import 'driverProfile_screen.dart';

class ViewDriverScreenVm extends BaseVm {
  onViewDriverProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewDriverProfileScreen.route);
  }
}
