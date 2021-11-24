import 'package:flutter/material.dart';
import 'package:sauftrag/utils/screen_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/navigation_view_model.dart';
import 'package:sauftrag/views/Auth/login.dart';

import 'package:sauftrag/views/Auth/media.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/views/Home/main_view.dart';
import 'package:sauftrag/views/Home/match.dart';
import 'package:sauftrag/views/Home/profile.dart';
import 'package:sauftrag/views/Home/swipe.dart';
import 'package:sauftrag/views/MapSearch/search.dart';
import 'package:sauftrag/views/UserFriendList/create_group.dart';
import 'package:sauftrag/views/UserFriendList/group_details.dart';

import 'app/locator.dart';

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
            return GroupDetails();
          },
        );
      },
    );
  }
}
