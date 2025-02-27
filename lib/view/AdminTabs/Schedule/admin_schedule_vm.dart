import 'package:flutter/cupertino.dart';

import '../../../data/base_vm.dart';
import 'admin_schedule_profile_screen.dart';

class AdminScheduleVm extends BaseVm {
  onViewScheduleProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, AdminScheduleProfileScreen.route);
  }
}
