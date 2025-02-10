import 'package:flutter/cupertino.dart';
import 'package:how_am_i_driving/view/tabs/History/violationHistory_screen.dart';

import '../../../data/base_vm.dart';

class HistoryScreenVm extends BaseVm {
  onHistoryProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, ViewHistoryProfileScreen.route);
  }
}
