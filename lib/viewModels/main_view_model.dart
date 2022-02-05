import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_event_model.dart';
import 'package:sauftrag/models/create_bar_post.dart';
import 'package:sauftrag/models/faqs_questions.dart';
import 'package:sauftrag/models/followers.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/newsfeed_post_id.dart';
import 'package:sauftrag/models/rating_data.dart';
import 'package:sauftrag/models/ratings.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/services/createPost.dart';
import 'package:sauftrag/services/dataProtection.dart';
import 'package:sauftrag/services/faqs.dart';

import 'package:sauftrag/services/privacyPolicy.dart';
import 'package:sauftrag/services/termsAndCondition.dart';
import 'package:sauftrag/services/updateUserProfile.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';

import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/UserProfile/terms_condition.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

class MainViewModel extends BaseViewModel {

  var updateUser = Updateuser();
  var createBarPost = Createpost();
  var privacyPolicy = Privacypolicy();
  var termCondition = Termscondition();
  var dataProtection = Dataprotection();
  var faqList = Faqs();

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  Completer<GoogleMapController> controller = Completer();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  UserModel? userModel;


  bool logInUserSelected = true;
  bool logInBarSelected = false;
  var navigationService = navigationViewModel;
  late SharedPreferences prefs;
  List<Marker> markers = <Marker>[];
  final mapSearchController = TextEditingController();
  final searchScreenController = TextEditingController();
  final friendListSearchController = TextEditingController();
  bool openGroupMenu = false;
  bool openBurgerMenu = false;
  bool privateGroupSelected = false;
  bool publicGroupSelected = false;
  bool deleteSelected = false;
  bool deleteUnselected = false;
  XFile? _pickedFile;
  File? profileFileImage;
  bool emojiShowing = false;
  bool emojiSelected = false;
  final chatController = TextEditingController();
  bool groupScreenEmojiShowing = false;
  bool groupScreenEmojiSelected = false;
  final groupScreenChatController = TextEditingController();
  final myContactsSearchController = TextEditingController();
  bool myContactEmojiShowing = false;
  bool myContactEmojiSelected = false;
  final myContactsChatController = TextEditingController();
  bool eventSelected = false;
  int? currentEventSelected;
  bool timeSelected = false;
  int? timeValue;
  double sliderValue = 0.0;
  String? lowValue = "50";
  String? highValue = "180";
  bool bottomSheetSelected = false;
  bool messageScreenEmojiShowing = false;
  bool messageScreenEmojiSelected = false;
  List<UserModel> alcoholDrinks = [];
  final messageScreenChatController = TextEditingController();
  bool userNewsFeed = false;
  bool favDrink = false;
  bool favClub = false;
  bool favVacation = false;
  bool editProfile = false;
  bool isPrivacyPolicy = false;
  bool isTermsCondition = false;
  bool isDataProtection = false;
  bool isFaqs = false;
  bool isPost = false;
  bool isUserProfile = false;

  var dio = Dio();

  final addDrinkController = TextEditingController();
  bool isAddDrinkInFocus = false;
  FocusNode addDrinkFocus = new FocusNode();

  final addClubController = TextEditingController();
  bool isAddClubInFocus = false;
  FocusNode addClubFocus = new FocusNode();

  final addVacationController = TextEditingController();
  bool isddVacationInFocus = false;
  FocusNode addVacationFocus = new FocusNode();

  PrefrencesViewModel prefrencesViewModel = locator<PrefrencesViewModel>();
  double lowerValue = 50;
  double upperValue = 180;

  List<FaqsModel> faqs = [];
  List<NewsfeedPostId> posts = [];
  String? privacy;
  String? termsAndCondition;
  String? protection;
  //String? faqs;

  List contactChecked = [
    {
      'name': "Athalia Putri",
      'image': ImageUtils.messagePerson1,
    },
    {
      'name': "Erlan Sadewa",
      'image': ImageUtils.messagePerson2,
    },
    {
      'name': "Raki Devon",
      'image': ImageUtils.messagePerson3,
    },
    {
      'name': "Blanca Hernandez",
      'image': ImageUtils.messagePerson4,
    },
    {
      'name': "Glen Romero",
      'image': ImageUtils.messagePerson5,
    },
    {
      'name': "Joe Floyd",
      'image': ImageUtils.messagePerson6,
    },
    {
      'name': "Carroll Cooper",
      'image': ImageUtils.messagePerson7,
    },
    {
      'name': "Sidney Alvarado",
      'image': ImageUtils.messagePerson8,
    },
  ];

