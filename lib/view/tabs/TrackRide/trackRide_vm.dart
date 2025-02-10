import 'package:flutter/cupertino.dart';
import 'package:how_am_i_driving/view/tabs/TrackRide/TrackRideProfile_screen.dart';

import '../../../data/base_vm.dart';

class TrackRideScreenVm extends BaseVm {
  onTrackRideProfileClicked(BuildContext context) {
    Navigator.pushNamed(context, TrackRideProfileScreen.route);
  }
}
