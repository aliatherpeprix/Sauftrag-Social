
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/user_models.dart' as userModel;
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/services/barSignup.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/checkUser.dart';
import 'package:sauftrag/services/forget_password.dart';
import 'package:sauftrag/services/login.dart';
import 'package:sauftrag/services/login.dart';
import 'package:sauftrag/services/login.dart';
import 'package:sauftrag/services/login.dart';
import 'package:sauftrag/services/userSignup.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:stacked/stacked.dart';
import '../main.dart';
import 'main_view_model.dart';

class RegistrationViewModel extends BaseViewModel {
  //var _dioService = DioService.getInstance();
  var signupUser = SignupUser();
  var signupBar = SignupBar();
  var loginUser = LoginUser();
  var forgetpassword = ForgetPassword();
  var changepassword = Changeuserpassword();
  var checkuser = Checkuser();

  var navigationService = navigationViewModel;
  bool isChecked = false;
  bool isSigningUp = false;
  int role = Constants.user;
  bool signupPasswordVisible = false;
  bool signupVerifyPasswordVisible = false;
  bool signupCheck = false;
  bool logInUserSelected = true;
  bool logInBarSelected = false;
  bool checkUserSelected = false;
  //bool checkBarSelected = false;
  bool loginPasswordVisible = false;
  bool termsCheck = false;
  bool dataCheck = false;
  bool resetNewPasswordVisible = false;
  bool resetConfirmPasswordVisible = false;

  //For Loader
  bool logIn = false;
  bool signInUser = false;
  bool signInBar = false;
  bool forgetPasswordBool = false;
  bool createNewPasswordBool = false;

  bool otpLoading = false;
  TimeOfDay? startTime;

  PrefrencesViewModel prefrencesViewModel = locator<PrefrencesViewModel>();
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

  ///----------------------Forget Password Controller ----------------///

  final forgetPasswordController = TextEditingController();
  bool isForgetPasswordInFocus = false;
  FocusNode forgetPasswordFocus = new FocusNode();

  ///----------------------Verify New Password Controller ----------------///

  final confirmNewPasswordController = TextEditingController();
  bool isConfirmNewPasswordInFocus = false;
  FocusNode confirmNewPasswordFocus = new FocusNode();

  final resetNewPasswordController = TextEditingController();
  bool isResetNewPasswordInFocus = false;
  FocusNode resetNewPasswordFocus = new FocusNode();

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

  FocusNode LocationFocus = new FocusNode();
  bool isLocationInFocus = false;
  final LocationController = TextEditingController();


  ///----------------------User Login Registration Controller ----------------///

  FocusNode logInUserFocus = new FocusNode();
  bool isLogInUserInFocus = false;
  final logInUserController = TextEditingController();

  final codeController = TextEditingController();

  final logInPasswordController = TextEditingController();
  bool isLoginPasswordInFocus = false;
  FocusNode loginPasswordFocus = new FocusNode();

  ///-----------------Change Current Password Bar ------------------------------///

  final changeCurrentPasswordBarController = TextEditingController();
  bool ischangeCurrentPasswordBarInFocus = false;
  FocusNode changeCurrentPasswordBarFocus = new FocusNode();
  bool changeCurrentPasswordBarVisible = false;

  final changeNewPasswordBarController = TextEditingController();
  bool ischangeNewPasswordBarInFocus = false;
  FocusNode changeNewPasswordBarFocus = new FocusNode();
  bool changeNewPasswordBarVisible = false;

  final changeNewCurrentPasswordBarController = TextEditingController();
  bool ischangeNewCurrentPasswordBarInFocus = false;
  FocusNode changeNewCurrentPasswordBarFocus = new FocusNode();
  bool changeNewCurrentPasswordBarVisible = false;

  ///-----------------Change Current Password User ------------------------------///

  final changeCurrentPasswordUserController = TextEditingController();
  bool ischangeCurrentPasswordUserInFocus = false;
  FocusNode changeCurrentPasswordUserFocus = new FocusNode();
  bool changeCurrentPasswordUserVisible = false;

