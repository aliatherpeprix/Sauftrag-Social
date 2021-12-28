import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import '../main.dart';
import 'main_view_model.dart';

class AuthenticationViewModel extends BaseViewModel {
  var navigationService = navigationViewModel;
  late SharedPreferences prefs;

  int role = Constants.user;
  bool signupCheck = false;

  bool isChecked1 = false;
  bool termsCheck = false;
  bool dataCheck = false;

  bool otpLoading = false;

  bool isChecked = false;
  bool signupPasswordVisible = false;
  bool signupVerifyPasswordVisible = false;

  bool resetNewPasswordVisible = false;
  bool resetConfirmPasswordVisible = false;

  bool logInUserSelected = true;
  bool logInBarSelected = false;

  FocusNode logInUserFocus = new FocusNode();
  bool isLogInUserInFocus = false;
  final logInUserController = TextEditingController();

  final codeController = TextEditingController();

  final logInPasswordController = TextEditingController();
  bool isLoginPasswordInFocus = false;
  FocusNode loginPasswordFocus = new FocusNode();

  final forgetPasswordController = TextEditingController();
  bool isForgetPasswordInFocus = false;
  FocusNode forgetPasswordFocus = new FocusNode();

  final newPasswordController = TextEditingController();
  bool isNewPasswordInFocus = false;
  FocusNode newPasswordFocus = new FocusNode();

  final confirmNewPasswordController = TextEditingController();
  bool isConfirmNewPasswordInFocus = false;
  FocusNode confirmNewPasswordFocus = new FocusNode();

  final resetNewPasswordController = TextEditingController();
  bool isResetNewPasswordInFocus = false;
  FocusNode resetNewPasswordFocus = new FocusNode();

  final resetConfirmPasswordController = TextEditingController();
  bool isResetConfirmPasswordInFocus = false;
  FocusNode resetConfirmPasswordFocus = new FocusNode();

  bool signUpUserSelected = true;
  bool signUpBarSelected = false;

  final myContactsSearchController = TextEditingController();

  ///-----Bar Options -------------------///
  final aboutMeController = TextEditingController();
  final barNameController = TextEditingController();

  final signUpUserController = TextEditingController();
  bool isSignUpUserInFocus = false;
  FocusNode signUpUserFocus = new FocusNode();

  final signUpEmailController = TextEditingController();
  bool isSignUpEmailInFocus = false;
  FocusNode signUpEmailFocus = new FocusNode();

  final signUpConfirmEmailController = TextEditingController();
  bool isSignUpConfirmEmailInFocus = false;
  FocusNode signUpConfirmEmailFocus = new FocusNode();

  final signUpPhoneController = TextEditingController();
  bool isSignUpPhoneInFocus = false;
  FocusNode signUpPhoneFocus = new FocusNode();

  final signUpPasswordController = TextEditingController();
  bool isSignUpPasswordInFocus = false;
  FocusNode signUpPasswordFocus = new FocusNode();

  final signUpVerifyPasswordController = TextEditingController();
  bool isSignUpVerifyPasswordInFocus = false;
  FocusNode signUpVerifyPasswordFocus = new FocusNode();

  final signUpAddressController = TextEditingController();
  bool isSignUpAddressInFocus = false;
  FocusNode signUpAddressFocus = new FocusNode();

  final signUpDOBController = TextEditingController();
  bool isSignUpDOBInFocus = false;
  FocusNode signUpDOBFocus = new FocusNode();

  final signUpRelationshipController = TextEditingController();
  bool isSignUpRelationshipInFocus = false;
  FocusNode signUpRelationshipFocus = new FocusNode();

  final signUpBarUserController = TextEditingController();
  bool isSignUpBarUserInFocus = false;
  FocusNode signUpBarUserFocus = new FocusNode();

  final signUpBarAddressController = TextEditingController();
  bool isSignUpBarAddressInFocus = false;
  FocusNode signUpBarAddressFocus = new FocusNode();

  final signUpBarPasswordController = TextEditingController();
  bool isSignUpBarPasswordInFocus = false;
  FocusNode signUpBarPasswordFocus = new FocusNode();

  final signUpBarVerifyPasswordController = TextEditingController();
  bool isSignUpBarVerifyPasswordInFocus = false;
  FocusNode signUpBarVerifyPasswordFocus = new FocusNode();

  bool loginPasswordVisible = false;

  DateTime selectedDOB = DateTime.now();

  DateTime selectedEventDate = DateTime.now();

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


  int relationStatusValue = 1;
  String relationStatusValueStr = "Single";
  List<String> relationStatusList = ["Single", "Relationship", "Open Relationship", "It´s Complicated", "Married"];
  Map<String, int> relationStatusMap = {
    'Single': 1,
    'Relationship': 2,
    'Open Relationship': 1,
    'It´s Complicated': 2,
    'Married': 1,
  };


  int kindOfBarValue = 1;
  String kindOfBarValueStr = "Cocktail";
  List<String> kindOfBarList = ["Beer", "Cocktail", "Long Drink", "Shot"];
  Map<String, int> kindOfBarMap = {
    'Beer': 1,
    'Cocktail': 2,
    'Long Drink': 3,
    'Shot': 4
  };

