
import 'package:flutter/material.dart';
import 'package:sauftrag/bar/views/Home/bar_news_feed.dart';

import 'package:sauftrag/utils/screen_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/navigation_view_model.dart';
import 'package:sauftrag/views/Auth/check_email.dart';
import 'package:sauftrag/views/Auth/forget_password.dart';
import 'package:sauftrag/views/Auth/login.dart';

import 'package:sauftrag/views/Auth/media.dart';
import 'package:sauftrag/views/Auth/resent_password.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/views/Auth/splash.dart';
import 'package:sauftrag/views/Home/main_view.dart';
import 'package:sauftrag/views/Home/match.dart';
import 'package:sauftrag/views/Home/profile.dart';
import 'package:sauftrag/views/Home/swipe.dart';

import 'app/locator.dart';
import 'bar/views/Auth/signUp.dart';
import 'bar/views/Drawer/barEvent.dart';
import 'bar/views/Drawer/followers.dart';
import 'bar/views/Drawer/notifications.dart';
import 'bar/views/Home/bar_drinks.dart';
import 'bar/views/Home/main_view.dart';
import 'bar/views/Home/order_details.dart';
import 'bar/views/Profile/bar_profile.dart';
import 'bar/views/Home/barCode2.dart';
import 'bar/widgets/bar_QR_scanner.dart';

NavigationViewModel navigationViewModel = NavigationViewModel();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //var userId = prefs.getInt("user_id");
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
    //ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.getInstance()..init(context);
    /*ScreenUtil.instance = ScreenUtil(
        width: MediaQuery.of(context).size.width.round(),
        height: MediaQuery.of(context).size.height.round(),
        allowFontScaling: true);*/
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            //var prefService = locator<PrefrencesViewModel>();
            //return MainView(index: 2);
            return BarNewsFeed();
          },
        );
      },
    );
  }
}
