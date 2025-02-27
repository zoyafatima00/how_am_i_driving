import 'package:flutter/cupertino.dart';

import '../../../data/base_vm.dart';
import 'admin_voilation_profile.dart';

class AdminViolationVm extends BaseVm {
  onHistoryProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, AdminViolationProfileScreen.route);
  }
}
