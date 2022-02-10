import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pubnub/pubnub.dart';
import 'package:sauftrag/bar/views/Home/bar_news_feed.dart';

import 'package:sauftrag/utils/screen_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/navigation_view_model.dart';
import 'package:sauftrag/views/Auth/splash.dart';
import 'package:sauftrag/views/UserProfile/gps.dart';
import 'app/locator.dart';
import 'bar/views/Drawer/barEvent.dart';
import 'bar/views/Drawer/barProfile.dart';
import 'bar/views/Drawer/bar_Rating.dart';
import 'bar/views/Drawer/bar_all_rating.dart';
import 'bar/views/Drawer/follower_profile.dart';
import 'bar/views/Drawer/followers.dart';
import 'bar/views/Drawer/list_of_bar.dart';
import 'bar/views/Drawer/matched_screen.dart';
import 'bar/views/Drawer/notifications.dart';
import 'bar/views/Drawer/qr_code_scanner.dart';
import 'bar/views/Drawer/ranking_list.dart';
import 'bar/views/Drawer/upcoming_event.dart';
import 'bar/views/Home/bar_create_post.dart';
import 'bar/views/Home/bar_drinks.dart';
import 'bar/views/Home/bar_event.dart';
import 'bar/views/Home/main_view.dart';
import 'bar/views/Home/order_details.dart';
import 'bar/views/Profile/bar_account_ownership.dart';
import 'bar/views/Profile/bar_accounts.dart';
import 'bar/views/Profile/bar_details.dart';
import 'bar/views/Profile/bar_profile.dart';
import 'bar/views/Home/barCode2.dart';
import 'bar/views/Profile/faq_questions_list.dart';
import 'bar/widgets/bar_QR_scanner.dart';
import 'bar/widgets/my_side_menu.dart';
import 'views/NewsFeed/events.dart';
import 'widgets/zoom_drawer.dart';

NavigationViewModel navigationViewModel = NavigationViewModel();
void main() async {
  

  // Get.put<MyDrawerController>(MyDrawerController());
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
            return Splash();
          },
        );
      },
    );
  }
}
//BarEvent
//CreateBarEvent()