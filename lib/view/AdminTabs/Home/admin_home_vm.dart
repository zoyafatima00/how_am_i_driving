import 'package:flutter/cupertino.dart';

import '../../../data/base_vm.dart';
import '../History/admin_ride_history_screen.dart';
import '../LiveStreaming/live_streaming_screen.dart';

class AdminHomeScreenVm extends BaseVm {
  onRideHistoryClicked(BuildContext context) {
    Navigator.pushNamed(context, AdminRideHistoryScreen.route);
  }

  onLiveStreamingClicked(BuildContext context) {
    Navigator.pushNamed(context, LiveStreamingScreen.route);
  }
}
