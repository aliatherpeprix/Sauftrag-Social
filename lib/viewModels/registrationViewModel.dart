import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

class RegistrationViewModel extends BaseViewModel{

  var navigationService = navigationViewModel;
  bool isChecked = false;
  bool isSigningUp = false;

  ///----------------------User Registration Controller ----------------///
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

  String? userNameError;
  String? emailError;
  String? confirmEmailError;
  String? passwordError;
  String? confirmPasswordError;
  String? addressError;
  String? dobError;
  String? relationshipError;

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

  createUserAccount() {
    isSigningUp = true;
    notifyListeners();
    if (signUpUserController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Name is required",
      ));
      notifyListeners();
      return;
    }
    else if (signUpEmailController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Email is required",
      ));
      notifyListeners();
      return;
    }
    if (!signUpEmailController.text.isEmail) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      notifyListeners();
      return;
    }
    else if (signUpConfirmEmailController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Confirm Email is required",
      ));
      notifyListeners();
      return;
    }
    else if (!signUpConfirmEmailController.text.isEmail) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
          error: "Email is invalid"));
      notifyListeners();
      return;
    }
    else if (signUpConfirmEmailController.text != signUpEmailController.text ) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
          error: "Email & Confirm don't match"));
      notifyListeners();
      return;
    }
    else if (signUpPhoneController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Phone Number is required",
      ));
      notifyListeners();
      return;
    }
    if (signUpPhoneController.text.length < 11) {
      isSigningUp = false;
      DialogUtils().showDialog(
          MyErrorWidget(error: "Mobile number should contain 11 digits"));
      notifyListeners();
      return;
    }
    if (!signUpPhoneController.text.toString().startsWith("0")) {
      isSigningUp = false;
      DialogUtils().showDialog(
          MyErrorWidget(error: "Mobile number should start with zero"));
      notifyListeners();
      return;

    } else if (signUpPasswordController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      notifyListeners();
      return;
    }
    if (signUpPasswordController.text.length < 7) {
      isSigningUp = false;
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password must be at least 8 characters"));
      isSigningUp = false;
      return;
    }
    if (!CommonFunctions.hasOneUpperCase(
        signUpPasswordController.text.trim())) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one upper case"));
      notifyListeners();
      return;
    }
    if (!CommonFunctions.hasOneLowerCase(
        signUpPasswordController.text.trim())) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one lower case"));
      notifyListeners();
      return;
    }
    if (!CommonFunctions.hasOneDigit(signUpPasswordController.text.trim())) {
      isSigningUp = false;
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password should contain at least one digit"));
      notifyListeners();
      return;
    }
    if (!CommonFunctions.hasOneSpeicalCharacter(
        signUpPasswordController.text.trim())) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one special character"));
      notifyListeners();
      return;

    } else if (signUpVerifyPasswordController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Verify Password is required",
      ));
      notifyListeners();
      return;

    } else if (signUpVerifyPasswordController.text !=
        signUpPasswordController.text) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password & Verify Password don't match",
      ));
      notifyListeners();
      return;

    } else if (signUpAddressController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Address is required",
      ));
      notifyListeners();
      return;
    }
    // else if (signUpDOBController.text.isEmpty) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Date Of Birth is required",
    //   ));
    //   return;
    // }
    else if (relationStatusValueStr.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "RelationShip is required",
      ));
      notifyListeners();
      return;

    } else if (isChecked == false) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please Accept Terms and Conditions",
      ));
      notifyListeners();
      return;
    } else {
      //navigateToFavoriteScreen();
    }
    navigateToFavoriteScreen();
  }

  void navigateToFavoriteScreen() {
    navigationService.navigateToFavoriteScreen();
  }


}