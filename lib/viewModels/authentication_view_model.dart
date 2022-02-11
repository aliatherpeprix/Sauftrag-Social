import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/services/addFavorites.dart';
import 'package:sauftrag/services/updateBarProfile.dart';
import 'package:sauftrag/services/updateUserProfile.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
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

  DateTime selectedEventDate = DateTime.now();

  File imageFile = File('my initial file');
  List<dynamic> imageFiles = [
    File(""),
    File(""),
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

  String? openingTimeTo;

  List eventDate = [];

  void validateCreateEvent(BuildContext context) async {
    if (titleController.text.isEmpty) {
      showErrorMessage(context, 'Title is required');
      notifyListeners();
      return;
    } else if (descriptionController.text.isEmpty) {
      showErrorMessage(context, 'Description is required');
      notifyListeners();
      return;
    } else if (locationController.text.isEmpty) {
      showErrorMessage(context, 'Location is required');
      notifyListeners();
      return;
    } else if (selectedEventDate == null) {
      showErrorMessage(context, 'Event Date is required');
      notifyListeners();
      return;
    } else if (openingTimeFrom == null) {
      showErrorMessage(context, 'Start Time is required');
      notifyListeners();
      return;
    } else if (openingTimeTo == null) {
      showErrorMessage(context, 'End Time is required');
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
    try {
      createEventLoader = true;
      notifyListeners();
      var createEventParams = {
        "name": titleController.text,
        "about": descriptionController.text,
        "lat": "24.00075",
        "long": "24.00075",
        "location": locationController.text,
        "event_date": eventDate[0],
        "start_time": openingTimeFrom,
        "end_time": openingTimeTo,
        "media": [
          "data:image/png;base64,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",
        ]
      };

      var response = await dio.post(Constants.GetEvents,
          data: createEventParams,
          options:
              Options(headers: {"Authorization": "Token ${user!.token!}"}));
      print(response);

      print("-------------response----------");

      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          createEventLoader = false;
          notifyListeners();
        } else {
          createEventLoader = false;
          notifyListeners();
          DialogUtils()
              .showDialog(MyErrorWidget(error: response.data["message"]));
        }
      } else {
        print(response.statusCode);
        createEventLoader = false;
        notifyListeners();
        DialogUtils().showDialog(
            MyErrorWidget(error: 'Something went wrong. Please try again'));
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);
      DialogUtils().showDialog(MyErrorWidget(error: e.toString()));
      createEventLoader = false;
      notifyListeners();
    }
  }
}
