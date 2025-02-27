import 'package:flutter/cupertino.dart';

import '../../../data/base_vm.dart';
import '../History/admin_ride_history_screen.dart';

class AdminHomeScreenVm extends BaseVm {
  onRideHistoryClicked(BuildContext context) {
    Navigator.pushNamed(context, AdminRideHistoryScreen.route);
  }
}
