
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sauftrag/bar/views/Home/bar_news_feed.dart';

import 'package:sauftrag/utils/screen_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/navigation_view_model.dart';
import 'package:sauftrag/views/Auth/check_email.dart';
import 'package:sauftrag/views/Auth/favorite.dart';
import 'package:sauftrag/views/Auth/forget_password.dart';
import 'package:sauftrag/views/Auth/login.dart';
import 'package:sauftrag/views/Auth/media.dart';
import 'package:sauftrag/views/Auth/resent_password.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/views/Auth/splash.dart';
import 'package:sauftrag/views/Auth/terms.dart';
import 'package:sauftrag/views/Auth/verification_code.dart';
import 'package:sauftrag/views/Home/main_view.dart';
import 'package:sauftrag/views/Home/match.dart';
import 'package:sauftrag/views/Home/profile.dart';
import 'package:sauftrag/views/Home/swipe.dart';
import 'package:sauftrag/views/MapSearch/map_screen.dart';
import 'package:sauftrag/views/MapSearch/search.dart';
import 'package:sauftrag/views/NewsFeed/all_event_list.dart';
import 'package:sauftrag/views/NewsFeed/event_detail.dart';
import 'package:sauftrag/views/NewsFeed/news_feed.dart';
import 'package:sauftrag/views/NewsFeed/upcoming_event_list.dart';
import 'package:sauftrag/views/UserFriendList/chat_input.dart';
import 'package:sauftrag/views/UserFriendList/chat_item_widget.dart';
import 'package:sauftrag/views/UserFriendList/create_group.dart';
import 'package:sauftrag/views/UserFriendList/friend_list.dart';
import 'package:sauftrag/views/UserFriendList/group_details.dart';
import 'package:sauftrag/views/UserFriendList/group_screen.dart';
import 'package:sauftrag/views/UserFriendList/invite_people.dart';
import 'package:sauftrag/views/UserFriendList/message_screen.dart';
import 'package:sauftrag/views/UserFriendList/select_individual_chat.dart';
import 'package:sauftrag/views/UserProfile/account.dart';
import 'package:sauftrag/views/UserProfile/accountOwnership.dart';
import 'package:sauftrag/views/UserProfile/gps.dart';
import 'package:sauftrag/views/UserProfile/legalTerm.dart';
import 'package:sauftrag/views/UserProfile/notifications.dart';
import 'package:sauftrag/views/UserProfile/user_details.dart';
import 'package:sauftrag/views/UserProfile/user_profile.dart';

import 'app/locator.dart';

import 'bar/views/Auth/barTimingType.dart';
import 'bar/views/Auth/media.dart';
import 'bar/views/Auth/signUp.dart';
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
import 'bar/views/Home/bar_drinks.dart';
import 'bar/views/Home/bar_event.dart';
import 'bar/views/Home/main_view.dart';
import 'bar/views/Home/order_details.dart';
import 'bar/views/Profile/bar_account_ownership.dart';
import 'bar/views/Profile/bar_accounts.dart';
import 'bar/views/Profile/bar_details.dart';
import 'bar/views/Profile/bar_profile.dart';
import 'bar/views/Home/barCode2.dart';
import 'bar/widgets/bar_QR_scanner.dart';
import 'bar/widgets/my_side_menu.dart';
import 'views/NewsFeed/events.dart';
import 'widgets/zoom_drawer.dart';

NavigationViewModel navigationViewModel = NavigationViewModel();
void main() async {

 // Get.put<MyDrawerController>(MyDrawerController());
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
            return Splash();
          },
        );
      },
    );
  }
}
