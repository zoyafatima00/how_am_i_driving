import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/start/splash_screen.dart';
import '../view/start/splash_vm.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.route:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => SplashVm(context),
              child: const SplashScreen()));

    default:
      return errorRoute();
  }
}

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Arggg!'),
        ),
        body: const Center(
          child: Text('Oh No! You should not be here! '),
        ),
      );
    },
  );
}
