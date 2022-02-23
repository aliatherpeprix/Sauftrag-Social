import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/services/addFavorites.dart';
import 'package:sauftrag/services/updateBarProfile.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/models/bar_model.dart' as barModel;
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import '../main.dart';
import 'main_view_model.dart';

class AuthenticationViewModel extends BaseViewModel {
  var dio = Dio();

  var addFavorite = Addfavorites();
  var navigationService = navigationViewModel;
  late SharedPreferences prefs;
  PrefrencesViewModel prefss = locator<PrefrencesViewModel>();
  PrefrencesViewModel prefrencesViewModel = locator<PrefrencesViewModel>();
  var updateBar = Updatebar();

  int role = Constants.user;
  bool signupCheck = false;

  bool isChecked1 = false;
  bool termsCheck = false;
  bool dataCheck = false;

  bool otpLoading = false;
  TimeOfDay? startTime;

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

  final addNewDrinkController = TextEditingController();
  bool isAddNewDrinkInFocus = false;
  FocusNode addNewDrinkFocus = new FocusNode();

  final addNewClubController = TextEditingController();
  bool isAddNewClubInFocus = false;
  FocusNode addNewClubFocus = new FocusNode();

  final addNewPartyLocationController = TextEditingController();
  bool isAddNewPartyLocationInFocus = false;
  FocusNode addNewPartyLocationFocus = new FocusNode();

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

  DateTime? selectedEventDate;

  File imageFile = File('my initial file');
  List<dynamic> imageFiles = [
    File(""),
    File(""),
    File(""),
    File(""),
    File(""),
    File(""),
  ];

  List<dynamic> eventFiles = [
    File(""),
    File(""),
    File(""),
    File(""),
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

  List<String> weekendDaysList = [
    "Su",
    "Sa",
  ];

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

    Timer(Duration(seconds: 7), () async {
      if ((await prefss.getUser()) != null) {
        UserModel? user = await prefss.getUser();
        NewBarModel? barUser = await prefss.getBarUser();
        if (user!.role == 1) {
          navigationService.navigateToHomeScreen(0);
        } else {
          navigationService.navigateToHomeBarScreen();
        }
      } else {
        navigateToLoginScreen();
      }
    });
  }

