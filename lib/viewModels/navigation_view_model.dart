
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/views/Auth/login.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:stacked/stacked.dart';

class NavigationViewModel extends BaseViewModel{

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  void navigateToLoginScreen(){
    navigationKey.currentState!.pushReplacement(PageTransition(child: Login(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToSignUpScreen(){
    navigationKey.currentState!.push(PageTransition(child: SignUp(), type: PageTransitionType.rightToLeftWithFade));
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