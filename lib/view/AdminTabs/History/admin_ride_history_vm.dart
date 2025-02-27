import 'package:flutter/cupertino.dart';

import '../../../data/base_vm.dart';
import 'admin_history_profile_screen.dart';

class AdminRideHistoryVm extends BaseVm {
  onHistoryCardClicked(BuildContext context) {
    Navigator.pushNamed(context, AdminHistoryProfileScreen.route);
  }
}
