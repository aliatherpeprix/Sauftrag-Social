
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/bar/views/Auth/media.dart';
import 'package:sauftrag/bar/views/Auth/signUp.dart';
import 'package:sauftrag/bar/views/Drawer/barEvent.dart';
import 'package:sauftrag/bar/views/Drawer/followers.dart';
import 'package:sauftrag/bar/views/Drawer/notifications.dart';
import 'package:sauftrag/bar/views/Home/bar_news_feed.dart';
import 'package:sauftrag/bar/views/Profile/bar_profile.dart';
import 'package:sauftrag/bar/views/Home/bar_event.dart';
import 'package:sauftrag/views/Auth/check_email.dart';
import 'package:sauftrag/views/Auth/favorite.dart';
import 'package:sauftrag/views/Auth/forget_password.dart';
import 'package:sauftrag/views/Auth/login.dart';
import 'package:sauftrag/views/Auth/media.dart';
import 'package:sauftrag/views/Auth/resent_password.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/views/Auth/terms.dart';
import 'package:sauftrag/views/Home/main_view.dart';
import 'package:sauftrag/views/Home/match.dart';
import 'package:sauftrag/views/Home/profile.dart';
import 'package:sauftrag/views/MapSearch/map_screen.dart';
import 'package:sauftrag/views/UserFriendList/group_details.dart';
import 'package:sauftrag/views/UserFriendList/group_screen.dart';
import 'package:sauftrag/widgets/bar_auth_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NavigationViewModel extends BaseViewModel{

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  void navigateToLoginScreen(){
    navigationKey.currentState!.pushReplacement(PageTransition(child: Login(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToSignUpScreen(){
    navigationKey.currentState!.push(PageTransition(child: SignUp(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarSignUpScreen(){
    navigationKey.currentState!.push(PageTransition(child: SignUpBar(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToUploadBarMedia(){
    navigationKey.currentState!.push(PageTransition(child: BarMedia(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToFavoriteScreen(){
    navigationKey.currentState!.push(PageTransition(child: Favorite(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarProfileScreen(){
    navigationKey.currentState!.push(PageTransition(child: BarProfile(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToMediaScreen(){
    navigationKey.currentState!.push(PageTransition(child: Media(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToTermsScreen(){
    navigationKey.currentState!.push(PageTransition(child: TermsOfService(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToCreateEventScreen(){
    navigationKey.currentState!.push(PageTransition(child: CreateBarEvent(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarEventScreen(){
    navigationKey.currentState!.push(PageTransition(child: BarEvent(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToNotificationScreen(){
    navigationKey.currentState!.push(PageTransition(child: Notifications(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToFollowersListScreen(){
    navigationKey.currentState!.push(PageTransition(child: Followers(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToForgetPasswordScreen(){
    navigationKey.currentState!.push(PageTransition(child: ForgetPassword(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToCheckEmailScreen(){
    navigationKey.currentState!.push(PageTransition(child: CheckEmail(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToResentPasswordScreen(){
    navigationKey.currentState!.push(PageTransition(child: ResentPassword(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarHomeScreen(){
    navigationKey.currentState!.push(PageTransition(child: BarNewsFeed(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToHomeScreen(int index){
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: MainView(index: index), type: PageTransitionType.rightToLeftWithFade),(Route<dynamic> route) => false);
  }

  void navigateToMapScreen(int index){
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: MainView(index: 3), type: PageTransitionType.rightToLeftWithFade),(Route<dynamic> route) => false);
  }

  void navigateToProfileScreen(List<String> images){
    navigationKey.currentState!.push(PageTransition(child: Profile(images: images), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToMatchScreen(){
    navigationKey.currentState!.push(PageTransition(child: Match(), type: PageTransitionType.rightToLeftWithFade));
  }



  void navigateBack(){
    navigationKey.currentState!.pop();
  }

  void navigateToGroupDetail(){
    navigationKey.currentState!.push(PageTransition(child: GroupDetails(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToGroupScreen(){
    navigationKey.currentState!.push(PageTransition(child: GroupScreen(), type: PageTransitionType.rightToLeftWithFade));
  }



  /*void navigateToWelcomeScreen(){
    navigationKey.currentState!.pushReplacement(PageTransition(child: Welcome(), type: PageTransitionType.fade));
  }

  void navigateToHomeScreen(int index){
    //navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: Home(), type: PageTransitionType.fade),(Route<dynamic> route) => false);
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: MainView(index: index), type: PageTransitionType.fade),(Route<dynamic> route) => false);
  }

  void navigateToRegisterScreen(int from){
    navigationKey.currentState!.push(PageTransition(child: Register(from: from), type: PageTransitionType.fade));
  }

  void navigateBack(){
    navigationKey.currentState!.pop(PageTransition(child: UserDetails(), type: PageTransitionType.fade));
  }*/
}