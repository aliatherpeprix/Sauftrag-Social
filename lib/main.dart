import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sauftrag/utils/screen_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/navigation_view_model.dart';
import 'package:sauftrag/views/Auth/splash.dart';
import 'package:sauftrag/views/UserProfile/gps.dart';
import 'app/locator.dart';
import 'bar/views/Drawer/barEvent.dart';
import 'bar/views/Drawer/matched_screen.dart';

NavigationViewModel navigationViewModel = NavigationViewModel();
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // For both Android + iOS
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
  ));
  await configure();
  runApp(MaterialApp(
    navigatorKey: navigationViewModel.navigationKey,
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.getInstance()..init(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return Splash();
          },
        );
      },
    );
  }
}
