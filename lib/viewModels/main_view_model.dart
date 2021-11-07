import 'package:flutter/material.dart';
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

  void navigateBack(){
    navigationService.navigateBack();
  }

}