  void showErrorMessage(BuildContext context, String error) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorUtils.white,
          fontFamily: FontUtils.modernistMono,
          fontSize: 1.8.t,
        ),
      ),
      backgroundColor: ColorUtils.red_color,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      elevation: 10,
      duration: Duration(seconds: 1),
    ));
  }

  void selectRole(int role) {
    this.role = role;
    notifyListeners();
  }

  List images = [];

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

  Future<bool> getEventImage(int index) async {
    ImagePicker picker = ImagePicker();
    //List<XFile>? images = await picker.pickMultiImage();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //imageFile = File(image!.path);

    if (image == null) {
      return false;
    } else {
      eventFiles.removeAt(index);
      eventFiles.insert(index, File(image.path));
      print(eventFiles);


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

  barTiming(
      String? openingTimeFrom,
      String? openingTimeTo,
      String? breakTimeFrom,
      String? breakTimeTo,
      String? weekEndOpeningTimeFrom,
      String? weekEndOpeningTimeTo,
      String? weekEndBreakTimeFrom,
      String? weekEndBreakTimeTo) async {
    if (selectedWeekDays.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select at least one week day",
      ));
      notifyListeners();
      return;
    }
    if (selectedWeekendDays.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select at least one weekend day",
      ));
      notifyListeners();
      return;
    }
    if (selectedBarKind.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select at least one Kind of Bar",
      ));
      notifyListeners();
      return;
    }
    if (openingTimeFrom!.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select bar week open time",
      ));
      notifyListeners();
      return;
    }
    if (openingTimeTo!.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select bar week close time",
      ));
      notifyListeners();
      return;
    }
    if (breakTimeFrom!.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select bar week break open time",
      ));
      notifyListeners();
      return;
    }
    if (breakTimeTo!.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select bar week break close time",
      ));
      notifyListeners();
      return;
    }
    if (weekEndOpeningTimeFrom!.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select bar weekend open time",
      ));
      notifyListeners();
      return;
    }
    if (weekEndOpeningTimeTo!.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select bar weekend close time",
      ));
      notifyListeners();
      return;
    }
    if (weekEndBreakTimeFrom!.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select bar weekend break open time",
      ));
      notifyListeners();
      return;
    }
    if (weekEndBreakTimeTo!.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select bar weekend break open time",
      ));
      notifyListeners();
      return;
    } else {
      NewBarModel? barmodel = await prefrencesViewModel.getBarUser();

      List<int> weekDaysTiming = selectedWeekDays;
      List<int> weekendDaysTiming = selectedWeekendDays;
      //List<int> barKind = CommonFunctions.AddFromList(selectedBarKind);

      var barSignupResponse = await updateBar.UpdateBar(
        barmodel!.bar_name!,
        barmodel.address!,
        barmodel.email!,
        barmodel.password!,
        barmodel.password2!,
        imageFiles,
        weekDaysTiming,
        weekendDaysTiming,
        //barKind,
        barmodel.week_days!.opening_time!,
        barmodel.week_days!.closing_time!,
        barmodel.week_days!.break_opening_time!,
        barmodel.week_days!.break_closing_time!,
        barmodel.weekend_days!.opening_time!,
        barmodel.weekend_days!.closing_time!,
        barmodel.weekend_days!.break_opening_time!,
        barmodel.weekend_days!.break_closing_time!,
        barmodel.id!.toString(),
      );
      print(barSignupResponse);
      if (barSignupResponse is NewBarModel) {
        NewBarModel user = barSignupResponse;
        user.token = barmodel.token;
        user.password = signUpBarPasswordController.text;
        user.password2 = signUpBarVerifyPasswordController.text;
        await locator<PrefrencesViewModel>().saveBarUser(user);
      }
    }

    //navigateToHomeBarScreen();
  }

  addBarImages() {
    for (int i = 0; i < imageFiles.length; i++) {
      if (i == 0) {
        if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
            imageFiles[i].path.isEmpty) {
          DialogUtils().showDialog(MyErrorWidget(
            error: "Select Bar Logo",
          ));
          return;
        }
      }
      bool hasImages = false;
      if (i > 0) {
        if (!hasImages) {
          if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
              imageFiles[i].path.isEmpty) {
            DialogUtils().showDialog(MyErrorWidget(
              error: "Select at least one Bar Image",
            ));
            return;
          } else {
            hasImages = true;
            break;
          }
        }
      }
    }
    navigateToBarTimingTypeScreen();
    //navigateToMediaScreen();
    //navigateToHomeScreen(2);
  }

  // termsAndCondition() {
  //   if (termsCheck == false) {
  //     DialogUtils().showDialog(MyErrorWidget(
  //       error: "Please Accept Terms and Conditions",
  //     ));
  //     return;
  //   } else if (dataCheck == false) {
  //     DialogUtils().showDialog(MyErrorWidget(
  //       error: "Please Accept Date Protection",
  //     ));
  //     return;
  //   }
  //   navigateToHomeScreen(2);
  // }

  void openAndSelectDob(BuildContext context) async {
    selectedDOB =
        await CommonFunctions.showDateOfBirthPicker(context, selectedDOB);
    notifyListeners();
  }

  void openAndSelectEventDate(BuildContext context) async {
    selectedEventDate = DateTime.now();
    selectedEventDate =
    await CommonFunctions.showEventDatePicker(context, selectedEventDate!);
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

  createBarAccount() {
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
    } else {}
    navigateToUploadBarMedia();
  }

  // onLogIn() {
  //   if (logInUserController.text.isEmpty) {
  //     DialogUtils().showDialog(MyErrorWidget(
  //       error: "User Name is required",
  //     ));
  //     return;
  //   } else if (logInPasswordController.text.isEmpty) {
  //     DialogUtils().showDialog(MyErrorWidget(
  //       error: "Password is required",
  //     ));
  //     return;
  //   }
  //   else if (logInPasswordController.text.length < 7) {
  //     DialogUtils().showDialog(
  //         MyErrorWidget(error: "Password must contain 7 digit"));
  //     return;
  //   }
  //   // else if (!CommonFunctions.hasOneUpperCase(
  //   //     logInPasswordController.text.trim())) {
  //   //   DialogUtils().showDialog(MyErrorWidget(
  //   //       error: "Wrong Password"));
  //   //   return;
  //   // }
  //   // else if (!CommonFunctions.hasOneLowerCase(
  //   //     logInPasswordController.text.trim())) {
  //   //   DialogUtils().showDialog(MyErrorWidget(
  //   //       error: "Wrong Password"));
  //   //   return;
  //   // }
  //   // else if (!CommonFunctions.hasOneDigit(logInPasswordController.text.trim())) {
  //   //   DialogUtils().showDialog(
  //   //       MyErrorWidget(error: "Wrong Password"));
  //   //   return;
  //   // }
  //   // else if (!CommonFunctions.hasOneSpeicalCharacter(
  //   //     logInPasswordController.text.trim())) {
  //   //   DialogUtils().showDialog(MyErrorWidget(
  //   //       error: "Wrong Password"));
  //   //   return;
  //   // }
  //   else {
  //     MainViewModel  mainViewModel = locator<MainViewModel>();
  //     if (logInUserSelected == true) {
  //       mainViewModel.logInUserSelected = true;
  //       mainViewModel.logInBarSelected = false;
  //       navigateToHomeScreen(2);
  //     } else if (logInBarSelected == true) {
  //       mainViewModel.logInUserSelected = false;
  //       mainViewModel.logInBarSelected = true;
  //       navigateToHomeBarScreen();
  //     }
  //   }
  // }

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

  convert() {
    String s = "00:00";
    startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
  }

  void navigateToFollowerList() {
    navigationService.navigateToFollowerList();
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

  bool createEventLoader = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final eventDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  String? openingTimeFrom;
  TimeOfDay? convertOpeningTimeFrom;
  TimeOfDay? convertOpeningTimeTo;
  List eventImage = [];

  String? openingTimeTo;


  List eventDate = [];

  void validateCreateEvent(BuildContext context) async {
    if (titleController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Title is required",
      ));
      notifyListeners();
      return;
    }
    // imageFiles
  else  if (descriptionController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Description is required",
      ));
      notifyListeners();
      return;
    }
    else  if (eventFiles[0].path.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Image is required",
      ));
      notifyListeners();
      return;
    }
  else if (locationController.text.isEmpty) {

      DialogUtils().showDialog(MyErrorWidget(
        error: "Location is required",
      ));
      notifyListeners();
      return;
    }
   else if (selectedEventDate ==null) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Event Date is required",
      ));
      notifyListeners();
      return;
    }
   else if (openingTimeFrom ==null) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Start Time is required",
      ));
      notifyListeners();
      return;
    }
    else if (openingTimeTo ==null) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "End Time is required",
      ));
      notifyListeners();
      return;
    } else {
      openingTimeTo =
          "${convertOpeningTimeTo!.hour.toString()}:${convertOpeningTimeTo!.minute.toString()}";
      openingTimeFrom =
          "${convertOpeningTimeFrom!.hour.toString()}:${convertOpeningTimeFrom!.minute.toString()}";

      eventDate = selectedEventDate.toString().split(' ');

      print(titleController.text);
      print(descriptionController.text);
      print(locationController.text);
      print(eventDate);
      print(openingTimeTo);

      notifyListeners();

      createEvent();
    }
  }

  void createEvent() async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();

    List files = [];


    try {
      createEventLoader = true;
      notifyListeners();


      for (File data in eventFiles){
        if (data.path.isNotEmpty){
          String media = "data:${lookupMimeType(data.path)};base64," +
              base64Encode(data.readAsBytesSync());
          files.add(media);
        }
      }

      var createEventParams = {
        "name": titleController.text,
        "about": descriptionController.text,
        "lat": "24.00075",
        "long": "24.00075",
        "location": locationController.text,
        "event_date": eventDate[0],
        "start_time": openingTimeFrom,
        "end_time": openingTimeTo,
        "media":files
        };
      print(createEventParams);
      var response = await dio.post(
          Constants.GetEvents, data: createEventParams, options: Options(
          headers: {
            "Authorization": "Token ${user!.token!}"
          }
      ));
      print("-------------response----------");

      if (response.statusCode == 201) {
        titleController.clear();
        descriptionController.clear();
        locationController.clear();
          createEventLoader = false;
        files.clear();
        imageFiles.clear();
        selectedEventDate = null;
        openingTimeTo= null;
        openingTimeFrom ==null;
        eventFiles = [
          File(""),
          File(""),
          File(""),
          File(""),
        ];
          notifyListeners();
          navigationService.navigateBack();
      }
      else {
        print(response.statusCode);
        createEventLoader = false;
        notifyListeners();
        // DialogUtils().showDialog(
        //     MyErrorWidget(error: 'Something went wrong. Please try again'));
        throw Exception('Failed to load');
      }
    }
    catch (e) {
      print(e);
      DialogUtils().showDialog(MyErrorWidget(error: e.toString()));
      createEventLoader = false;
      notifyListeners();
    }
  }
}