  File imageFile = File('my initial file');
  List<dynamic> imageFiles = [
    File(""),
    File(""),
    File(""),
    File(""),
    File(""),
    File("")
  ];

  List<bool>? selected;
  bool? selectedValue;
  int? currentIndex;
  List groupList = [];
  Map<dynamic, dynamic> groupMap = {};

  int drinkMotivationValue = 1;
  String drinkMotivationValueStr = "Drink light";
  List<String> drinkMotivationList = [
    "Drink light",
    "Drink normal",
    "Drink hard"
  ];
  Map<String, int> drinkMotivationMap = {
    'Drink light': 1,
    'Drink normal': 2,
    'Drink hard': 3,
  };

  int drinkIndex = -1;
  List<int> drinkIndexList = [];

  List<String> favoriteAlcoholicDrink = [
    "White Wine",
    "Hard Seltzer",
    "Whiskey",
    "Jägermeister",
    "Champagne",
  ];

  List<String> favoriteNightClub = ["Club 1", "Club 6", "Club 8"];

  List<String> favoritePartyVacation = [
    "Goldstrand",
    "Zrce Beach",
    "Springbreak Cancun",
  ];

  FaqsModel? selectedFaq;


  Future<bool> openCamera() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    _pickedFile = image;
    if (_pickedFile != null) {
      profileFileImage = File(_pickedFile!.path);
    }
    if (profileFileImage == null) {
      return false;
    } else {

      notifyListeners();
      return true;
    }
  }

  Future favoritesDrinks(List selectedList, String favorite) async {
    if (selectedList.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Select at least one favorites",
      ));
      notifyListeners();
      return;
    } else {
      favDrink = true;
      notifyListeners();

      var userSignupResponce =
          await updateUser.UpdateUserFavorites(selectedList, favorite);
      print(userSignupResponce);
      if (userSignupResponce is UserModel) {
        UserModel user = userSignupResponce;
        user.favorite_alcohol_drinks =
            CommonFunctions.SubtractFromList(user.favorite_alcohol_drinks!);
        user.favorite_night_club =
            CommonFunctions.SubtractFromList(user.favorite_night_club!);
        user.favorite_party_vacation =
            CommonFunctions.SubtractFromList(user.favorite_party_vacation!);
        // if (favorite=="favorite_alcohol_drinks"){
        //
        // }
        // if (favorite=="favorite_night_club"){
        //
        // }
        // if (favorite=="favorite_party_vacation"){
        //
        // }
        user.token = userModel!.token!;
        userModel = user;
        await prefrencesViewModel.saveUser(user);
      }
      favDrink = false;
      notifyListeners();

      selectedDrinkList.clear();
      selectedClubList.clear();
      selectedVacationList.clear();

      // imageFiles = [
      //   "",
      //   "",
      //   "",
      //   "",
      //   "",
      //   ""
      // ];
      //model.imageFiles = [];
      //dataCheck = false;
      //signInUser = false;
      notifyListeners();
      // DialogUtils().showDialog(
      //     MyErrorWidget(error: "Use has been created succ"));
      //navigateToHomeScreen(2);
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


  int msgTypeValue = 1;
  String msgTypeValueStr = "Private";
  List<String> msgTypeList = ["Private", "Public"];
  Map<String, int> msgTypeMap = {
    'Private': 1,
    'Public': 2,
  };

  Future<bool> getImage1(BuildContext context, int type) async {
    ImagePicker picker = ImagePicker();
    var image;

    if (type == Constants.camera) {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }

    _pickedFile = image;
    //profileFileImage = File(_pickedFile!.path);
    if (_pickedFile!.path.isEmpty) {
      return false;
    } else {
      cropImage(context, _pickedFile!.path);
      return true;
    }
  }

  Future<Null> cropImage(BuildContext context, String path) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.png,
        //compressQuality: 50,
        maxWidth: 500,
        maxHeight: 500,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'S',
            toolbarColor: ColorUtils.red_color,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'SaufTrag',
        ));
    if (croppedFile != null) {
      profileFileImage = croppedFile;
      notifyListeners();
      //
      // var imageParams = FormData.fromMap({
      //   'profile_image': profileFileImage != null ? await MultipartFile.fromFile(profileFileImage!.path,filename: basename(profileFileImage!.path)) : "",
      // });

      // var imageResponse = await dio.post("${ApiClient.editProfileImage}/${userData!.id}", data: imageParams);
      //
      // if (imageResponse.statusCode == 200 && imageResponse.data["status"] == true) {
      //
      //   showSuccessMessage(context, "Profile image updated successfully");
      //   notifyListeners();
      // }
      // else {
      //   notifyListeners();
      //   showErrorMessage(context, imageResponse.data["message"]);
      // }

    }
  }

  Future<bool> getImage2(BuildContext context, String path) async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    _pickedFile = image;
    if (_pickedFile != null) {
      profileFileImage = File(_pickedFile!.path);
    }
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

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

  Future<bool> getImagE() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    _pickedFile = image;
    if (_pickedFile != null) {
      profileFileImage = File(_pickedFile!.path);
    }
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

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

  int genderValue = 1;
  String genderValueStr = "Male";
  List<String> genderList = ["Male", "Female"];
  Map<String, int> genderMap = {
    'Male': 1,
    'Female': 2,
  };

  Future<bool> getImage0(int index) async {
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

  messageEmojiSelected(Emoji emoji) {
    messageScreenChatController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageScreenChatController.text.length));
  }

  messageScreenBackspacePressed() {
    messageScreenChatController
      ..text =
          messageScreenChatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageScreenChatController.text.length));
  }

  myContactOnEmojiSelected(Emoji groupEmoji) {
    myContactsChatController
      ..text += groupEmoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: myContactsChatController.text.length));
  }

  myContactOnBackspacePressed() {
    myContactsChatController
      ..text = myContactsChatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: myContactsChatController.text.length));
  }

  groupScreenOnEmojiSelected(Emoji groupEmoji) {
    groupScreenChatController
      ..text += groupEmoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: groupScreenChatController.text.length));
  }

  groupScreenOnBackspacePressed() {
    groupScreenChatController
      ..text = groupScreenChatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: groupScreenChatController.text.length));
  }

  onEmojiSelected(Emoji emoji) {
    chatController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatController.text.length));
  }

  onBackspacePressed() {
    chatController
      ..text = chatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatController.text.length));
  }

  addMarkers() {
    markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(24.8169, 67.1118),
        infoWindow: InfoWindow(title: 'The title of the marker')));

  }

  List<dynamic> drinkList = [
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

  List<dynamic> selectedDrinkList = [];

  List<dynamic> clubList = [
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
  List<dynamic> selectedClubList = [];

  List<dynamic> vacationList = [
    "Ballermann",
    "Goldstrand",
    "Zrce Beach",
    "Lloret",
    "Ibiza",
    "Springbreak Cancun"
  ];

  List<dynamic> selectedVacationList = [];

  List<String> interestList = [
    "White Wine",
    "Hard Seltzer",
    "Whiskey",
    "Club 1",
    "Club 2",
    "Goldstrand",
  ];

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(24.8169, 67.1118),
    zoom: 14.4746,
  );

  List<String> weekDaysList = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

  List placed = [];

  List places = [
    {
      'image': ImageUtils.place_1,
      'eventName': 'Trivia Nights',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1': ImageUtils.location_icon
    },
    {
      'image': ImageUtils.place_2,
      'eventName': 'Bar Crawl Stop',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1': ImageUtils.location_icon
    },
    {
      'image': ImageUtils.place_3,
      'eventName': 'Singles Night',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1': ImageUtils.location_icon
    },
    {
      'image': ImageUtils.place_4,
      'eventName': 'Bar Olympics',
      'date': '1st  May- Sat -2:00 PM',
      'location': ' Lot 13 • Oakland, CA',
      'image1': ImageUtils.location_icon
    },
  ];

  List ratingListed = [];
  List ratingList = [
    {
      'rank': '#4',
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'points': '240',
      'image1': ImageUtils.coinImg
    },
    {
      'rank': '#5',
      'image': ImageUtils.mutualfrnd1,
      'title': 'Riki Davon',
      'points': '240',
      'image1': ImageUtils.coinImg
    },
    {
      'rank': '#6',
      'image': ImageUtils.followerImg1,
      'title': 'Josefina Ward',
      'points': '240',
      'image1': ImageUtils.coinImg
    },
    {
      'rank': '#7',
      'image': ImageUtils.mutualfrnd2,
      'title': 'Andre Patterson',
      'points': '240',
      'image1': ImageUtils.coinImg
    },
    {
      'rank': '#8',
      'image': ImageUtils.followerImg2,
      'title': 'Hazel Ballard',
      'points': '240',
      'image1': ImageUtils.coinImg
    },
    {
      'rank': '#9',
      'image': ImageUtils.mutualfrnd3,
      'title': 'Nettie Parsons',
      'points': '240',
      'image1': ImageUtils.coinImg
    },
    {
      'rank': '#10',
      'image': ImageUtils.followerImg3,
      'title': 'Hazel Ballard',
      'points': '240',
      'image1': ImageUtils.coinImg
    },
  ];

  List notifications = [
    {
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'para': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '1h ago',
    },
    {
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'para': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '1h ago',
    },
    {
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'para': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '1h ago',
    },
    {
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'para': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '1h ago',
    },
    {
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'para': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '1h ago',
    },
    {
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'para': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '1h ago',
    },
    {
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'para': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '1h ago',
    },
    {
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'para': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'time': '1h ago',
    },
  ];

  List ListOfBar = [
    {
      'image': ImageUtils.barImg1,
      'title': 'Beer Garden',
      'locationIcon': ImageUtils.locationPin,
      'address': '1458 Caden Valleys, 12 kms away.',
      'type': 'Disco',
    },
    {
      'image': ImageUtils.barImg2,
      'title': 'The Love Shack',
      'locationIcon': ImageUtils.locationPin,
      'address': '1458 Caden Valleys, 12 kms away.',
      'type': 'Pub',
    },
    {
      'image': ImageUtils.barImg3,
      'title': 'Stag Nite Bar',
      'locationIcon': ImageUtils.locationPin,
      'address': '1458 Caden Valleys, 12 kms away.',
      'type': 'Hotel Bar',
    },
    {
      'image': ImageUtils.barImg4,
      'title': 'New Jack Swing Bar',
      'locationIcon': ImageUtils.locationPin,
      'address': '1458 Caden Valleys, 12 kms away.',
      'type': 'Cocktail Lounge',
    },
    {
      'image': ImageUtils.barImg5,
      'title': 'Wild Rover Pub',
      'locationIcon': ImageUtils.locationPin,
      'address': '1458 Caden Valleys, 12 kms away.',
      'type': 'Karaoke Bar',
    },
    {
      'image': ImageUtils.barImg6,
      'title': 'Whistle Stop Club',
      'locationIcon': ImageUtils.locationPin,
      'address': '1458 Caden Valleys, 12 kms away.',
      'type': 'Music Bar',
    },
    {
      'image': ImageUtils.barImg7,
      'title': 'The High Five Bar',
      'locationIcon': ImageUtils.locationPin,
      'address': '1458 Caden Valleys, 12 kms away.',
      'type': 'Night Club',
    },
  ];

  void addRemoveDrink(int index) {
    drinkIndex = index + 1;
    //drinkIndexList.length = index + 1;
    notifyListeners();

    //drinkIndex = index + 1;
    //notifyListeners();
  }

  deleteAccount() async {
    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
    var response = await http
        .delete(Uri.http(Constants.BaseUrl, Constants.accountDelete), headers: {
      // 'content-type': 'application/json',
      // 'accept': 'application/json',
      'authorization': 'Token ${user!.token!}',
    });

    logOutUser();
    print(response.body);
  }

  List<FollowersList> follower = [];
  followers() async {
    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
    var response = await http.get(
        Uri.http(Constants.BaseUrl, Constants.followersList),
        headers: {'authorization': 'Token ${user!.token!}'});
    print(response.body);
    var jsonData = jsonDecode(response.body);
    follower =
        (jsonData as List).map((e) => FollowersList.fromJson(e)).toList();
    notifyListeners();
  }

  Ratings? ratingKaData;
  RatingData? forTime;
  rating() async {
    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();

    var response = await http.get(Uri.http(Constants.BaseUrl, Constants.rating),
        headers: {'authorization': 'Token ${user!.token!}'});
    var jsonData = jsonDecode(response.body);

    ratingKaData = Ratings.fromJson(jsonData);
    getTime();
  }

  String? timeZone;
  getTime() {
    var checking = ratingKaData!.data![0].created_at;
    var dateTime = DateFormat("yyyy-MM-dd")
        .parse(checking!.replaceAll('T', ' '), true);
    var dateLocal = dateTime.toLocal();
    timeZone = dateLocal.toString();
    print(dateLocal);
    return dateLocal;
  }

  void navigateToProfileScreen(List<String> images) {
    navigationService.navigateToProfileScreen(images);
  }

  void navigateToMatchScreen() {
    navigationService.navigateToMatchScreen();
  }

  void navigateBack() {
    navigationService.navigateBack();
  }

  void navigateToGroupDetails() {
    navigationService.navigateToGroupDetail();
  }

  void navigateToGroupScreen() {
    navigationService.navigateToGroupScreen();
  }

  void navigateToUserProfileAccountScreen() {
    navigationService.navigateToUserProfileAccountScreen();
  }

  void navigateToUserProfileAccountOwnershipScreen() {
    navigationService.navigateToUserProfileAccountOwnershipScreen();
  }

  void navigateToUserProfileAccountNotificationScreen() {
    navigationService.navigateToUserProfileAccountNotificationScreen();
  }

  void navigateToUserProfileAccountLegalTermScreen() {
    navigationService.navigateToUserProfileAccountLegalTermScreen();
  }

  void navigateToUserProfileAccountGpsScreen() {
    navigationService.navigateToUserProfileAccountGpsScreen();
  }

  void navigateToCreateEventScreen() {
    navigationService.navigateToCreateEventScreen();
  }

  void navigateToBarEventScreen() {
    navigationService.navigateToBarEventScreen();
  }

  void navigateToBarHomeScreen() {
    navigationService.navigateToBarHomeScreen();
  }

  void navigateToNotificationScreen() {
    navigationService.navigateToNotificationScreen();
  }

  void navigateToFollowersListScreen() {
    navigationService.navigateToFollowersListScreen();
  }

  void navigateToFriendListScreen() {
    navigationService.navigateToFriendListScreen();
  }

  void navigateToMsgCreateGroupScreen() {
    navigationService.navigateToMsgCreateGroupScreen();
  }

  void navigateToInvitePeopleScreen() {
    navigationService.navigateToInvitePeopleScreen();
  }

  void navigateToHomeBarScreen() {
    navigationService.navigateToHomeBarScreen();
  }

  void navigateAndRemoveSignInScreen() {
    navigationService.navigateAndRemoveSignInScreen();
  }

  void navigateToSwipeScreen() {
    navigationService.navigateToSwipeScreen();
  }

  void navigateToFriendListScreen1() {
    navigationService.navigateToFriendListScreen1();
  }

  void navigateToBarTimingTypeScreen() {
    navigationService.navigateToBarTimingTypeScreen();
  }

  void navigateToEventDetailsScreen() {
    navigationService.navigateToEventDetailScreen();
  }

  void navigateToMapSearchScreen() {
    navigationService.navigateToMapSearchScreen();
  }

  void navigateToUserDetailSettings() {
    navigationService.navigateToUserDetailSettings();
  }

  void navigateToUpcomingBarEventScreen() {
    navigationService.navigateToUpcomingBarEventScreen();
  }

  void navigateToAllEventListScreen() {
    navigationService.navigateToAllEventListScreen();
  }


  void navigateToDataProtectionScreen() {
    navigationService.navigateToDataProtectionScreen();
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

  ///-----------Bar Profile ---------------///

  void navigateToAllBarRating() {
    navigationService.navigateToAllBarRating();
  }

  ///--------------Bar Profile ------------------///
  void navigateToBarDetails() {
    navigationService.navigateToBarDetails();
  }

  void navigateToBarAccounts() {
    navigationService.navigateToBarAccounts();
  }

  void navigateToBarAccountOwnerShip() {
    navigationService.navigateToBarAccountOwnerShip();
  }

  void navigateToBarPostScreen() {
    navigationService.navigateToBarPostScreen();
  }

  void navigateToBarProfile2() {
    navigationService.navigateToBarProfile2();
  }


  void navigateToPrivacyAndPolicyScreen() {
    navigationService.navigateToPrivacyAndPolicyScreen();
  }

  void navigateToTermsAndConditionScreen() {
    navigationService.navigateToTermsAndConditionScreen();
  }

  void navigateToFaqScreen() {
    navigationService.navigateToFaqScreen();
  }

  void navigateToFaqAnsScreen() {
    navigationService.navigateToFaqAnsScreen();
  }

  Future saveUserDetails() async {
    List tempList = [];
    // for (int i = 0;i<imageFiles.length;i++){
    //   if (imageFiles[i] is File && (imageFiles[i] as File).path.isNotEmpty){
    //     String image = "data:${lookupMimeType(imageFiles[0].path)};base64," +
    //         base64Encode(imageFiles[0].readAsBytesSync());
    //     tempList.add(image);
    //   }
    //   else {
    //     tempList.add(imageFiles[i]);
    //   }
    // }
    editProfile = true;
    notifyListeners();
    var userUpdateResponse = await updateUser.UpdateUserProfile(
        (genderList.indexOf(genderValueStr) + 1).toString(), imageFiles);
    if (userUpdateResponse is UserModel) {
      UserModel user = userUpdateResponse;
      user.token = userModel!.token!;
      user.favorite_alcohol_drinks =
          CommonFunctions.SubtractFromList(user.favorite_alcohol_drinks!);
      user.favorite_night_club =
          CommonFunctions.SubtractFromList(user.favorite_night_club!);
      user.favorite_party_vacation =
          CommonFunctions.SubtractFromList(user.favorite_party_vacation!);
      await prefrencesViewModel.saveUser(user);
      notifyListeners();
    }
    editProfile = false;
    notifyListeners();
  }

  logOutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    navigateAndRemoveSignInScreen();
  }




  void getUserData() async {
    userModel = await prefrencesViewModel.getUser();
    notifyListeners();
  }

  getBarPost() async {
    isPost = true;
    var getNewsfeed = await  createBarPost.GetPost();
    if (getNewsfeed is List<NewsfeedPostId>){
      posts = getNewsfeed;
    }
    isPost = false;
    print(getNewsfeed);
    notifyListeners();
  }

  getPrivacyPolicy() async {
    isPrivacyPolicy = true;

    var getPrivacyPolicy = await  privacyPolicy.GetPrivacyPolicy();
    if (getPrivacyPolicy is String){
      privacy = getPrivacyPolicy;
      //isPrivacyPolicy = false;

    }
    else  {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isPrivacyPolicy = false;
    notifyListeners();
    print(getPrivacyPolicy);
  }

  getTermsCondition() async {
    isTermsCondition = true;

    var getTerms = await  termCondition.GetTermsCondition();
    if (getTerms is String){
      termsAndCondition = getTerms;
      //isPrivacyPolicy = false;

    }
    else  {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isTermsCondition = false;
    notifyListeners();
    print(getPrivacyPolicy);
  }

  getDataProtection() async {
    isDataProtection = true;

    var getDaraProtection = await  dataProtection.GetDataProtection();
    if (getDaraProtection is String){
      protection = getDaraProtection;
      //isPrivacyPolicy = false;

    }
    else  {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isDataProtection = false;
    notifyListeners();
    print(getPrivacyPolicy);
  }

  getFaqsList() async {
    isFaqs = true;


    var getFaqList = await faqList.GetFaqs();
    print(getFaqList);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }
    if (getFaqList is List<FaqsModel>){
      faqs = getFaqList;
    }
    else  {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isFaqs = false;
    notifyListeners();
    print(getFaqsList);
  }
  bool eventLoader = false;

  List<BarEventModel>? barEventModel = [];

  void getEvent(BuildContext context) async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();

    try {
      eventLoader = true;
      notifyListeners();
      var response =
      await dio.get("${Constants.GetEvents}", options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Token ${user!.token!}"
          }
      ));
      print(response);

      if (response.statusCode == 200) {
        barEventModel = (response.data as List)
            .map((e) => BarEventModel.fromJson(e))
            .toList();
        eventLoader = false;
        notifyListeners();
      } else {
        print(response.statusCode);
        eventLoader = false;
        notifyListeners();

        // showErrorMessage(context, 'Something went wrong. Please try again');
      }
    } on DioError catch (e) {
      print(e);
      eventLoader = false;
      notifyListeners();


      // if (e.response!.statusCode == 404) {
      //   navigationService.navigateToReplacement(to: NotFound());
      // } else if (e.response!.statusCode == 500) {
      //   navigationService.navigateToReplacement(to: ServerError());
      // } else {
      //   showErrorMessage(context,
      //       'Unable to process your request at this time. Please try again');
      // }
    }
  }



}