  int nightClubValue = 1;
  String nightClubValueStr = "Club 1";
  List<String> nightClubList = [
    "Club 1",
    "Club 2",
    "Club 3",
    "Club 4",
    "Club 5",
    "Club 6",
    "Club 7",
    "Club 8"
  ];
  Map<String, int> nightClubMap = {
    'Club 1': 1,
    'Club 2': 2,
    'Club 3': 3,
    'Club 4': 4,
    'Club 5': 5,
    'Club 6': 6,
    'Club 7': 7,
    'Club 8': 8,
  };

  int partyVacationValue = 1;
  String partyVacationValueStr = "Ibiza Beach";
  List<String> partyVacationList = [
    "Ibiza Beach",
    "Goldstrand",
    "Zrce Beach",
    "Lloret"
  ];
  Map<String, int> partyVacationMap = {
    'Ibiza Beach': 1,
    'Goldstrand': 2,
    'Zrce Beach': 3,
    'Lloret': 4
  };

  int msgTypeValue = 1;
  String msgTypeValueStr = "Private";
  List<String> msgTypeList = ["Private", "Public"];
  Map<String, int> msgTypeMap = {
    'Private': 1,
    'Public': 2,
  };

  // int blockContactValue = 1;
  // String blockContactValueStr = "Cocktail";
  // List<String> blockContactList = ["Beer", "Cocktail", "Long Drink", "Shot" ];
  // Map<String, int> blockContactMap = {
  //   'Beer': 1,
  //   'Cocktail': 2,
  //   'Long Drink' : 3,
  //   'Shot' : 4
  // };

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

  List<String> weekDaysList = ["Mo", "Tu", "We", "Th", "Fr"];

  List<int> selectedWeekendDays = [];

  List<String> weekendDaysList = ["Su", "Sa",];

  List<int> selectedBarKind = [];

  List<String> barKindList = [
    "Disco",
    "Cocktail",
    "Pub",
    "Hotel Bar",
    "Beer Hall"
  ];

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

  List<String> interestList = [
    "White Wine",
    "Hard Seltzer",
    "Whiskey",
    "Club 1",
    "Club 2",
    "Goldstrand",
  ];
  List<int> selectedInterestList = [];

