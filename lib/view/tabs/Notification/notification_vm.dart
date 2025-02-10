import 'package:flutter/cupertino.dart';
import 'package:how_am_i_driving/view/tabs/Notification/notificationProfile_screen.dart';

import '../../../data/base_vm.dart';

class NotificationScreenVm extends BaseVm {
  onNotificationCardClicked(BuildContext context) {
    Navigator.pushNamed(context, NotificationProfileScreen.route);
  }
}
