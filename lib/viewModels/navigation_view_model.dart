
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/bar/Auth/media.dart';
import 'package:sauftrag/bar/Auth/signUp.dart';
import 'package:sauftrag/views/Auth/favorite.dart';
import 'package:sauftrag/views/Auth/login.dart';
import 'package:sauftrag/views/Auth/media.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/views/Auth/terms.dart';
import 'package:sauftrag/views/Home/main_view.dart';
import 'package:sauftrag/views/Home/match.dart';
import 'package:sauftrag/views/Home/profile.dart';
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

  void navigateToMediaScreen(){
    navigationKey.currentState!.push(PageTransition(child: Media(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToTermsScreen(){
    navigationKey.currentState!.push(PageTransition(child: TermsOfService(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToHomeScreen(int index){
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: MainView(index: index), type: PageTransitionType.rightToLeftWithFade),(Route<dynamic> route) => false);
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