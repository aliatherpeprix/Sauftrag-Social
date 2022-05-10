import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:pubnub/pubnub.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_Kind_Model.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/create_bar_post.dart';
import 'package:sauftrag/models/day_week.dart';
import 'package:sauftrag/models/day_weekend.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart' as userModel;
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/services/addBar.dart';
import 'package:sauftrag/services/addFavorites.dart';
import 'package:sauftrag/services/barSignup.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/changeUserPassword.dart';
import 'package:sauftrag/services/checkBar.dart';
import 'package:sauftrag/services/checkUser.dart';
import 'package:sauftrag/services/createPost.dart';
import 'package:sauftrag/services/forget_password.dart';
import 'package:sauftrag/services/login.dart';
import 'package:sauftrag/services/login.dart';
import 'package:sauftrag/services/login.dart';
import 'package:sauftrag/services/login.dart';
import 'package:sauftrag/services/updateUserProfile.dart';
import 'package:sauftrag/services/userSignup.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';
import '../main.dart';
import 'main_view_model.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import "package:google_maps_webservice/geocoding.dart";
import "package:google_maps_webservice/places.dart";
import 'package:google_api_headers/google_api_headers.dart';


class RegistrationViewModel extends BaseViewModel {
  //var _dioService = DioService.getInstance();
  var signupUser = SignupUser();
  var signupBar = SignupBar();
  var loginUser = LoginUser();
  var forgetpassword = ForgetPassword();
  var changepassword = Changeuserpassword();
  var checkuser = Checkuser();
  var updateUser = UpdateUser();
  var addFavorite = Addfavorites();
  var createBarPost = Createpost();
  var checkBar = Checkbar();
  var addBarKind = AddBarKind();


  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

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
  bool loading = false;
  bool getStarted = false;
  bool favDrink = false;
  bool eventSelected = false;
  int? currentEventSelected;
  bool timeSelected = false;
  int? timeValue;
  double lowerValue = 50;
  double upperValue = 180;
  String? lowValue = "50";
  String? highValue = "180";
  List<Marker> markers = <Marker>[];
  Completer<GoogleMapController> controller = Completer();

  //For LoaderdeterminePosition
  bool logIn = false;
  bool signInUser = false;
  bool signInBar = false;
  bool forgetPasswordBool = false;
  bool createNewPasswordBool = false;
  bool addDrink = false;
  bool privacyPolicy = false;

  Subscription? subscription;
  Channel? channel;
  PubNub? pubnub;

  bool otpLoading = false;
  TimeOfDay? startTime;

  List<Marker> marker = <Marker>[];
  String address = "";
  GoogleMapController? mapController;
  double? lat;
  double? lng;

  Position? currentPosition;


  PrefrencesViewModel prefrencesViewModel = locator<PrefrencesViewModel>();
  DateTime selectedDOB = DateTime.now();

  ///----------------------User Sign Up Registration Controller ----------------///
  final signUpUserController = TextEditingController();
  bool isSignUpUserInFocus = false;
  FocusNode signUpUserFocus = new FocusNode();

  List<FavoritesModel> drinks = [];

  final mapSearchController = TextEditingController();

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

  final addDrinkController = TextEditingController();
  bool isAddDrinkInFocus = false;
  FocusNode addDrinkFocus = new FocusNode();

  final addNewDrinkController = TextEditingController();
  bool isAddNewDrinkInFocus = false;
  FocusNode addNewDrinkFocus = new FocusNode();

  final addNewClubController = TextEditingController();
  bool isAddNewClubInFocus = false;
  FocusNode addNewClubFocus = new FocusNode();

  final addNewPartyLocationController = TextEditingController();
  bool isAddNewPartyLocationInFocus = false;
  FocusNode addNewPartyLocationFocus = new FocusNode();


  final updateNewDrinkController = TextEditingController();
  bool isUpdateNewDrinkInFocus = false;
  FocusNode updateNewDrinkFocus = new FocusNode();
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

  final signUpBarAboutController = TextEditingController();
  bool isSignUpBarAboutInFocus = false;
  FocusNode signUpBarAboutFocus = new FocusNode();

  final signUpBarPasswordController = TextEditingController();
  bool isSignUpBarPasswordInFocus = false;
  FocusNode signUpBarPasswordFocus = new FocusNode();

  final signUpBarVerifyPasswordController = TextEditingController();
  bool isSignUpBarVerifyPasswordInFocus = false;
  FocusNode signUpBarVerifyPasswordFocus = new FocusNode();

  FocusNode LocationFocus = new FocusNode();
  bool isLocationInFocus = false;
  final LocationController = TextEditingController();


  final locationController = TextEditingController();

  bool checkSignupUser = false;
  String? openingTimeFrom = "";
  String? openingTimeTo = "";
  String? breakTimeFrom = "";
  String? breakTimeTo = "";
  String? weekEndOpeningTimeFrom = "";
  String? weekEndOpeningTimeTo = "";
  String? weekEndBreakTimeFrom = "";
  String? weekEndBreakTimeTo = "";

  var getFavsDrinks = Addfavorites();

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

  ///-------------------Create Bar Post ---------------------------------///
  ///
  ///
  ///-------------------Create Event Open -------------------------------------///

  bool createEventLoader = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final maplocationController = TextEditingController();
  final eventDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  List eventDate = [];
  List<dynamic> eventFiles = [
    File(""),
    File(""),
    File(""),
    File(""),
  ];
  DateTime? selectedEventDate;
  TimeOfDay? convertOpeningTimeFrom;
  TimeOfDay? convertOpeningTimeTo;
  var dio = Dio();
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
  void openAndSelectEventDate(BuildContext context) async {
    selectedEventDate = DateTime.now();
    selectedEventDate =
    await CommonFunctions.showEventDatePicker(context, selectedEventDate!);
    notifyListeners();
  }