  final changeNewPasswordUserController = TextEditingController();
  bool ischangeNewPasswordUserInFocus = false;
  FocusNode changeNewPasswordUserFocus = new FocusNode();
  bool changeNewPasswordUserVisible = false;

  final changeNewCurrentPasswordUserController = TextEditingController();
  bool ischangeNewCurrentPasswordUserInFocus = false;
  FocusNode changeNewCurrentPasswordUserFocus = new FocusNode();
  bool changeNewCurrentPasswordUserVisible = false;


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
  List<String> relationStatusList = [
    "Single",
    "Relationship",
    "Open Relationship",
    "It´s Complicated",
    "Married"
  ];
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


  int kindOfBarValue = 1;
  String kindOfBarValueStr = "Cocktail";
  List<String> kindOfBarList = ["Beer", "Cocktail", "Long Drink", "Shot"];
  Map<String, int> kindOfBarMap = {
    'Beer': 1,
    'Cocktail': 2,
    'Long Drink': 3,
    'Shot': 4
  };



  void selectRole(int role) {
    this.role = role;
    notifyListeners();
  }

  convert (){
    String s = "00:00";
    startTime = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
  }

  void openAndSelectDob(BuildContext context) async {
    selectedDOB =
        await CommonFunctions.showDateOfBirthPicker(context, selectedDOB);
    signUpDOBController.text = DateFormat('MM-dd-yyyy').format(selectedDOB);
    notifyListeners();
  }

  String userId = "";
  String userToken = "";

