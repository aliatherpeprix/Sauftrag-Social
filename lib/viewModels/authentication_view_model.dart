import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

class AuthenticationViewModel extends BaseViewModel {
  var navigationService = navigationViewModel;
  late SharedPreferences prefs;

  int role = Constants.user;
  bool signupCheck = false;
  bool termsCheck = false;
  bool dataCheck = false;

  bool logInUserSelected = true;
  bool logInBarSelected = false;
  final logInUserController = TextEditingController();
  final logInPasswordController = TextEditingController();
  bool signUpUserSelected = true;
  bool signUpBarSelected = false;

  final signUpUserController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpVerifyPasswordController = TextEditingController();
  final signUpAddressController = TextEditingController();
  final signUpDOBController = TextEditingController();
  final signUpRelationshipController = TextEditingController();
  bool isChecked = false;

  final signUpBarUserController = TextEditingController();
  final signUpBarAddressController = TextEditingController();
  final signUpBarPasswordController = TextEditingController();
  final signUpBarVerifyPasswordController = TextEditingController();

  bool loginPasswordVisible = false;


  File imageFile = File('my initial file');
  List<File> imageFiles = [
    File(""),
    File(""),
    File(""),
    File(""),
    File(""),
    File("")
  ];

  int genderValue = 1;
  String genderValueStr = "Male";
  List<String> genderList = ["Male", "Female"];
  Map<String, int> genderMap = {
    'Male': 1,
    'Female': 2,
  };

  List<String> clubList = [
    "Club 1",
    "Club 2",
    "Club 3",
    "Club 4",
    "Club 5",
    "Club 6",
    "Club 7",
    "Club 8",
    "Club 9",
    "Club 10"
  ];
  List<int> selectedClubList = [];

  List<String> vacationList = [
    "Ballermann",
    "Goldstrand",
    "Zrce Beach",
    "Lloret",
    "Ibiza",
    "Springbreak Cancun"
  ];

  List<int> selectedWeekDays = [];

  List<String> weekDaysList = ["Su" , "Mo" , "Tu", "We" , "Th", "Fr" , "Sa"];

  List<int> selectedBarKind = [];

  List<String> barKindList = ["Disco" , "Cocktail" , "Pub", "Hotel Bar" , "Beer Hall"];

  List<int> selectedVacationList = [];

  List<String> drinkList = [
    "Beer",
    "White Wine",
    "Radler",
    "Red Wine",
    "Gin",
    "Whiskey",
    "Hard Seltzer",
    "Jägermeister",
    "Tequila",
    "Champagne"
  ];
  List<int> selectedDrinkList = [];

  void initializeSplash() async {
    prefs = await SharedPreferences.getInstance();

    Timer(Duration(seconds: 5), () => navigateToLoginScreen());
  }

  void selectRole(int role) {
    this.role = role;
    notifyListeners();
  }

  Future<bool> getImage(int index) async {
    ImagePicker picker = ImagePicker();
    //List<XFile>? images = await picker.pickMultiImage();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //imageFile = File(image!.path);

    if (image == null) {
      return false;
    } else {
      imageFiles.insert(index, File(image.path));
      /*for(XFile image in images){
        imageFiles.add(File(image.path));
      }*/
      notifyListeners();
      return true;
    }

    /*if (imageFile == null) {
      return false;
    }
    else{
      notifyListeners();
      return true;
    }*/
  }

  createUserAccount(){
    if (signUpUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Name is required",
      ));
      return;
    } else if (signUpEmailController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Email is required",
      ));
      return;
    }else if (signUpPhoneController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Phone Number is required",
      ));
      return;
    }else if (signUpPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }else if (signUpVerifyPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Verify Password is required",
      ));
      return;
    }else if (signUpAddressController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Address is required",
      ));
      return;
    }else if (signUpDOBController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Date Of Birth is required",
      ));
      return;
    }else if (signUpRelationshipController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "RelationShip is required",
      ));
      return;
    }else if (isChecked == false) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please Accept Terms and Conditions",
      ));
      return;
    }
    else{
      navigateToFavoriteScreen();
    }
  }

  createBarAccount(){
    if (signUpBarUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Name is required",
      ));
      return;
    } else if (signUpBarAddressController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Address is required",
      ));
      return;
    }else if (signUpBarPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }else if (signUpBarVerifyPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Verify Password is required",
      ));
      return;
    }
    else{
      navigateToUploadBarMedia();
    }
  }

  onLogIn(){
    if (logInUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Name is required",
      ));
      return;
    } else if (logInPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }
    else{
      if(logInUserSelected == true){
        navigateToHomeScreen(2);
      }
      else if(logInBarSelected == true){
        navigateToBarNewsFeed();
      }
    }
  }

  void navigateToSignUpBar(){
    navigationService.navigateToBarSignUpScreen();
  }

  void navigateToBarNewsFeed() {
    navigationService.navigateToBarHomeScreen();
  }

  void navigateToLoginScreen() {
    navigationService.navigateToLoginScreen();
  }

  void navigateToSignUpScreen() {
    navigationService.navigateToSignUpScreen();
  }

  void navigatorToBarSignIn() {
    navigationService.navigateToUploadBarMedia();
  }

    void navigateToUploadBarMedia() {
      navigationService.navigateToUploadBarMedia();
    }

  void navigateToFavoriteScreen() {
    navigationService.navigateToFavoriteScreen();
  }

  void navigateToBarProfileScreen() {
    navigationService.navigateToBarProfileScreen();
  }

  void navigateToMediaScreen() {
    navigationService.navigateToMediaScreen();
  }

  void navigateToTermsScreen() {
    navigationService.navigateToTermsScreen();
  }

  void navigateToCreateEventScreen() {
    navigationService.navigateToCreateEventScreen();
  }

  void navigateToHomeScreen(int index) {
    navigationService.navigateToHomeScreen(index);
  }

  void navigateToForgetPasswordScreen() {
    navigationService.navigateToForgetPasswordScreen();
  }

  void navigateToCheckEmailScreen() {
    navigationService.navigateToCheckEmailScreen();
  }

  void navigateToResentPasswordScreen() {
    navigationService.navigateToResentPasswordScreen();
  }



  void navigateBack() {
    navigationService.navigateBack();
  }
}
