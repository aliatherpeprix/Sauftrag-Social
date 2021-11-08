import 'package:flutter/material.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

class MainViewModel extends BaseViewModel{

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  var navigationService = navigationViewModel;
  late SharedPreferences prefs;

  int drinkMotivationValue = 1;
  String drinkMotivationValueStr = "Drink light";
  List<String> drinkMotivationList = ["Drink light", "Drink normal", "Drink hard"];
  Map<String, int> drinkMotivationMap = {
    'Drink light': 1,
    'Drink normal': 2,
    'Drink hard': 3,
  };

  int drinkIndex = -1;
  List<int> drinkIndexList = [];

  List<String> interestList = ["White Wine", "Hard Seltzer", "Whiskey", "Club 1", "Club 2", "Goldstrand"];

  void addRemoveDrink(int index){

    drinkIndex = index + 1;
    //drinkIndexList.length = index + 1;
    notifyListeners();

    //drinkIndex = index + 1;
    //notifyListeners();
  }

  void navigateToProfileScreen(){
    navigationService.navigateToProfileScreen();
  }

  void navigateToMatchScreen(){
    navigationService.navigateToMatchScreen();
  }

  void navigateBack(){
    navigationService.navigateBack();
  }

  /*AnimationController? buttonController;
  Animation<double>? rotate;
  Animation<double>? right;
  Animation<double>? bottom;
  Animation<double>? width;
  double backCardWidth = -10.0;
  int flag = 0;

  List data = [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl1];
  List selectedData = [];

  void initSwipe() {

    rotate = Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Curves.ease,
      ),
    );
    rotate!.addListener(() {
      if (rotate!.isCompleted) {
        var i = data.removeLast();
        data.insert(0, i);
        buttonController!.reset();
      }
      notifyListeners();
    });

    right = Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Curves.ease,
      ),
    );
    bottom = Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Curves.ease,
      ),
    );
    width = Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Curves.bounceOut,
      ),
    );
  }

  Future<Null> swipeAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  dismissImg(String img) {
    data.remove(img);
    notifyListeners();
  }

  addImg(String img) {
    data.remove(img);
    selectedData.add(img);
    notifyListeners();
  }

  swipeRight() {
    if (flag == 0){
      flag = 1;
    }
    notifyListeners();
    swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1){
      flag = 0;
    }
    notifyListeners();
    swipeAnimation();
  }*/

}