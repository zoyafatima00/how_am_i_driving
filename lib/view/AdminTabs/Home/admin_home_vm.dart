import 'package:flutter/cupertino.dart';
import 'package:how_am_i_driving/view/AdminTabs/Violations/admin_viloation_screen.dart';

import '../../../data/base_vm.dart';
import '../History/admin_ride_history_screen.dart';
import '../LiveStreaming/live_streaming_screen.dart';
import '../Schedule/admin_schedule.dart';

class AdminHomeScreenVm extends BaseVm {
  onRideHistoryClicked(BuildContext context) {
    Navigator.pushNamed(context, AdminRideHistoryScreen.route);
  }

  onLiveStreamingClicked(BuildContext context) {
    Navigator.pushNamed(context, LiveStreamingScreen.route);
  }

  onRideScheduledClicked(BuildContext context) {
    Navigator.pushNamed(context, AdminScheduleScreen.route);
  }

  onViolationRecordClicked(BuildContext context) {
    Navigator.pushNamed(context, AdminViolationScreen.route);
  }

  // onTrackRideClicked(BuildContext context) {
  //   Navigator.pushNamed(
  //       context, TrackRideProfileScreen(rideDetails: rideDetails));
  // }
}
