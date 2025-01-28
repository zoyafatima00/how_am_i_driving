import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';
import 'package:how_am_i_driving/view/start/splash_screen.dart';
import 'package:provider/provider.dart';

import 'config/generate_routes.dart';
import 'data/model/app_model.dart';
import 'di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();

  GetIt.I.registerSingleton<AppModel>(AppModel());
  await GetIt.I.allReady();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<AppModel>(),
      child: Consumer<AppModel>(
        builder: (context, model, _) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (ctx, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                  textScaler: const TextScaler.linear(1),
                ),
                child: MaterialApp(
                  theme: ThemeData(
                    useMaterial3: false,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      primary: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                  debugShowCheckedModeBanner: false,
                  initialRoute: SplashScreen.route,
                  onGenerateRoute: (settings) => generateRoute(settings),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
