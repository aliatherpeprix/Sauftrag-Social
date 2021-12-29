import 'dart:async';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import 'package:sauftrag/utils/image_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

class MainViewModel extends BaseViewModel{
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  Completer<GoogleMapController> controller = Completer();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  bool logInUserSelected = true;
  bool logInBarSelected = false;
  var navigationService = navigationViewModel;
  late SharedPreferences prefs;
  List<Marker> markers = <Marker>[];
  final mapSearchController = TextEditingController();
  final searchScreenController = TextEditingController();
  final friendListSearchController = TextEditingController();
  bool openGroupMenu = false;
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
  final messageScreenChatController = TextEditingController();
  bool userNewsFeed = false;


  double lowerValue = 50;
  double upperValue = 180;
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

  List<bool>? selected;
  bool? selectedValue;
  int? currentIndex;
  List groupList = [];
  Map<dynamic,dynamic> groupMap = {};

  int drinkMotivationValue = 1;
  String drinkMotivationValueStr = "Drink light";
  List<String> drinkMotivationList = ["Drink light", "Drink normal", "Drink hard"];
  Map<String, int> drinkMotivationMap = {
    'Drink light': 1,
    'Drink normal': 2,
    'Drink hard': 3,
  };

  int drinkIndex = -1;
  List<int> drinkIndexList = [];

  List<String> favoriteAlcoholicDrink = ["White Wine", "Hard Seltzer", "Whiskey", "Jägermeister", "Champagne",];

  List<String> favoriteNightClub = ["Club 1", "Club 6", "Club 8"];

  List<String> favoritePartyVacation = ["Goldstrand", "Zrce Beach", "Springbreak Cancun",];