  void initializeSplash() async {
    prefs = await SharedPreferences.getInstance();

    Timer(Duration(seconds: 7), () => navigateToLoginScreen());
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
      print(imageFiles);
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

  loginUser(){

  }

  createUserAccount() {
    if (signUpUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Name is required",
      ));
      return;
    }
    else if (signUpEmailController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Email is required",
      ));
      return;
    }
    if (!signUpEmailController.text.isEmail) {
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      return;
    }
    else if (signUpConfirmEmailController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Confirm Email is required",
      ));
      return;
    }
    else if (!signUpConfirmEmailController.text.isEmail) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Email is invalid"));
      return;
    }
    else if (signUpConfirmEmailController.text != signUpEmailController.text ) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Email & Confirm don't match"));
      return;
    }
    else if (signUpPhoneController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Phone Number is required",
      ));
      return;
    }
    if (signUpPhoneController.text.length < 11) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Mobile number should contain 11 digits"));
      return;
    }
    if (!signUpPhoneController.text.toString().startsWith("0")) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Mobile number should start with zero"));
      return;
    } else if (signUpPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }
    if (signUpPasswordController.text.length < 7) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password must be at least 8 characters"));
      return;
    }
    if (!CommonFunctions.hasOneUpperCase(
        signUpPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one upper case"));
      return;
    }
    if (!CommonFunctions.hasOneLowerCase(
        signUpPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one lower case"));
      return;
    }
    if (!CommonFunctions.hasOneDigit(signUpPasswordController.text.trim())) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password should contain at least one digit"));
      return;
    }
    if (!CommonFunctions.hasOneSpeicalCharacter(
        signUpPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one special character"));
      return;
    } else if (signUpVerifyPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Verify Password is required",
      ));
      return;
    } else if (signUpVerifyPasswordController.text !=
        signUpPasswordController.text) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password & Verify Password don't match",
      ));
      return;
    } else if (signUpAddressController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Address is required",
      ));
      return;
    }
    // else if (signUpDOBController.text.isEmpty) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Date Of Birth is required",
    //   ));
    //   return;
    // }
    else if (signUpRelationshipController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "RelationShip is required",
      ));
      return;
    } else if (isChecked == false) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please Accept Terms and Conditions",
      ));
      return;
    } else {
      //navigateToFavoriteScreen();
    }
    navigateToFavoriteScreen();
  }

  termsAndCondition() {
    if (termsCheck == false) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please Accept Terms and Conditions",
      ));
      return;
    } else if (dataCheck == false) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please Accept Date Protection",
      ));
      return;
    }
    navigateToHomeScreen(2);
  }

  void openAndSelectDob(BuildContext context) async {
    selectedDOB =
        await CommonFunctions.showDateOfBirthPicker(context, selectedDOB);
    notifyListeners();
  }

  void openAndSelectEventDate(BuildContext context) async {
    selectedEventDate =
    await CommonFunctions.showEventDatePicker(context, selectedEventDate);
    notifyListeners();
  }

  forgetPassword() {
    if (forgetPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Email is required",
      ));
      return;
    }
    if (!forgetPasswordController.text.isEmail) {
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      return;
    }
    navigateToCheckEmailScreen();
  }

  resentPassword() {
    if (confirmNewPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }
    if (confirmNewPasswordController.text.length < 7) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password must be at least 8 characters"));
      return;
    }
    if (!CommonFunctions.hasOneUpperCase(
        confirmNewPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one upper case"));
      return;
    }
    if (!CommonFunctions.hasOneLowerCase(
        confirmNewPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one lower case"));
      return;
    }
    if (!CommonFunctions.hasOneDigit(confirmNewPasswordController.text.trim())) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password should contain at least one digit"));
      return;
    }
    if (!CommonFunctions.hasOneSpeicalCharacter(
        confirmNewPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one special character"));
      return;
    } else if (newPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Verify Password is required",
      ));
      return;
    } else if (newPasswordController.text !=
        confirmNewPasswordController.text) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password & Verify Password don't match",
      ));
      return;
    }
    navigateToHomeBarScreen();
  }

  createBarAccount() {
    if (signUpBarUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Name is required",
      ));
      return;
    }
    else if (signUpBarAddressController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Address is required",
      ));
      return;
    }
    else if (signUpBarPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }
    if (signUpBarPasswordController.text.length < 7) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password must be at least 8 characters"));
      return;
    }
    if (!CommonFunctions.hasOneUpperCase(
        signUpBarPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one upper case"));
      return;
    }
    if (!CommonFunctions.hasOneLowerCase(
        signUpBarPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one lower case"));
      return;
    }
    if (!CommonFunctions.hasOneDigit(signUpBarPasswordController.text.trim())) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password should contain at least one digit"));
      return;
    }
    if (!CommonFunctions.hasOneSpeicalCharacter(
        signUpBarPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one special character"));
      return;
    }
    else if (signUpBarVerifyPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Verify Password is required",
      ));
      return;
    } else if (signUpBarVerifyPasswordController.text !=
        signUpBarPasswordController.text) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password & Verify Password don't match",
      ));
      return;
    } else {}
    navigateToUploadBarMedia();
  }

  onLogIn() {
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
    else if (logInPasswordController.text.length < 7) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password must contain 7 digit"));
      return;
    }
    // else if (!CommonFunctions.hasOneUpperCase(
    //     logInPasswordController.text.trim())) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //       error: "Wrong Password"));
    //   return;
    // }
    // else if (!CommonFunctions.hasOneLowerCase(
    //     logInPasswordController.text.trim())) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //       error: "Wrong Password"));
    //   return;
    // }
    // else if (!CommonFunctions.hasOneDigit(logInPasswordController.text.trim())) {
    //   DialogUtils().showDialog(
    //       MyErrorWidget(error: "Wrong Password"));
    //   return;
    // }
    // else if (!CommonFunctions.hasOneSpeicalCharacter(
    //     logInPasswordController.text.trim())) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //       error: "Wrong Password"));
    //   return;
    // }
    else {
      MainViewModel  mainViewModel = locator<MainViewModel>();
      if (logInUserSelected == true) {
        mainViewModel.logInUserSelected = true;
        mainViewModel.logInBarSelected = false;
        navigateToHomeScreen(2);
      } else if (logInBarSelected == true) {
        mainViewModel.logInUserSelected = false;
        mainViewModel.logInBarSelected = true;
        navigateToHomeBarScreen();
      }
    }
  }

  void navigateToSignUpBar() {
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

  void navigateToVerificationCodeScreen() {
    navigationService.navigateToVerificationCodeScreen();
  }

  void navigateToBarTimingTypeScreen() {
    navigationService.navigateToBarTimingTypeScreen();
  }

  void navigateToHomeBarScreen() {
    navigationService.navigateToHomeBarScreen();
  }

  void navigateToOrderDetailsScreen() {
    navigationService.navigateToOrderDetailsScreen();
  }

  void navigateToBarAccountOwnerShip() {
    navigationService.navigateToBarAccountOwnerShip();
  }

  // void navigateToResentPasswordScreen() {
  //   navigationService.navigateToResentPasswordScreen();
  // }

  void navigateBack() {
    navigationService.navigateBack();
  }

  ///-------------BAR ACCOUNT OPTIONS---------------///
  FocusNode LocationFocus = new FocusNode();
  bool isLocationInFocus = false;
  final LocationController = TextEditingController();

  FocusNode KindOfBarFocus = new FocusNode();
  bool isKindOfBarInFocus = false;
  final KindOfBarController = TextEditingController();

  FocusNode BlockContactsFocus = new FocusNode();
  bool isBlockContactsInFocus = false;
  final BlockContactsController = TextEditingController();

  FocusNode AccountOwnershipFocus = new FocusNode();
  bool isAccountOwnershipInFocus = false;
  final AccountOwnershipController = TextEditingController();
}
