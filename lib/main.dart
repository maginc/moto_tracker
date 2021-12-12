import 'dart:async';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mototracker/constants.dart' as Constants;
import 'package:mototracker/routes/details/widgets/map_full_screen.dart';
import 'package:mototracker/routes/settings/settings_page.dart';
import 'package:mototracker/routes/triphistory/trip_list_page.dart';
import 'package:mototracker/util/permissions.dart';

import 'location_tracker/location_tracker_bloc/location_tracker_bloc.dart';
import 'routes/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
  Init.initPlatformState();
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/trip_list_page': (context) => TripListPage(),
        '/settings_page': (context) => SettingsPage(),
        '/map_full_screen': (context) => MapFullScreen()
      },
      theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          brightness: Brightness.light,
          primaryColor: Constants.BACKGROUD_COLOR),
      home: BlocProvider(
        create: (context) => LocationTrackerBloc(),
        child: HomePage(),
        //  child: TripListPage(),
      ),
    );
  }
}
class Init {
  static Future<void> initPlatformState() async {
    await Permissions.checkLocationPermission().then((value) {
      bool permisionsGranted = value == true ? true : false;
      print("Location permissions granted: " + permisionsGranted.toString());
    });
    print('Initializing...');
    await BackgroundLocator.initialize();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isRegisterLocationUpdate();

    print('Running ${_isRunning.toString()}');
  }
}