  onLogIn() async {
    if (logInUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Name is required",
      ));
      return;
    }
    else if (!logInUserController.text.isEmail) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      notifyListeners();
      return;
    }
    else if (logInPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }
    else if (logInPasswordController.text.length < 7) {
      DialogUtils()
          .showDialog(MyErrorWidget(error: "Password must contain 7 digit"));
      return;
    }
    else {
      logIn = true;
      notifyListeners();

      /* var signupResponce =  await loginUser.LogInUser(
          logInUserController.text,
          logInPasswordController.text,

      );*/
      //print(signupResponce);
      MainViewModel mainViewModel = locator<MainViewModel>();
      var signupResponse = await loginUser.LogInUser(logInUserController.text,
          logInPasswordController.text, logInUserSelected ? "1" : "2");
        print(signupResponse);
      if (signupResponse is userModel.UserModel) {
        await locator<PrefrencesViewModel>().saveUser(signupResponse);
        if (logInUserSelected == true) {
          mainViewModel.logInUserSelected = true;
          mainViewModel.logInBarSelected = false;
          //logIn = false;
          //notifyListeners();
          navigateToHomeScreen(2);
        } else if (logInBarSelected == true) {
          mainViewModel.logInUserSelected = false;
          mainViewModel.logInBarSelected = true;
          //logIn = false;
          //notifyListeners();
          navigateToHomeBarScreen();
        }
      }
      // else if (signupResponse is String){
      //   logIn = false;
      //   notifyListeners();
      //   DialogUtils().showDialog(
      //       MyErrorWidget(error: (e as DioError).response!.data["detail"].toString()));
      //
      // }
      else{
        logIn = false;
        notifyListeners();
        DialogUtils().showDialog(
            MyErrorWidget(error: (signupResponse)));
      }
    }
  }

  forgetPassword() async {

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
    forgetPasswordBool = true;
    notifyListeners();

    var forgetPasswordResponce = await forgetpassword.Forgetpassword(
      forgetPasswordController.text,
    );
    print(forgetPasswordResponce);
    if (forgetPasswordResponce is int && forgetPasswordResponce == 200) {

      navigateToCheckEmailScreen();
    }
    forgetPasswordBool = false;
    notifyListeners();
  }

  void verifyResetPasswordCode(BuildContext context, String code) async{

    Dio dio = Dio();
    try{
      //resetOtpLoading = true;
      notifyListeners();

      var param = FormData.fromMap({
        "email" : forgetPasswordController.text,
        "code" : code,
      });

      var response = await dio.post(Constants.BaseUrlPro+Constants.ResetPassword, data: param);

      if (response.statusCode == 200){

        if(response.data["status"] == true){
          //resetOtpLoading = false;
          notifyListeners();
          navigateToResentPasswordScreen();
         // navigateToResentPasswordScreen();
        }
        else{
         // resetOtpLoading = false;
          notifyListeners();
          // DialogUtils().showDialog(
          //     MyErrorWidget(error: response.data["message"].toString()));
          navigateToResentPasswordScreen();
          //showErrorMessage(context, "Please enter valid verification code");
        }
      }
      else{
        //resetOtpLoading = false;
        notifyListeners();
        DialogUtils().showDialog(
            MyErrorWidget(error: response.data["message"].toString()));
      }
    }
    catch(e){
     // resetOtpLoading = false;
      notifyListeners();
      DialogUtils().showDialog(
          MyErrorWidget(error: (e as DioError).response!.data["message"].toString()));
      //showErrorMessage(context, 'Unable to process your request at this time. Please try again');
    }

  }

  resentPassword(BuildContext context) {
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
    } else if (resetNewPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Verify Password is required",
      ));
      return;
    } else if (resetNewPasswordController.text !=
        confirmNewPasswordController.text) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password & Verify Password don't match",
      ));
      return;
    }
    resetNewPassword(context);
  }

  changePassword() async {

    if (changeNewPasswordUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }

    if (changeNewPasswordUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    }
    if (changeNewPasswordUserController.text.length < 7) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password must be at least 8 characters"));
      return;
    }
    if (!CommonFunctions.hasOneUpperCase(
        changeNewPasswordUserController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one upper case"));
      return;
    }
    if (!CommonFunctions.hasOneLowerCase(
        changeNewPasswordUserController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one lower case"));
      return;
    }
    if (!CommonFunctions.hasOneDigit(changeNewPasswordUserController.text.trim())) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password should contain at least one digit"));
      return;
    }
    if (!CommonFunctions.hasOneSpeicalCharacter(
        changeNewPasswordUserController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one special character"));
      return;
    } else if (changeNewCurrentPasswordUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Verify Password is required",
      ));
      return;
    } else if (changeNewCurrentPasswordUserController.text !=
        changeNewPasswordUserController.text) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password & Verify Password don't match",
      ));
      return;
    }
    else
      notifyListeners();
   // var user = userModel.UserModel();

    var signupResponce = await changepassword.ChangeUserPassword(

        changeCurrentPasswordUserController.text,
        changeNewCurrentPasswordUserController.text
    );
    print(signupResponce);
    //navigateToFavoriteScreen();

  }



  void resetNewPassword(BuildContext context) async{

    Dio dio = Dio();

    try{
      //resetPasswordLoading = true;
      notifyListeners();

      var param = FormData.fromMap({
        "email" : forgetPasswordController.text,
        "new_password" : confirmNewPasswordController.text,
        "repeat_password" : confirmNewPasswordController.text,
        'code' : codeController.text
      });

      createNewPasswordBool = true;
      var response = await dio.post(Constants.BaseUrlPro+Constants.ConfirmNewPassword, data: param);

      if (response.statusCode == 200){

        if(response.data["code"] == 200){

          notifyListeners();
          DialogUtils().showDialog(
              MyErrorWidget(error: response.data["message"].toString()));
          Future.delayed(Duration(seconds: 2)).then((data) {
            createNewPasswordBool = false;
            notifyListeners();
            navigateToLoginScreen();
            forgetPasswordController.clear();
            resetNewPasswordController.clear();
            confirmNewPasswordController.clear();
            codeController.clear();

          });
        }
        else{

          notifyListeners();
          DialogUtils().showDialog(
              MyErrorWidget(error: response.data["message"].toString()));
          //showErrorMessage(context, "Please try again");
        }
      }
      else{
        //resetPasswordLoading = false;
        notifyListeners();
        DialogUtils().showDialog(
            MyErrorWidget(error: response.data["message"].toString()));
        //showErrorMessage(context, 'Something went wrong. Please try again');
      }
    }
    catch(e){
      //resetPasswordLoading = false;
      notifyListeners();
      DialogUtils().showDialog(
          MyErrorWidget(error: (e as DioError).response!.data["message"].toString()));
      //showErrorMessage(context, 'Unable to process your request at this time. Please try again');
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
    } else if (signUpEmailController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Email is required",
      ));
      notifyListeners();
      return;
    } else if (!signUpEmailController.text.isEmail) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      notifyListeners();
      return;
    } else if (signUpConfirmEmailController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Confirm Email is required",
      ));
      notifyListeners();
      return;
    } else if (!signUpConfirmEmailController.text.isEmail) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      notifyListeners();
      return;
    } else if (signUpConfirmEmailController.text !=
        signUpEmailController.text) {
      isSigningUp = false;
      DialogUtils()
          .showDialog(MyErrorWidget(error: "Email & Confirm don't match"));
      notifyListeners();
      return;
    } else if (signUpPhoneController.text.isEmpty) {
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
    if (!CommonFunctions.isAdult(signUpDOBController.text.toString())) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "You must be 18 years old",
      ));
      notifyListeners();
      return;
    }
    else if (signUpDOBController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Date Of Birth is required",
      ));
      return;
    }
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
    }

    else
      signInUser = true;
      notifyListeners();
    //var user = userModel.UserModel();

    var checkuserResponce = await checkuser.CheckUser(
        signUpEmailController.text,
          "1"
    );

    if(checkuserResponce is UserModel)
    {
      signInUser = false;
      notifyListeners();
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Email already exist",
      ));
      print(checkuserResponce);
    }
    else
      {
      var signupResponce = await signupUser.SignUpUser(
      signUpEmailController.text,
      signUpUserController.text,
      signUpPasswordController.text,
      signUpVerifyPasswordController.text,
      signUpPhoneController.text,
      (relationStatusList.indexOf(relationStatusValueStr) + 1).toString(),
      signUpAddressController.text,
      (genderList.indexOf(genderValueStr) + 1).toString(),
      signUpDOBController.text);
      print(signupResponce);
      signInUser = false;
      notifyListeners();
        // DialogUtils().showDialog(
        //     MyErrorWidget(error: "Use has been created succ"));
      navigateToFavoriteScreen();
      }
  }

  //Signup Bar
  createBarAccount() async {
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
    } else if (signUpBarEmailController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Email is required",
      ));
      notifyListeners();
      return;
    } else if (!signUpBarEmailController.text.isEmail) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      notifyListeners();
      return;
    } else if (signUpBarPasswordController.text.isEmpty) {
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
    } else if (signUpBarVerifyPasswordController.text.isEmpty) {
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
      signInBar = true;
      notifyListeners();

    var checkuserResponce = await checkuser.CheckUser(
        signUpBarEmailController.text,
         "2"
    );
    print(checkuserResponce);
  if(checkuserResponce is UserModel)
    {
      signInBar = false;
      notifyListeners();
      DialogUtils().showDialog(MyErrorWidget(
        error: "Bar Email already exist",
      ));
    }
  else{
    signInBar = false;
    notifyListeners();
    var signupResponce = await signupBar.SignUpBar(
      signUpBarUserController.text,
      signUpBarAddressController.text,
      signUpBarEmailController.text,
      signUpBarPasswordController.text,
      signUpBarVerifyPasswordController.text,
    );
    print(signupResponce);
    // DialogUtils().showDialog(
    //     MyErrorWidget(error: signupResponce));
    navigateToUploadBarMedia();
  }
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

  void navigateToCheckEmailScreen() {
    navigationService.navigateToCheckEmailScreen();
  }

  void navigateBack() {
    navigationService.navigateBack();
  }

  void navigateToResentPasswordScreen() {
    navigationService.navigateToResentPasswordScreen();
  }

  void navigateToChangePassword() {
    navigationService.navigateToChangePassword();
  }

  void navigateToBarAccountOwnerShip() {
    navigationService.navigateToBarAccountOwnerShip();
  }

  void navigateToUserProfileAccountOwnershipScreen(){
    navigationService.navigateToUserProfileAccountOwnershipScreen();
  }

  void navigateToUserDetailSettings() {
    navigationService.navigateToUserDetailSettings();
  }

  void navigateToBarProfileScreen() {
    navigationService.navigateToBarProfileScreen();
  }



}
