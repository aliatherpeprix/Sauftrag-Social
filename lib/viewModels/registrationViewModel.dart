import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/user_models.dart' as userModel;
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/services/barSignup.dart';
import 'package:sauftrag/services/userSignup.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';
import 'main_view_model.dart';

class RegistrationViewModel extends BaseViewModel{
  //var _dioService = DioService.getInstance();
  var signupUser = SignupUser();
  var signupBar = SignupBar();

  var navigationService = navigationViewModel;
  bool isChecked = false;
  bool isSigningUp = false;
  int role = Constants.user;
  bool signupPasswordVisible = false;
  bool signupVerifyPasswordVisible = false;
  bool signupCheck = false;
  bool logInUserSelected = true;
  bool logInBarSelected = false;
  bool loginPasswordVisible = false;
  bool termsCheck = false;
  bool dataCheck = false;


  DateTime selectedDOB = DateTime.now();

  ///----------------------User Sign Up Registration Controller ----------------///
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

  ///----------------------Bar Sign Up Registration Controller ----------------///
  final signUpBarUserController = TextEditingController();
  bool isSignUpBarUserInFocus = false;
  FocusNode signUpBarUserFocus = new FocusNode();

  final signUpBarAddressController = TextEditingController();
  bool isSignUpBarAddressInFocus = false;
  FocusNode signUpBarAddressFocus = new FocusNode();

  final signUpBarEmailController = TextEditingController();
  bool isSignUpBarEmailInFocus = false;
  FocusNode signUpBarEmailFocus = new FocusNode();

  final signUpBarPasswordController = TextEditingController();
  bool isSignUpBarPasswordInFocus = false;
  FocusNode signUpBarPasswordFocus = new FocusNode();

  final signUpBarVerifyPasswordController = TextEditingController();
  bool isSignUpBarVerifyPasswordInFocus = false;
  FocusNode signUpBarVerifyPasswordFocus = new FocusNode();

  ///----------------------User Login Registration Controller ----------------///

  FocusNode logInUserFocus = new FocusNode();
  bool isLogInUserInFocus = false;
  final logInUserController = TextEditingController();

  final codeController = TextEditingController();

  final logInPasswordController = TextEditingController();
  bool isLoginPasswordInFocus = false;
  FocusNode loginPasswordFocus = new FocusNode();

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
    'Open Relationship': 3,
    'It´s Complicated': 4,
    'Married': 5,

  };

  int genderValue = 1;
  String genderValueStr = "Male";
  List<String> genderList = ["Male", "Female"];
  Map<String, int> genderMap = {
    'Male': 1,
    'Female': 2,
  };

  void selectRole(int role) {
    this.role = role;
    notifyListeners();
  }

  void openAndSelectDob(BuildContext context) async {
    selectedDOB = await CommonFunctions.showDateOfBirthPicker(context, selectedDOB);
    signUpDOBController.text = DateFormat('yyyy-MM-dd').format(selectedDOB);
    notifyListeners();
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

  //Signup User
  createUserAccount() async {
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
    else if (!signUpEmailController.text.isEmail) {
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
    } else
      notifyListeners();
      var user = userModel.UserModel();


      var signupResponce =  await signupUser.SignUpUser(
          signUpEmailController.text,
          signUpUserController.text,
          signUpPasswordController.text,
          signUpVerifyPasswordController.text,
          signUpPhoneController.text,
          (relationStatusList.indexOf(relationStatusValueStr) + 1).toString(),
          signUpAddressController.text,
          (genderList.indexOf(genderValueStr)+1).toString(),
          signUpDOBController.text
      );
      print(signupResponce);
    navigateToFavoriteScreen();
  }

  //Signup Bar
  createBarAccount() async {
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
    else if (signUpBarEmailController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Email is required",
      ));
      notifyListeners();
      return;
    }
    else if (!signUpBarEmailController.text.isEmail) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      notifyListeners();
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
    } else
      notifyListeners();
    var signupResponce =  await signupBar.SignUpBar(

      signUpBarUserController.text,
      signUpBarAddressController.text,
      signUpBarEmailController.text,
      signUpBarPasswordController.text,
      signUpBarVerifyPasswordController.text,
    );
    print(signupResponce);
    navigateToUploadBarMedia();
  }


  void navigateToFavoriteScreen() {
    navigationService.navigateToFavoriteScreen();
  }

  void navigateToSignUpBar() {
    navigationService.navigateToBarSignUpScreen();
  }

  void navigateToLoginScreen() {
    navigationService.navigateToLoginScreen();
  }

  void navigateToSignUpScreen() {
    navigationService.navigateToSignUpScreen();
  }

  void navigateToHomeScreen(int index) {
    navigationService.navigateToHomeScreen(index);
  }

  void navigateToHomeBarScreen() {
    navigationService.navigateToHomeBarScreen();
  }

  void navigateToForgetPasswordScreen() {
    navigationService.navigateToForgetPasswordScreen();
  }

  void navigateToUploadBarMedia() {
    navigationService.navigateToUploadBarMedia();
  }



}