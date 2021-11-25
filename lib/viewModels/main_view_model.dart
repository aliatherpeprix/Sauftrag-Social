import 'dart:async';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

class MainViewModel extends BaseViewModel{
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  Completer<GoogleMapController> controller = Completer();
  var navigationService = navigationViewModel;
  late SharedPreferences prefs;
  List<Marker> markers = <Marker>[];
  final mapSearchController = TextEditingController();
  final searchScreenController = TextEditingController();
  final friendListSearchController = TextEditingController();
  bool openGroupMenu = false;
  bool privateGroupSelected = false;
  bool publicGroupSelected = false;
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

  List<String> interestList = ["White Wine", "Hard Seltzer", "Whiskey", "Club 1", "Club 2", "Goldstrand"];

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