  void validateCreateEvent(BuildContext context) async {
    if (titleController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Title is required",
      ));
      notifyListeners();
      return;
    }
    // imageFiles
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
    else if (maplocationController.text.isEmpty) {

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
      openingTimeTo = "${convertOpeningTimeTo!.hour.toString()}:${convertOpeningTimeTo!.minute.toString()}";
      openingTimeFrom = "${convertOpeningTimeFrom!.hour.toString()}:${convertOpeningTimeFrom!.minute.toString()}";
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

    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
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
        "lat": latitude.toStringAsFixed(5),
        "long": longitude.toStringAsFixed(5),
        "location": maplocationController.text,
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
        maplocationController.clear();
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

  void navigateToBarEventLocationBarScreen() {
    navigationService.navigateToBarEventLocationBarScreen();
  }

  void navigateToBarEventMapScreen() {
    navigationService.navigateToBarEventMapScreen();
  }

  ///-------------------Create Event Closed -------------------------------------///


  final barPostLocationController = TextEditingController();
  bool isBarPostLocationInFocus = false;
  FocusNode barPostLocationFocus = new FocusNode();

  final barPostController = TextEditingController();
  bool isBarPostInFocus = false;
  FocusNode barPostFocus = new FocusNode();

  String? userNameError;
  String? emailError;
  String? confirmEmailError;
  String? passwordError;
  String? confirmPasswordError;
  String? addressError;
  String? dobError;
  String? relationshipError;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

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

  int msgTypeValue = 1;
  String msgTypeValueStr = "Public";
  List<String> msgTypeList = ["Public", "Private"];
  Map<String, int> msgTypeMap = {
    'Public': 1,
    'Private': 2,
  };
  List<dynamic> imageFilesPost = [
    File(""),
  ];

  List<int> selectedWeekDays = [];

  List<DayWeekModel> weekDaysList = [
    DayWeekModel.fromJson({"day__id": 1, "day__name": "Mon"}),
    DayWeekModel.fromJson({"day__id": 2, "day__name": "Tue"}),
    DayWeekModel.fromJson({"day__id": 3, "day__name": "Wed"}),
    DayWeekModel.fromJson({"day__id": 4, "day__name": "Thu"}),
    DayWeekModel.fromJson({"day__id": 5, "day__name": "Fri"}),
  ];

  List<int> selectedWeekendDays = [];

  List<DayWeekendModel> weekendDaysList = [
    DayWeekendModel.fromJson({"day__id": 6, "day__name": "Sat"}),
    DayWeekendModel.fromJson({"day__id": 7, "day__name": "Sun"})
  ];

  List<int> selectedBarKind = [];

  List<String> barKindList = [
    "Beer Hall",
    "Hotel Bar",
    "Pub",
    "Cocktail",
    "Disco",
  ];

  TextEditingController addCustomBarController = TextEditingController();

  List<dynamic> clubList = [];
  List<int> selectedClubList = [];

  List<int> selectedVacationList = [];

  List<dynamic> drinkList = [];

  List<int> selectedDrinkList = [];

  List<String> interestList = [
    "White Wine",
    "Hard Seltzer",
    "Whiskey",
    "Club 1",
    "Club 2",
    "Goldstrand",
  ];

  List<FavoritesModel> addDrinkList = [];

  List<String> addFavDrinkList = [];

  List<dynamic> vacationList = [];

  int kindOfBarValue = 1;
  String kindOfBarValueStr = "Cocktail";
  List<String> kindOfBarList = ["Beer", "Cocktail", "Long Drink", "Shot"];
  Map<String, int> kindOfBarMap = {
    'Beer': 1,
    'Cocktail': 2,
    'Long Drink': 3,
    'Shot': 4
  };

  List<dynamic> imageFiles = [
    File(""),
    File(""),
    File(""),
    File(""),
    File(""),
    File("")
  ];

  Future<bool> getImage(int index) async {
    ImagePicker picker = ImagePicker();
    //List<XFile>? images = await picker.pickMultiImage();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //imageFile = File(image!.path);

    if (image == null) {
      return false;
    } else {
      imageFiles.removeAt(index);
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


  Future<bool> getPostImage(int index) async {
    ImagePicker picker = ImagePicker();
    //List<XFile>? images = await picker.pickMultiImage();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //imageFile = File(image!.path);

    if (image == null) {
      return false;
    } else {
      imageFilesPost.removeAt(index);
      imageFilesPost.insert(index, File(image.path));
      print(imageFilesPost);
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

  addMarkers(LatLng latlng) {
    markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(latlng.latitude, latlng.longitude),
        infoWindow: InfoWindow(title: 'The title of the marker')));
  }

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(24.8169, 67.1118),
    zoom: 14.4746,
  );

  addBarImages() {
    if (imageFiles[0].path.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Bar logo is required",
      ));
      return;
    }
    if (signUpBarAboutController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "About is required",
      ));
      return;
    }
    // for (int i = 0; i < imageFiles.length; i++) {
    //   if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
    //       imageFiles[i].path.isEmpty) {
    //     DialogUtils().showDialog(MyErrorWidget(
    //       error: "Select All Images"/*+i.toString()*/,
    //     ));
    //     return;
    //   }
    //
    //   // bool hasImages = false;
    //   // if (!hasImages) {
    //   //   if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
    //   //       imageFiles[i].path.isEmpty) {
    //   //     DialogUtils().showDialog(MyErrorWidget(
    //   //       error: "Select at least one Image",
    //   //     ));
    //   //     return;
    //   //   } else {
    //   //     hasImages = true;
    //   //     break;
    //   //   }
    //   // }
    // }
    // for (int i = 0; i < imageFiles.length; i++) {
    //   // if (i == 0) {
    //   //   if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
    //   //       imageFiles[i].path.isEmpty) {
    //   //     DialogUtils().showDialog(MyErrorWidget(
    //   //       error: "Select Bar Logo",
    //   //     ));
    //   //     return;
    //   //   }
    //   // }
    //   bool hasImages = false;
    //   if (i > 0) {
    //     if (!hasImages) {
    //       if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
    //           imageFiles[i].path.isEmpty) {
    //         DialogUtils().showDialog(MyErrorWidget(
    //           error: "Select at least one Bar Image",
    //         ));
    //         return;
    //       } else {
    //         hasImages = true;
    //         break;
    //       }
    //     }
    //   }
    // }
    navigateToBarTimingTypeScreen();
    //navigateToMediaScreen();
    //navigateToHomeScreen(2);
  }

  void selectRole(int role) {
    this.role = role;
    notifyListeners();
  }

  convert() {
    String s = "00:00";
    startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
  }

  Future navigateToPosition(LatLng latLng) async {

    kGooglePlex = CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 18,
    );

    mapController!.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));

    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    address = "${placemarks[0].name} ${placemarks[0].street} ${placemarks[0].subLocality} ${placemarks[0].locality} ${placemarks[0].country}";
    lat = latLng.latitude;
    lng = latLng.longitude;

    markers.clear();
    markers.add(
        Marker(
            markerId: MarkerId(placemarks[0].name!),
            position: LatLng(latLng.latitude, latLng.longitude),
            infoWindow: InfoWindow(
                title: placemarks[0].name
            )
        )
    );

    notifyListeners();
  }

  Future<void> searchAddress(BuildContext context) async {

    var p = await PlacesAutocomplete.show(
        offset: 0,
        radius: 1000,
        types: [],
        strictbounds: false,
        context: context,
        apiKey: Constants.kGoogleApiKey,
        mode: Mode.overlay, // Mode.fullscreen
        language: "en",
        components: [new Component(Component.country, "pk")]);
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: Constants.kGoogleApiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p!.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    print(p.description);

    address = p.description!;
    this.lat = lat;
    this.lng = lng;

    markers.clear();
    markers.add(
        Marker(
            markerId: MarkerId(p.placeId.toString()),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
                title: ""
            )
        )
    );

    kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 18,
    );

    mapController!.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));

    notifyListeners();
  }

  void openAndSelectDob(BuildContext context) async {
    selectedDOB =
        await CommonFunctions.showDateOfBirthPicker(context, selectedDOB);
    signUpDOBController.text = DateFormat('MM-dd-yyyy').format(selectedDOB);
    notifyListeners();
  }

  //String userId = "";
  //String userToken = "";

  onLogIn() async {
    if (logInUserController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Name is required",
      ));
      return;
    } else if (!logInUserController.text.isEmail) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      notifyListeners();
      return;
    } else if (logInPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Password is required",
      ));
      return;
    } else if (logInPasswordController.text.length < 7) {
      DialogUtils()
          .showDialog(MyErrorWidget(error: "Password must contain 7 digit"));
      return;
    } else {
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
        userModel.UserModel user = signupResponse;
        user.favorite_alcohol_drinks = user.favorite_alcohol_drinks!;
        user.favorite_musics = user.favorite_musics!;
        user.favorite_party_vacation = user.favorite_party_vacation!;
        await locator<PrefrencesViewModel>().saveUser(signupResponse);
        mainViewModel.logInUserSelected = true;
        mainViewModel.logInBarSelected = false;
        //logIn = false;
        //notifyListeners();
        navigateToHomeScreen(2);
      } else if (signupResponse is NewBarModel) {
        //NewBarModel user = signupResponse;
        // user.favorite_alcohol_drinks = CommonFunctions.SubtractFromList(user.favorite_alcohol_drinks!);
        // user.favorite_night_club = CommonFunctions.SubtractFromList(user.favorite_night_club!);
        // user.favorite_party_vacation = CommonFunctions.SubtractFromList(user.favorite_party_vacation!);
        await locator<PrefrencesViewModel>().saveBarUser(signupResponse);
        mainViewModel.logInUserSelected = false;
        mainViewModel.logInBarSelected = true;
        //logIn = false;
        //notifyListeners();
        navigateToHomeBarScreen();
      }
      // if (logInUserSelected == true) {
      //
      // } else if (logInBarSelected == true) {
      //
      // }
      // else if (signupResponse is String){
      //   logIn = false;
      //   notifyListeners();
      //   DialogUtils().showDialog(
      //       MyErrorWidget(error: (e as DioError).response!.data["detail"].toString()));
      //
      // }
      else {
        logIn = false;
        notifyListeners();
        DialogUtils().showDialog(MyErrorWidget(error: (signupResponse)));
      }
    }
  }

  double longitude = 0.0;
  double latitude = 0.0;
  // var currentPosition;
  Future getCurrentLocation() async{
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      // currentPosition = position;
      notifyListeners();
      // currentPosition;
      longitude = position.longitude;
      latitude = position.latitude;
      notifyListeners();
      // print(currentPosition);
    }).catchError((e) {
      print(e);
    });
  }

  Future determinePosition1() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    mapController = await controller.future;

    navigateToPosition(LatLng(currentPosition!.latitude, currentPosition!.longitude));

  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please turn on your device location",
      ));
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  logOutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    navigateAndRemoveSignInScreen();
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

  void verifyResetPasswordCode(BuildContext context, String code) async {
    Dio dio = Dio();
    try {
      //resetOtpLoading = true;
      notifyListeners();

      var param = FormData.fromMap({
        "email": forgetPasswordController.text,
        "code": code,
      });

      var response = await dio
          .post(Constants.BaseUrlPro + Constants.ResetPassword, data: param);

      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          //resetOtpLoading = false;
          notifyListeners();
          navigateToResentPasswordScreen();
          // navigateToResentPasswordScreen();
        } else {
          // resetOtpLoading = false;
          notifyListeners();
          // DialogUtils().showDialog(
          //     MyErrorWidget(error: response.data["message"].toString()));
          navigateToResentPasswordScreen();
          //showErrorMessage(context, "Please enter valid verification code");
        }
      } else {
        //resetOtpLoading = false;
        notifyListeners();
        DialogUtils().showDialog(
            MyErrorWidget(error: response.data["message"].toString()));
      }
    } catch (e) {
      // resetOtpLoading = false;
      notifyListeners();
      DialogUtils().showDialog(MyErrorWidget(
          error: (e as DioError).response!.data["message"].toString()));
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
    if (!CommonFunctions.hasOneDigit(
        confirmNewPasswordController.text.trim())) {
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
    if (!CommonFunctions.hasOneDigit(
        changeNewPasswordUserController.text.trim())) {
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
    } else
      notifyListeners();
    // var user = userModel.UserModel();

    var signupResponce = await changepassword.ChangeUserPassword(
        changeCurrentPasswordUserController.text,
        changeNewCurrentPasswordUserController.text);
    print(signupResponce);
    //navigateToFavoriteScreen();
  }

  void resetNewPassword(BuildContext context) async {
    Dio dio = Dio();

    try {
      //resetPasswordLoading = true;
      notifyListeners();

      var param = FormData.fromMap({
        "email": forgetPasswordController.text,
        "new_password": confirmNewPasswordController.text,
        "repeat_password": confirmNewPasswordController.text,
        'code': codeController.text
      });

      createNewPasswordBool = true;
      var response = await dio.post(
          Constants.BaseUrlPro + Constants.ConfirmNewPassword,
          data: param);

      if (response.statusCode == 200) {
        if (response.data["code"] == 200) {
          notifyListeners();
          DialogUtils().showDialog(
              MyErrorWidget(error: response.data["message"].toString()));
          Future.delayed(Duration(seconds: 2)).then((data) {
            createNewPasswordBool = false;
            notifyListeners();
            navigateAndRemoveSignInScreen();
            //navigateToLoginScreen();
            forgetPasswordController.clear();
            resetNewPasswordController.clear();
            confirmNewPasswordController.clear();
            codeController.clear();
          });
        } else {
          notifyListeners();
          DialogUtils().showDialog(
              MyErrorWidget(error: response.data["message"].toString()));
          //showErrorMessage(context, "Please try again");
        }
      } else {
        //resetPasswordLoading = false;
        notifyListeners();
        DialogUtils().showDialog(
            MyErrorWidget(error: response.data["message"].toString()));
        //showErrorMessage(context, 'Something went wrong. Please try again');
      }
    } catch (e) {
      //resetPasswordLoading = false;
      notifyListeners();
      DialogUtils().showDialog(MyErrorWidget(
          error: (e as DioError).response!.data["message"].toString()));
      //showErrorMessage(context, 'Unable to process your request at this time. Please try again');
    }
  }

  Future termsAndCondition() async {
    // if (termsCheck == false) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Please Accept Terms and Conditions",
    //   ));
    //   return;
    // }
    // else if (dataCheck == false) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Please Accept Data Protection",
    //   ));
    //   return;
    // }

      getStarted = true;
      notifyListeners();
      userModel.UserModel? usermodel = await prefrencesViewModel.getUser();
      // List<int> newDrinks = [];
      // List<int> newClubs = [];
      // List<int> newVacations = [];

      // for (int drink in selectedDrinkList){
      //   newDrinks.add(drink+1);
      // }
      // for (int drink in selectedClubList){
      //   newClubs.add(drink+1);
      // }
      // for (int drink in selectedVacationList){
      //   newVacations.add(drink+1);
      // }
      var userSignupResponce = await signupUser.SignUpUser(

          usermodel!.email!,
          usermodel.username!,
          usermodel.password!,
          usermodel.password!,
          usermodel.phone_no!,
          usermodel.relation_ship.toString(),
          latitude.toStringAsFixed(5),
          longitude.toStringAsFixed(5),
          usermodel.address!,
          usermodel.gender!.toString(),
          usermodel.dob.toString(),
          selectedDrinkList,
          selectedClubList,
          selectedVacationList,
          imageFiles,
          termsCheck,
          dataCheck,
          );
      print(userSignupResponce);
      if (userSignupResponce is UserModel) {
        userModel.UserModel user = userSignupResponce;
        // user.token = usermodel.token;
        // user.password = signUpPasswordController.text;
        // user.password2 = signUpVerifyPasswordController.text;
        // user.favorite_alcohol_drinks = user.favorite_alcohol_drinks!;
        // user.favorite_night_club = user.favorite_night_club!;
        // user.favorite_party_vacation = user.favorite_party_vacation!;
        await locator<PrefrencesViewModel>().saveUser(user);
        dataCheck = false;
        selectedDrinkList.clear();
        selectedClubList.clear();
        selectedVacationList.clear();
        imageFiles = [
          File(""),
          File(""),
          File(""),
          File(""),
          File(""),
          File("")
        ];

        //model.imageFiles = [];
        // DialogUtils().showDialog(
        //     MyErrorWidget(error: "Use has been created succ"));
        navigateToHomeScreen(2);
      }

      //favorites();

    //signInUser = false;
    getStarted = false;
    notifyListeners();
    //navigateToHomeScreen(2);
  }

  favoritesDrinks(List<int> selectedList, String favorite) async {
    if (selectedList.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select at least one favorite drink",
      ));
      notifyListeners();
      return;
    } else {
      userModel.UserModel? usermodel = await prefrencesViewModel.getUser();

      var userSignupResponce =
          await updateUser.UpdateUserFavorites(selectedList, favorite);
      print(userSignupResponce);
      if (userSignupResponce is UserModel) {
        userModel.UserModel user = userSignupResponce;
        if (favorite == "favorite_alcohol_drinks") {
          user.favorite_alcohol_drinks =
              CommonFunctions.SubtractFromList(user.favorite_alcohol_drinks!);
        }
        if (favorite == "favorite_night_club") {
          user.favorite_musics =
              CommonFunctions.SubtractFromList(user.favorite_musics!);
        }
        if (favorite == "favorite_party_vacation") {
          user.favorite_party_vacation =
              CommonFunctions.SubtractFromList(user.favorite_party_vacation!);
        }
        await locator<PrefrencesViewModel>().saveUser(user);
      }
      selectedDrinkList.clear();
      selectedClubList.clear();
      selectedVacationList.clear();
      imageFiles = [File(""), File(""), File(""), File(""), File(""), File("")];
      //model.imageFiles = [];
      dataCheck = false;
      //signInUser = false;
      notifyListeners();
      // DialogUtils().showDialog(
      //     MyErrorWidget(error: "Use has been created succ"));
      navigateToHomeScreen(2);
    }
    // if (selectedClubList.isEmpty) {
    //
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Select at least one favorite club",
    //   ));
    //   notifyListeners();
    //   return;
    // }
    // if (selectedVacationList.isEmpty) {
    //
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Select at least one favorite party vacation",
    //   ));
    //   notifyListeners();
    //   return;
    // }

    //navigateToMediaScreen();
    //navigateToMediaScreen();
    //navigateToHomeScreen(2);
  }

  favorites() {
    if (selectedDrinkList.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select at least one favorite drink",
      ));
      notifyListeners();
      return;
    }
    if (selectedClubList.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select at least one favorite club",
      ));
      notifyListeners();
      return;
    }
    if (selectedVacationList.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select at least one favorite party vacation",
      ));
      notifyListeners();
      return;
    }

    navigateToMediaScreen();
    //navigateToMediaScreen();
    //navigateToHomeScreen(2);
  }

  Future addImageUser() async {
    getStarted = true;
    notifyListeners();
    // for (int i = 0; i < imageFiles.length; i++) {
    //   if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
    //       imageFiles[i].path.isEmpty) {
    //     DialogUtils().showDialog(MyErrorWidget(
    //       error: "Select All Images"/*+i.toString()*/,
    //     ));
    //     return;
    //   }
    //
    //   // bool hasImages = false;
    //   // if (!hasImages) {
    //   //   if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
    //   //       imageFiles[i].path.isEmpty) {
    //   //     DialogUtils().showDialog(MyErrorWidget(
    //   //       error: "Select at least one Image",
    //   //     ));
    //   //     return;
    //   //   } else {
    //   //     hasImages = true;
    //   //     break;
    //   //   }
    //   // }
    // }
    getStarted = false;
    notifyListeners();
    //navigateToTermsScreen();
    //navigateToMediaScreen();
    //navigateToHomeScreen(2);
  }

    addFavoritedrink() async {
    if (addNewDrinkController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please add new drink",
      ));
      notifyListeners();
      return;
    } else {
      addDrink = true;
      notifyListeners();
      //drinkList = await Addfavorites().GetFavoritesDrink();
      var addFavoriteResponce = await addFavorite.AddFavoritesDrink(
        addNewDrinkController.text,
      );
      if (addFavoriteResponce is FavoritesModel) {
        var name = addFavoriteResponce.name;
        // drinks = addFavoriteResponce;
        drinkList.add(addFavoriteResponce);
        notifyListeners();
      }
      print(drinkList);
      navigateBack();
      addDrink = false;
      drinkList = await Addfavorites().GetFavoritesDrink();
      addNewDrinkController.clear();
      notifyListeners();

    }
  }

  addFavoriteclub() async {
    if (addNewClubController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please add new club",
      ));
      notifyListeners();
      return;
    } else {
      addDrink = true;
      notifyListeners();
      var addFavoriteResponce = await addFavorite.AddFavoritesClub(
        addNewClubController.text,
      );
      if (addFavoriteResponce is FavoritesModel) {
        var name = addFavoriteResponce.name;
        // drinks = addFavoriteResponce;
        clubList.add(addFavoriteResponce);
        notifyListeners();
      }
      print(clubList);
      navigateBack();
      addDrink = false;
      addNewClubController.clear();
      notifyListeners();
    }
  }

  addFavoritePartyVacation() async {
    if (addNewPartyLocationController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please add new location",
      ));
      notifyListeners();
      return;
    } else {
      addDrink = true;
      notifyListeners();
      var addFavoriteResponce = await addFavorite.AddFavoritesPartyVacation(
        addNewPartyLocationController.text,
      );
      if (addFavoriteResponce is FavoritesModel) {
        var name = addFavoriteResponce.name;
        // drinks = addFavoriteResponce;
        vacationList.add(addFavoriteResponce);
        notifyListeners();
      }
      print(vacationList);
      navigateBack();
      addDrink = false;
      addNewPartyLocationController.clear();
      notifyListeners();
    }
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
    }
    // else if (signUpConfirmEmailController.text.isEmpty) {
    //   isSigningUp = false;
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Confirm Email is required",
    //   ));
    //   notifyListeners();
    //   return;
    // }
    // else if (!signUpConfirmEmailController.text.isEmail) {
    //   isSigningUp = false;
    //   DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
    //   notifyListeners();
    //   return;
    // } else if (signUpConfirmEmailController.text !=
    //     signUpEmailController.text) {
    //   isSigningUp = false;
    //   DialogUtils()
    //       .showDialog(MyErrorWidget(error: "Email & Confirm don't match"));
    //   notifyListeners();
    //   return;
    // }
    else if (signUpPhoneController.text.isEmpty) {
      isSigningUp = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Phone Number is required",
      ));
      notifyListeners();
      return;
    }
    // if (signUpPhoneController.text.length < 7) {
    //   isSigningUp = false;
    //   DialogUtils().showDialog(
    //       MyErrorWidget(error: "Mobile number should contain 11 digits"));
    //   notifyListeners();
    //   return;
    // }
    // if (!signUpPhoneController.text.toString().startsWith("0")) {
    //   isSigningUp = false;
    //   DialogUtils().showDialog(
    //       MyErrorWidget(error: "Mobile number should start with zero"));
    //   notifyListeners();
    //   return;
    // }
    else if (signUpPasswordController.text.isEmpty) {
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
    }
    // else if (signUpVerifyPasswordController.text.isEmpty) {
    //   isSigningUp = false;
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Verify Password is required",
    //   ));
    //   notifyListeners();
    //   return;
    // }
    // else if (signUpVerifyPasswordController.text != signUpPasswordController.text) {
    //   isSigningUp = false;
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Password & Verify Password don't match",
    //   ));
    //   notifyListeners();
    //   return;
    // }
    else if (signUpAddressController.text.isEmpty) {
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
    } else if (signUpDOBController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Date Of Birth is required",
      ));
      return;
    } else if (relationStatusValueStr.isEmpty) {
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
      signInUser = true;
    notifyListeners();
    //var user = userModel.UserModel();

    var checkuserResponce =
        await checkuser.CheckUser(signUpEmailController.text, "1");

    if (checkuserResponce is UserModel) {
      signInUser = false;
      notifyListeners();
      DialogUtils().showDialog(MyErrorWidget(
        error: "User Email already exist",
      ));
      print(checkuserResponce);
    } else {
      userModel.UserModel user = userModel.UserModel();
      // var signupResponce = await signupUser.SignUpUser(
      // signUpEmailController.text,
      // signUpUserController.text,
      // signUpPasswordController.text,
      // signUpVerifyPasswordController.text,
      // signUpPhoneController.text,
      // (relationStatusList.indexOf(relationStatusValueStr) + 1).toString(),
      // signUpAddressController.text,
      // (genderList.indexOf(genderValueStr) + 1).toString(),
      // DateFormat("yyyy-MM-dd").format(selectedDOB),
      //     selectedDrinkList,
      //     selectedClubList,
      //     selectedVacationList,
      //     imageFiles
      // );
      user.email = signUpEmailController.text;
      user.username = signUpUserController.text;
      user.password = signUpPasswordController.text;
      //user.password2 = signUpVerifyPasswordController.text;
      user.phone_no = signUpPhoneController.text;
      user.relation_ship = (relationStatusList.indexOf(relationStatusValueStr) + 1).toString();
      user.address = signUpAddressController.text;
      user.gender = (genderList.indexOf(genderValueStr) + 1).toString();
      user.dob = DateFormat("yyyy-MM-dd").format(selectedDOB);
      await prefrencesViewModel.saveUser(user);

      //print(signupResponce);

      //var responce = await Addfavorites().GetFavoritesDrink();
      signInUser = false;
      notifyListeners();
      // DialogUtils().showDialog(
      //     MyErrorWidget(error: "Use has been created succ"));
      navigateToFavoriteScreen();
      //favorites();
    }
  }

  //Signup Bar
  signupBarScreen() async {
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
    } else if (signUpBarPasswordController.text.length < 7) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password must be at least 8 characters"));
      return;
    } else if (!CommonFunctions.hasOneUpperCase(
        signUpBarPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one upper case"));
      return;
    } else if (!CommonFunctions.hasOneLowerCase(
        signUpBarPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one lower case"));
      return;
    } else if (!CommonFunctions.hasOneDigit(
        signUpBarPasswordController.text.trim())) {
      DialogUtils().showDialog(
          MyErrorWidget(error: "Password should contain at least one digit"));
      return;
    } else if (!CommonFunctions.hasOneSpeicalCharacter(
        signUpBarPasswordController.text.trim())) {
      DialogUtils().showDialog(MyErrorWidget(
          error: "Password should contain at least one special character"));
      return;
    }
    // else if (signUpBarVerifyPasswordController.text.isEmpty) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Verify Password is required",
    //   ));
    //   return;
    // } else if (signUpBarVerifyPasswordController.text !=
    //     signUpBarPasswordController.text) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Password & Verify Password don't match",
    //   ));
    //   return;
    // }
    else {
      checkSignupUser = true;
      notifyListeners();

      var checkuserResponce =
          await checkBar.CheckBar(signUpBarEmailController.text, "2");

      if (checkuserResponce is UserModel) {
        checkSignupUser = false;
        notifyListeners();
        DialogUtils().showDialog(MyErrorWidget(
          error: "Bar Email already exist",
        ));
      } else {
        checkSignupUser = false;
        notifyListeners();
        navigateToUploadBarMedia();
      }
    }
    //print(checkuserResponce);
    // else{
    //   signInBar = false;
    //   notifyListeners();
    //   var signupResponce = await signupBar.SignUpBar(
    //     signUpBarUserController.text,
    //     signUpBarAddressController.text,
    //     signUpBarEmailController.text,
    //     signUpBarPasswordController.text,
    //     signUpBarVerifyPasswordController.text,
    //   );
    //   print(signupResponce);
    //   if(signupResponce is BarModel)
    //   {
    //     await locator<PrefrencesViewModel>().saveBarUser(signupResponce);
    //   }
    //   // DialogUtils().showDialog(s
    //   //     MyErrorWidget(error: signupResponce));
    //   navigateToUploadBarMedia();
    // }
  }

  createAccount() async {

    if (selectedWeekDays.length == 0) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select a week day please",
      ));
      return;
    } else if (openingTimeFrom == "") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select week days opening time",
      ));
      return;
    } else if (openingTimeTo == "") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select week days close time",
      ));
      return;
    }
    /*else if (breakTimeFrom == "") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select week days start break time",
      ));
      return;
    }
    else if (breakTimeTo == "") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select week days end break time",
      ));
      return;
    }*/
    else if (selectedWeekendDays.length == 0) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select a weekend day please",
      ));
      return;
    } else if (weekEndOpeningTimeFrom == "") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select weekend days opening time",
      ));
      return;
    } else if (weekEndOpeningTimeTo == "") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select weekend days opening time",
      ));
      return;
    }
    /*else if (weekEndBreakTimeFrom == "") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select weekend days start break time",
      ));
      return;
    } */
   /* else if (weekEndBreakTimeTo == "") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select weekend days end break time",
      ));
      return;
    }*/
    else if (selectedBarKind.length == 0) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select a bar kind",
      ));
      return;
    } else {
      signInBar = true;
      notifyListeners();
      var barKindList = CommonFunctions.AddFromList(selectedBarKind);
      //var barKindList = CommonFunctions();
      var workingDaysList = selectedWeekDays;
      var weekendDaysList = selectedWeekendDays;
      var response = await signupBar.SignUpBar(
        signUpBarUserController.text.replaceAll(' ', ''),
        signUpBarUserController.text,
        signUpBarEmailController.text,
        signUpBarAboutController.text,
        signUpBarAddressController.text,
        2,
        barKindList,
        workingDaysList,
        openingTimeFrom!,
        openingTimeTo!,
        breakTimeFrom ?? "",
        breakTimeTo ?? "",
        weekendDaysList,
        weekEndOpeningTimeFrom!,
        weekEndOpeningTimeTo!,
        weekEndBreakTimeFrom ?? "",
        weekEndBreakTimeTo ?? "",
        imageFiles[0] as File,
        imageFiles[1] as File,
        imageFiles[2] as File,
        imageFiles[3] as File,
        imageFiles[4] as File,
        imageFiles[5] as File,
        true,
        true,
        signUpBarPasswordController.text,
        signUpBarPasswordController.text,
        double.parse(latitude.toStringAsFixed(5)),
        double.parse(longitude.toStringAsFixed(5)),
      );
      signInBar = false;
      notifyListeners();
      print(response);
      if (response is NewBarModel) {
        await prefrencesViewModel.saveBarUser(response);
        navigateToHomeBarScreen();
      }
    }
  }

  getBarPost() async {
    var getNewsfeed = await createBarPost.GetPost();
    print(getNewsfeed);
  }

  createBarPostScreen() async {
    if (barPostLocationController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Post Location is required",
      ));
      return;
    } else if (barPostController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Kindly write post",
      ));
      return;
    } else {
      var createPostResponce = await createBarPost.CreatePost(

        (msgTypeList.indexOf(msgTypeValueStr) + 1).toString(),
        barPostLocationController.text,
        barPostController.text,
        imageFilesPost,
      );
      print(createPostResponce);
      navigateToHomeBarScreen();
      if (createPostResponce is CreateBarPost) {
        channel = pubnub!.channel(createPostResponce.id!.toString());
        navigateToHomeBarScreen();
      }
      // subscription = pubnub!.subscribe(channels: {});
      // channel = pubnub!.channel();

      // if(checkuserResponce is UserModel)
      // {
      //   checkSignupUser = false;
      //   notifyListeners();
      //   DialogUtils().showDialog(MyErrorWidget(
      //     error: "Bar Email already exist",
      //   ));
      // }
      // else{
      //   checkSignupUser = false;
      //   notifyListeners();
      //   navigateToUploadBarMedia();
      // }
    }
    //print(checkuserResponce);
    // else{
    //   signInBar = false;
    //   notifyListeners();
    //   var signupResponce = await signupBar.SignUpBar(
    //     signUpBarUserController.text,
    //     signUpBarAddressController.text,
    //     signUpBarEmailController.text,
    //     signUpBarPasswordController.text,
    //     signUpBarVerifyPasswordController.text,
    //   );
    //   print(signupResponce);
    //   if(signupResponce is BarModel)
    //   {
    //     await locator<PrefrencesViewModel>().saveBarUser(signupResponce);
    //   }
    //   // DialogUtils().showDialog(s
    //   //     MyErrorWidget(error: signupResponce));
    //   navigateToUploadBarMedia();
    // }
  }

  addingBar(BuildContext context) async {
    //UserModel? user = await locator<PrefrencesViewModel>().getUser();
    if(addCustomBarController.text.isNotEmpty){
      var response = await addBarKind.addKindOfBar(addCustomBarController.text);
      if(response is BarKindModel){
        barKindList.add(response.name!);
        notifyListeners();
        Navigator.pop(context);
      }
      else{
        Navigator.pop(context);
        DialogUtils().showDialog(MyErrorWidget(
          error: "Something went wrong",
        ));
      }
    }
  }

  // void doGoogleSignIn() async{
  //   loading = true;
  //   notifyListeners();
  //   //notifyListeners();
  //   try {
  //     var result =  await _googleSignIn.signIn().catchError((error){
  //       print(error);Bar
  //     });
  //     print(result);
  //     Dio dio = Dio();
  //     // value.additionalUserInfo.profile['email'].toString().split('@')[0]
  //     try{
  //       var response = await dio.post(Constants.BaseUrlPro+Constants.Login, data: param: {
  //         "Email" : result!.email,
  //         "UserName" : result!.email.toString().split('@')[0]
  //       });
  //       if (response.statusCode==200){
  //         var data = response.data;
  //         if (data["status"]==200)
  //         {
  //           var responses = await dio.post(Constants.kSocialSignUp,data: {
  //             "FullName" : result!.displayName,
  //             "Email" : result!.email,
  //             "UserName" : result!.email.toString().split('@')[0]
  //           });
  //           if (responses.statusCode==200)
  //           {
  //             var datas = responses.data;
  //
  //             if (datas["status"]==200){
  //               socialLogin = true;
  //               await _googleSignIn.signOut();
  //               isGuest = false;
  //               userDetails = UserModel.fromJson(responses.data["data"]);
  //               userID = userDetails!.userId!;
  //               userEmail = userDetails!.email!;
  //               userName = userDetails!.username!;
  //               name = userDetails!.name!;
  //               password = userDetails!.password ?? "";
  //               profileImage = userDetails!.ProfileImage ?? "";
  //               createdDtm = userDetails!.createdDtm!;
  //               notifications = userDetails!.notifications ?? "false";
  //               distanceInKm = userDetails!.nearby_radius!.isEmpty?"10 km":userDetails!.nearby_radius!+ " km" ;
  //               notificationDistanceInKm = userDetails!.notification_radius!.isEmpty ? "5 km" : userDetails!.notification_radius! +" km";
  //               //getUserData();
  //               //String? userId = userDetails!.userId;
  //               String signupEmail = responses.data["data"]['email'];
  //               SharedPreferences prefs = await SharedPreferences.getInstance();
  //               prefs.setString('userId', userDetails!.userId!);
  //               prefs.setString('userName', userDetails!.username!);
  //               prefs.setString('email', signupEmail);
  //               prefs.setString('name', userDetails!.name!);
  //               prefs.setString('password', userDetails!.password??"");
  //               prefs.setString('profileImage', userDetails!.ProfileImage??"");
  //               prefs.setString('createdDtm', userDetails!.createdDtm??"");
  //               prefs.setBool('socialLogin', socialLogin);
  //               prefs.setString('firstTime', "true");
  //               prefs.setString('notifications', notifications);
  //               prefs.setString('nearByRadius', userDetails!.nearby_radius!.isEmpty ? distanceInKm : userDetails!.nearby_radius!+" km");
  //               prefs.setString('notificationRadius', userDetails!.notification_radius!.isEmpty ? notificationDistanceInKm : userDetails!.notification_radius!+" km");
  //               languageSelected = prefs.getInt('languageSelected');
  //               profileNameController.text = userDetails!.name!;
  //               profileEmailController.text = signupEmail;
  //               //profilePasswordController.text = userDetails!.password ?? "";
  //               //prefs.setString('signUpEmail', signUpEmailController.text);
  //               loading = false;
  //               //imageUrl = r['data']['ProfileImage'];
  //               notifyListeners();
  //               sendSignUpDetails();
  //               if (onModelReadyCalled){
  //                 getNotifications();
  //                 getCurrentLocation();
  //                 //model.getNearByNotificationPlace();
  //                 //model.saveNearByAndNotificationRange();
  //                 getAllCities();
  //                 //model.saveNearByAndNotificationRange();
  //                 gettingAllPosts();
  //                 getPostCountryList();
  //                 getSearchedPost();
  //                 initializeFlutterNotifications();
  //               }
  //               navigateToHomeScreens();
  //             }
  //             else {
  //               await _googleSignIn.signOut();
  //               showErrorMessage(data["message"]);
  //               loading = false;
  //               notifyListeners();
  //             }
  //           }
  //           else {
  //             await _googleSignIn.signOut();
  //             showErrorMessage(signupFailedTryAgain);
  //             loading = false;
  //             notifyListeners();
  //           }
  //         }
  //         else {
  //           try{
  //             //loading = true;
  //             //notifyListeners();
  //             var url = Uri.parse(Constants.kSocialSignIn);
  //             var response = await http.post(url, body: {
  //               'Email': result!.email,
  //             });
  //
  //             if (response.statusCode==200)
  //             {
  //               var r = jsonDecode(response.body);
  //               if (r ["status"]==200)
  //               {
  //                 socialLogin = true;
  //                 //Map getDetails = r["data"];
  //                 await _googleSignIn.signOut();
  //                 isGuest = false;
  //                 userDetails = UserModel.fromJson(r["data"]);
  //                 userID = userDetails!.userId!;
  //                 userEmail = userDetails!.email!;
  //                 userName = userDetails!.username??"";
  //                 name = userDetails!.name!;
  //                 password = userDetails!.password ?? "";
  //                 profileImage = userDetails!.ProfileImage ?? "";
  //                 createdDtm = userDetails!.createdDtm!;
  //                 distanceInKm = userDetails!.nearby_radius!.isEmpty?"10 km":userDetails!.nearby_radius!+ " km" ;
  //                 notificationDistanceInKm = userDetails!.notification_radius!.isEmpty ? "5 km" : userDetails!.notification_radius! +" km";
  //                 notifications = userDetails!.notifications ?? "false";
  //
  //                 //getUserData();
  //                 //String? userId = userDetails!.userId;
  //                 String loginEmail = r['data']['email'];
  //                 SharedPreferences prefs = await SharedPreferences.getInstance();
  //                 prefs.setString('userId', userDetails!.userId!);
  //                 prefs.setString('userName', userName!);
  //                 prefs.setString('email', loginEmail);
  //                 prefs.setString('name', userDetails!.name!);
  //                 prefs.setString('password', userDetails!.password??"");
  //                 prefs.setString('profileImage', userDetails!.ProfileImage??"");
  //                 prefs.setString('createdDtm', userDetails!.createdDtm!);
  //                 prefs.setBool('socialLogin', socialLogin);
  //                 prefs.setString('nearByRadius', userDetails!.nearby_radius!.isEmpty ? distanceInKm : userDetails!.nearby_radius!+" km");
  //                 prefs.setString('notificationRadius', userDetails!.notification_radius!.isEmpty ? notificationDistanceInKm : userDetails!.notification_radius!+" km");
  //                 prefs.setString('firstTime', "true");
  //                 prefs.setString('notifications', notifications);
  //                 languageSelected = prefs.getInt('languageSelected');
  //                 profileNameController.text = userDetails!.name!;
  //                 profileEmailController.text = loginEmail;
  //                 languageSelected = prefs.getInt('languageSelected');
  //                 //profilePasswordController.text = userDetails!.password ?? "";
  //                 //prefs.setString("saveModel", userDetails.toString());
  //                 //prefs.setBool("isLoggedIn", true);
  //                 //await saveUser(response);
  //                 loading = false;
  //                 //imageUrl = r['data']['ProfileImage'];
  //                 notifyListeners();
  //                 getUserDataOnSignIn();
  //                 if (onModelReadyCalled){
  //                   getNotifications();
  //                   getCurrentLocation();
  //                   //model.getNearByNotificationPlace();
  //                   //model.saveNearByAndNotificationRange();
  //                   getAllCities();
  //                   //model.saveNearByAndNotificationRange();
  //                   gettingAllPosts();
  //                   getPostCountryList();
  //                   getSearchedPost();
  //                   initializeFlutterNotifications();
  //                 }
  //                 navigateToHomeScreens();
  //                 //notifyListeners();
  //               }
  //               else {
  //                 await _googleSignIn.signOut();
  //                 showErrorMessage(r["message"]);
  //                 loading = false;
  //                 notifyListeners();
  //               }
  //             }
  //             else{
  //               await _googleSignIn.signOut();
  //               showErrorMessage(loginFailedTryAgain);
  //               loading = false;
  //               notifyListeners();
  //             }
  //             notifyListeners();
  //           }
  //           catch(e){
  //             await _googleSignIn.signOut();
  //             print(e);
  //           }
  //         }
  //       }
  //       else {
  //         await _googleSignIn.signOut();
  //         showErrorMessage(signupFailedTryAgain);
  //         loading = false;
  //         notifyListeners();
  //       }
  //     }
  //     catch (error){
  //       await _googleSignIn.signOut();
  //       showErrorMessage(signupFailedTryAgain);
  //       loading = false;
  //       notifyListeners();
  //     }
  //
  //
  //   } catch (error) {
  //     isSigningIn = false;
  //     await _googleSignIn.signOut();
  //     notifyListeners();
  //     print(error);
  //   }
  // }

  void navigateAndRemoveSignInScreen() {
    navigationService.navigateAndRemoveSignInScreen();
  }

  void navigateToFollowersListScreen() {
    navigationService.navigateToFollowersListScreen();
  }

  ///------User Drawer -----/////
  void navigateToRatingList() {
    navigationService.navigateToRatingList();
  }

  void navigateToMatchedList() {
    navigationService.navigateToMatchedList();
  }

  void navigateToFollowerList() {
    navigationService.navigateToFollowerList();
  }

  void navigateToListOfBar() {
    navigationService.navigateToListOfBar();
  }

  void navigateToTermsScreen() {
    navigationService.navigateToTermsScreen();
  }

  void navigateToBarProfile() {
    navigationService.navigateToBarProfile();
  }

  void navigateToUserBarCodeScanner() {
    navigationService.navigateToUserBarCodeScanner();
  }

  void navigateToUpcomingEvent() {
    navigationService.navigateToUpcomingEvent();
  }

  void navigateToMessageScreen() {
    navigationService.navigateToMessageScreen();
  }

  void navigateToSelectIndividualChatScreen() {
    navigationService.navigateToSelectIndividualChatScreen();
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

  void navigateToNotificationScreen() {
    navigationService.navigateToNotificationScreen();
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

  void navigateToMediaScreen() {
    navigationService.navigateToMediaScreen();
  }

  void navigateBack() {
    navigationService.navigateBack();
  }

  void navigateToResentPasswordScreen() {
    navigationService.navigateToResentPasswordScreen();
  }

  void navigateToStaticTermsAndConditionScreen() {
    navigationService.navigateToStaticTermsAndConditionScreen();
  }

  void navigateToChangePassword() {
    navigationService.navigateToChangePassword();
  }

  void navigateToBarAccountOwnerShip() {
    navigationService.navigateToBarAccountOwnerShip();
  }

  void navigateToUserProfileAccountOwnershipScreen() {
    navigationService.navigateToUserProfileAccountOwnershipScreen();
  }

  void navigateToUserDetailSettings() {
    navigationService.navigateToUserDetailSettings();
  }

  void navigateToBarProfileScreen() {
    navigationService.navigateToBarProfileScreen();
  }

  void navigateToBarTimingTypeScreen() {
    navigationService.navigateToBarTimingTypeScreen();
  }

  void navigateToCreateEventScreen() {
    navigationService.navigateToCreateEventScreen();
  }

  void navigateToBarPostScreen() {
    navigationService.navigateToBarPostScreen();
  }

  void navigateToBarProfile2() {
    navigationService.navigateToBarProfile2();
  }

  void navigateToMapSearchScreen() {
    navigationService.navigateToMapSearchScreen();
  }

  void navigateToAddAddressScreen() {
    navigationService.navigateToAddAddressScreen();
  }

  void navigateToAddAddressBarScreen() {
    navigationService.navigateToAddAddressBarScreen();
  }
}
