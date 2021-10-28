import 'dart:async';
import 'package:sauftrag/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

class AuthenticationViewModel extends BaseViewModel{

  var navigationService = navigationViewModel;
  late SharedPreferences prefs;

  int role = Constants.user;
  bool signupCheck = false;

  int genderValue = 1;
  String genderValueStr = "Male";
  List<String> genderList = ["Male", "Female"];
  Map<String, int> genderMap = {
    'Male': 1,
    'Female': 2,
  };

  void initializeSplash() async {

    prefs = await SharedPreferences.getInstance();

    Timer(Duration(seconds: 5), ()=> navigateToLoginScreen());

  }

  void selectRole(int role){

    this.role = role;
    notifyListeners();
  }

  void navigateToLoginScreen(){
    navigationService.navigateToLoginScreen();
  }

  void navigateToSignUpScreen(){
    navigationService.navigateToSignUpScreen();
  }
}