  Future<bool> openCamera() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    _pickedFile = image;
    if(_pickedFile != null){
      profileFileImage = File(_pickedFile!.path);
    }
    if (profileFileImage==null)
    {
      return false;
    }
    else{
      notifyListeners();
      return true;
    }
  }



  int msgTypeValue = 1;
  String msgTypeValueStr = "Private";
  List<String> msgTypeList = ["Private", "Public"];
  Map<String, int> msgTypeMap = {
    'Private': 1,
    'Public': 2,
  };


  Future<bool> getImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    _pickedFile = image;
    if(_pickedFile != null){
      profileFileImage = File(_pickedFile!.path);
    }
    if (profileFileImage==null)
    {
      return false;
    }
    else{
      notifyListeners();
      return true;
    }
  }

  messageEmojiSelected(Emoji emoji) {
    messageScreenChatController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageScreenChatController.text.length));
  }

  messageScreenBackspacePressed() {
    messageScreenChatController
      ..text = messageScreenChatController.text.characters.skipLast(1).toString()
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

  addMarkers(){
    markers.add(
        Marker(
            markerId: MarkerId('SomeId'),
            position: LatLng(24.8169,67.1118),
            infoWindow: InfoWindow(
                title: 'The title of the marker'
            )
        )
    );
  }

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(24.8169, 67.1118),
    zoom: 14.4746,
  );

  List<String> weekDaysList = ["Su" , "Mo" , "Tu", "We" , "Th", "Fr" , "Sa"];

  List placed = [];

  List places = [
    {
      'image': ImageUtils.place_1,
      'eventName': 'Trivia Nights',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1' : ImageUtils.location_icon
    },
    {
      'image': ImageUtils.place_2,
      'eventName': 'Bar Crawl Stop',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1' : ImageUtils.location_icon
    },
    {
      'image': ImageUtils.place_3,
      'eventName': 'Singles Night',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'image1' : ImageUtils.location_icon
    },
    {
      'image': ImageUtils.place_4,
      'eventName': 'Bar Olympics',
      'date': '1st  May- Sat -2:00 PM',
      'location': ' Lot 13 • Oakland, CA',
      'image1' : ImageUtils.location_icon
    },
  ];

  List ratingListed = [];
  List ratingList = [
    {
      'rank': '#4',
      'image': ImageUtils.johnImg,
      'title': 'John Milton',
      'points': '240',
      'image1' : ImageUtils.coinImg
    },
    {
      'rank': '#5',
      'image': ImageUtils.mutualfrnd1,
      'title': 'Riki Davon',
      'points': '240',
      'image1' : ImageUtils.coinImg
    },
    {
      'rank': '#6',
      'image': ImageUtils.followerImg1,
      'title': 'Josefina Ward',
      'points': '240',
      'image1' : ImageUtils.coinImg
    },
    {
      'rank': '#7',
      'image': ImageUtils.mutualfrnd2,
      'title': 'Andre Patterson',
      'points': '240',
      'image1' : ImageUtils.coinImg
    },
    {
      'rank': '#8',
      'image': ImageUtils.followerImg2,
      'title': 'Hazel Ballard',
      'points': '240',
      'image1' : ImageUtils.coinImg
    },
    {
      'rank': '#9',
      'image': ImageUtils.mutualfrnd3,
      'title': 'Nettie Parsons',
      'points': '240',
      'image1' : ImageUtils.coinImg
    },
    {
      'rank': '#10',
      'image': ImageUtils.followerImg3,
      'title': 'Hazel Ballard',
      'points': '240',
      'image1' : ImageUtils.coinImg
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

  void addRemoveDrink(int index){

    drinkIndex = index + 1;
    //drinkIndexList.length = index + 1;
    notifyListeners();

    //drinkIndex = index + 1;
    //notifyListeners();
  }

  void navigateToProfileScreen(List<String> images){
    navigationService.navigateToProfileScreen(images);
  }

  void navigateToMatchScreen(){
    navigationService.navigateToMatchScreen();
  }

  void navigateBack(){
    navigationService.navigateBack();
  }

  void navigateToGroupDetails(){
    navigationService.navigateToGroupDetail();
  }

  void navigateToGroupScreen(){
    navigationService.navigateToGroupScreen();
  }

  void navigateToUserProfileAccountScreen(){
    navigationService.navigateToUserProfileAccountScreen();
  }

  void navigateToUserProfileAccountOwnershipScreen(){
    navigationService.navigateToUserProfileAccountOwnershipScreen();
  }

  void navigateToUserProfileAccountNotificationScreen(){
    navigationService.navigateToUserProfileAccountNotificationScreen();
  }

  void navigateToUserProfileAccountLegalTermScreen(){
    navigationService.navigateToUserProfileAccountLegalTermScreen();
  }

  void navigateToUserProfileAccountGpsScreen(){
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
  void navigateToBarProfile2() {
    navigationService.navigateToBarProfile2();
  }

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









/*AnimationController? buttonController;
  Animation<double>? rotate;
  Animation<double>? right;
  Animation<double>? bottom;
  Animation<double>? width;
  double backCardWidth = -10.0;
  int flag = 0;

  List data = [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl1];
  List selectedData = [];

  void initSwipe() {

    rotate = Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Curves.ease,
      ),
    );
    rotate!.addListener(() {
      if (rotate!.isCompleted) {
        var i = data.removeLast();
        data.insert(0, i);
        buttonController!.reset();
      }
      notifyListeners();
    });

    right = Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Curves.ease,
      ),
    );
    bottom = Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Curves.ease,
      ),
    );
    width = Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Curves.bounceOut,
      ),
    );
  }

  Future<Null> swipeAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  dismissImg(String img) {
    data.remove(img);
    notifyListeners();
  }

  addImg(String img) {
    data.remove(img);
    selectedData.add(img);
    notifyListeners();
  }

  swipeRight() {
    if (flag == 0){
      flag = 1;
    }
    notifyListeners();
    swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1){
      flag = 0;
    }
    notifyListeners();
    swipeAnimation();
  }*/

}