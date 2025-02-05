import 'package:flutter/cupertino.dart';
import 'package:how_am_i_driving/view/tabs/Schedule/scheduleProfile_screen.dart';

import '../../../../data/base_vm.dart';

class ViewScheduleScreenVm extends BaseVm {
  onViewScheduleProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewcheduleProfileScreen.route);
  }
}
