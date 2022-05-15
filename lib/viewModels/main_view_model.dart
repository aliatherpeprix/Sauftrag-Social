import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:sauftrag/bar/views/Drawer/bar_followers.dart';
import 'package:sauftrag/models/attend_event.dart';
import 'package:sauftrag/models/comments.dart';
import 'package:sauftrag/models/comments_bar.dart';
import 'package:sauftrag/models/create_group_chat.dart';
import 'package:sauftrag/models/event_attendees.dart';
import 'package:sauftrag/models/follow_bar.dart';
import 'package:sauftrag/models/get_bar_followers.dart';
import 'package:sauftrag/models/get_bar_upcoming_event.dart';
import 'package:sauftrag/models/get_comments_bar.dart';
import 'package:sauftrag/models/get_comments_user.dart';
import 'package:sauftrag/models/listOfFollowing_Bars.dart';
import 'package:sauftrag/models/report_chat.dart';
import 'package:sauftrag/models/request_match_model.dart';
import 'package:sauftrag/models/user_matched.dart';
import 'package:sauftrag/models/user_models.dart' as userModel;
import 'package:mime/mime.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pubnub/core.dart';
import 'package:pubnub/pubnub.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/address_book.dart';
import 'package:sauftrag/models/all_user_for_chat.dart';
import 'package:sauftrag/models/bar_event_model.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/create_bar_post.dart';
import 'package:sauftrag/models/discover.dart';
import 'package:sauftrag/models/faqs_questions.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/models/followers.dart';
import 'package:sauftrag/models/get_drink_status.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/newsfeed_post_id.dart';
import 'package:sauftrag/models/pubnub_channel.dart';
import 'package:sauftrag/models/rating_data.dart';
import 'package:sauftrag/models/ratings.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/services/addBar.dart';
import 'package:sauftrag/services/addFavorites.dart';
import 'package:sauftrag/services/addressBook.dart';
import 'package:sauftrag/services/allBars.dart';
import 'package:sauftrag/services/attend_event.dart';
import 'package:sauftrag/services/barQRcode.dart';
import 'package:sauftrag/services/bar_filters.dart';
import 'package:sauftrag/services/bar_order.dart';
import 'package:sauftrag/services/createGroup.dart';
import 'package:sauftrag/services/createPost.dart';
import 'package:sauftrag/services/dataProtection.dart';
import 'package:sauftrag/services/drinksOrder.dart';
import 'package:sauftrag/services/faqs.dart';
import 'package:sauftrag/services/followBar.dart';
import 'package:sauftrag/services/getGroup.dart';
import 'package:sauftrag/services/get_barFollowers.dart';
import 'package:sauftrag/services/get_comments.dart';
import 'package:sauftrag/services/get_match_users.dart';
import 'package:sauftrag/services/get_past_event.dart';
import 'package:sauftrag/services/get_upcoming_events.dart';
import 'package:sauftrag/services/get_user_details.dart';
import 'package:sauftrag/services/get_user_to_user.dart';
import 'package:sauftrag/services/listOfBars.dart';
import 'package:sauftrag/services/post_comments.dart';

import 'package:sauftrag/services/privacyPolicy.dart';
import 'package:sauftrag/services/report_chat_user.dart';
import 'package:sauftrag/services/termsAndCondition.dart';
import 'package:sauftrag/services/updateBarProfile.dart';
import 'package:sauftrag/services/updateUserProfile.dart';
import 'package:sauftrag/services/update_location.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/error_flash_message.dart';

import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/NewsFeed/event_detail.dart';
import 'package:sauftrag/views/UserProfile/terms_condition.dart';
import 'package:sauftrag/widgets/error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';
import '../models/get_bar_follower_list.dart';
import '../models/newfeed_like.dart';
import '../models/user_feedback.dart';
import '../services/feedback_user.dart';
import '../services/like_newsfeed_user.dart';
class MainViewModel extends BaseViewModel {
  var updateUser = UpdateUser();
  var updateBar = Updatebar();
  var createBarPost = Createpost();
  var privacyPolicy = Privacypolicy();
  var termCondition = Termscondition();
  var dataProtection = Dataprotection();
  var faqList = Faqs();
  var contactList = Addressbook();
  var barQRCode = BarQrcode();
  var updateLocation = Updatelocation();
  var listOfBars = Listofbars();
  var followbar = Followbar();
  var getAllBar = AllBarUsers();
  var getbarFollowers = BARFollowers();
  var getUserInfo = UserGetAnotherUser();
  var getBarUpcomingEvents = UpcomingEvents();
  var attendEvent = Attendevent();
  var getPastEvents = PastEvents();
  var addBarFilter = Barfilters();
  var createGroup = Creategroup();
  var getGroup = GetGroup();
  var feedbackUser = Userfeedback();
  var userLike = Newfeedlike();
  var currentUserDetails = UserDetails();
  var updateUserDetails = UpdateUser();
  var postComments = PostComments();
  var getComments = GetComments();
  var postUserChat = UserreportChat();


  Barcode? result;
  List<GetNewsfeedComments>? userComments;
  List<GetNewsfeedCommentsBar>? barComments;

  //var Permission;

   GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  Completer<GoogleMapController> controller = Completer();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  UserModel? userModel;
  NewBarModel? barModel;
  ListOfBarsModel? barFollow;
  ListOfBarsModel? getUpcmoingUserDetails;
  Media? barMedia;
  CreateGroupChat? groupChatUser;
  List<CreateGroupChat>? getUserGroup;
  UserFeedBack? getMessage;
  LikeNewsFeed? likes;

  bool logInUserSelected = true;
  bool logInBarSelected = false;
  var navigationService = navigationViewModel;
  late SharedPreferences prefs;
  List<Marker> markers = <Marker>[];
  final mapSearchController = TextEditingController();
  final searchScreenController = TextEditingController();
  final friendListSearchController = TextEditingController();
  final feedbackController = TextEditingController();
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
  bool signInBar = false;


  //-----Group Name User-----////
  final chatController = TextEditingController();

  //-----Group Name Bar-----////
  final barGroupNameController = TextEditingController();

  bool groupScreenEmojiShowing = false;
  bool groupScreenEmojiSelected = false;
  final groupScreenChatController = TextEditingController();
  final postCommentController = TextEditingController();
  final barGiveRating = TextEditingController();
  final myContactsSearchController = TextEditingController();
  bool myContactEmojiShowing = false;
  bool myContactEmojiSelected = false;
  final myContactsChatController = TextEditingController();
  bool eventSelected = false;
  dynamic currentEventSelected;
  bool timeSelected = false;
  dynamic timeValue;
  double sliderValue = 0.0;
  String? lowValue = "0";
  String? highValue = "50";
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
  bool addDrink = false;
  bool isFollow = false;
  bool isLoading = false;

  List<Marker> marker = <Marker>[];
  String address = "";
  GoogleMapController? mapController;
  double? lat;
  double? lng;

  bool editBool = false;
  var dio = Dio();
  var addFavorite = Addfavorites();

  final aboutMeController = TextEditingController();
  final barNameController = TextEditingController();
  final updateSignUpPhoneController = TextEditingController();
  final updateLocations = TextEditingController();
  final updateUserAbout = TextEditingController();
  final updateBarAbout = TextEditingController();
  ScrollController chatScroll = ScrollController();
  final addDrinkController = TextEditingController();
  bool isAddDrinkInFocus = false;
  FocusNode addDrinkFocus = new FocusNode();

  final addClubController = TextEditingController();
  bool isAddClubInFocus = false;
  FocusNode addClubFocus = new FocusNode();

  final addVacationController = TextEditingController();
  bool isddVacationInFocus = false;
  FocusNode addVacationFocus = new FocusNode();

  //Update New drinks
  final updateNewDrinkController = TextEditingController();
  bool isUpdateNewDrinkInFocus = false;
  FocusNode updateNewDrinkFocus = new FocusNode();

  final addNewDrinkController = TextEditingController();
  bool isAddNewDrinkInFocus = false;
  FocusNode addNewDrinkFocus = new FocusNode();

  final addNewClubController = TextEditingController();
  bool isAddNewClubInFocus = false;
  FocusNode addNewClubFocus = new FocusNode();

  final addNewPartyLocationController = TextEditingController();
  bool isAddNewPartyLocationInFocus = false;
  FocusNode addNewPartyLocationFocus = new FocusNode();

  final filtersMapController = TextEditingController();
  bool isFiltersMapInFocus = false;
  FocusNode filtersMapFocus = new FocusNode();

  PrefrencesViewModel prefrencesViewModel = locator<PrefrencesViewModel>();
  double lowerValue = 0;
  double upperValue = 50;
  PubNub? pubnub;

  List getUserId = [];

  List<FaqsModel> faqs = [];
  List<NewsfeedPostId> posts = [];
  String? privacy;
  String? termsAndCondition;
  String? protection;
  List<FavoritesModel> barQRcode = [];
  List drinksSelected = [];
  List<AddressBook> contactBook = [];
  List<ListOfBarsModel> listOfBar = [];

  GetBarFollower? getbarFollowersDet;

  List<GetBarFollower> getbarfollowers = [];

  List<GetBarFollowersList> getFollowerList = [];

  List<CreateGroupChat> getListGroup = [];
  CreateGroupChat? selectedGroup;

  ListOfBarsModel? selectedBar;

  NewsfeedPostId? selectedPost;

  List<ListOfBarsModel?>? upcomingDetails;

  UserModel? matchedUser;

  ListOfBarsModel? barFollowers;

  List<UserModel>? userDetails;

  List<ListOfBarsModel> listOfAllBars = [];

  List<GetEvent> listOfUpcomingEvents = [];

  List<GetEvent> listOfPastEvents = [];

  GetEvent? selectedUpcomingEvents;

  List<GetEvent> addFilters = [];

//  List<GetUpcomingEvent>? eventOngoingUsers;

  List<EventAttendees>? selectUser = [];
  //String? faqs;

  List contactChecked = [];
  bool isSwitched = false;

  Subscription? subscription;
  Channel? channel;

  int? selectedCommentId;

  bool isFollowBar = false;

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

  File imageFile = File('my initial file');
  List<dynamic> imageFiles = [
    File(""),
    File(""),
    File(""),
    File(""),
    File(""),
    File("")
  ];

  List<dynamic> matchedImage = [

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

  List<String> matchName = [];

  Map<String, int> drinkMotivationMap = {
    'Drink light': 1,
    'Drink normal': 2,
    'Drink hard': 3,
  };

  int drinkIndex = -1;
  int updatedrinkIndex = -1;
  List<int> drinkIndexList = [];

  List<String> favoriteAlcoholicDrink = [
    "Weißwein",
    "Harter Seltzer",
    "Whiskey",
    "Jägermeister",
    "Champagner",
  ];

  List<String> favoriteNightClub = ["Club 1", "Club 6", "Club 8"];

  List<String> favoritePartyVacation = [
    "Goldstrand",
    "Zrce-Strand",
    "Springbreak Cancún",
  ];

  FaqsModel? selectedFaq;


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
        user.favorite_alcohol_drinks = user.favorite_alcohol_drinks!;
        user.favorite_musics = user.favorite_musics!;
        user.favorite_party_vacation = user.favorite_party_vacation!;
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

  Future<Position> determinePositionFilters() async {
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

  // Future<void> searchAddress(BuildContext context) async {
  //
  //   var p = await PlacesAutocomplete.show(
  //       offset: 0,
  //       radius: 1000,
  //       types: [],
  //       strictbounds: false,
  //       context: context,
  //       apiKey: Constants.kGoogleApiKey,
  //       mode: Mode.overlay, // Mode.fullscreen
  //       language: "en",
  //       components: [new Component(Component.country, "pk")]);
  //   GoogleMapsPlaces _places = GoogleMapsPlaces(
  //     apiKey: Constants.kGoogleApiKey,
  //     apiHeaders: await GoogleApiHeaders().getHeaders(),
  //   );
  //
  //   PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p!.placeId!);
  //   final lat = detail.result.geometry!.location.lat;
  //   final lng = detail.result.geometry!.location.lng;
  //
  //   print(p.description);
  //
  //   address = p.description!;
  //   this.lat = lat;
  //   this.lng = lng;
  //
  //   markers.clear();
  //   markers.add(
  //       Marker(
  //           markerId: MarkerId(p.placeId.toString()),
  //           position: LatLng(lat, lng),
  //           infoWindow: InfoWindow(
  //               title: ""
  //           )
  //       )
  //   );
  //
  //   kGooglePlex = CameraPosition(
  //     target: LatLng(lat, lng),
  //     zoom: 18,
  //   );
  //
  //   mapController!.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
  //
  //   notifyListeners();
  // }

  Future<Null> cropImage(BuildContext context, String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.png,
        //compressQuality: 50,
        maxWidth: 500,
        maxHeight: 500,
    );
    if (croppedFile != null) {
      profileFileImage = File(croppedFile.path);
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

  Future navigateToPosition(LatLng latLng) async {
    kGooglePlex = CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 18,
    );

    mapController!.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    address =
        "${placemarks[0].name} ${placemarks[0].street} ${placemarks[0].subLocality} ${placemarks[0].locality} ${placemarks[0].country}";
    lat = latLng.latitude;
    lng = latLng.longitude;

    markers.clear();
    markers.add(Marker(
        markerId: MarkerId(placemarks[0].name!),
        position: LatLng(latLng.latitude, latLng.longitude),
        infoWindow: InfoWindow(title: placemarks[0].name)));

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
  List<dynamic> partyVacationList = [];
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

  int relationValue = 1;
  String relationValueStr = "Single";
  List<String> relationshipList = [
    "Single",
    "Married",
    "Relationship",
    "Open Relationship",
    "it's complicated",
  ];
  Map<String, int> relationshipMap = {
    'Single': 1,
    'Married': 2,
    'Relationship': 3,
    'Open Relationship': 4,
    "it's complicated": 5,
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

  // addMarkers() {
  //   markers.add(Marker(
  //       markerId: MarkerId('SomeId'),
  //       position: LatLng(24.8169, 67.1118),
  //       infoWindow: InfoWindow(title: 'The title of the marker')));
  // }

  addMarkers(LatLng latlng) {
    markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(latlng.latitude, latlng.longitude),
        infoWindow: InfoWindow(title: 'The title of the marker')));
  }

  List<dynamic> drinkList = [];

  List<dynamic> selectedDrinkList = [];

  List<dynamic> clubList = [];
  List<dynamic> selectedClubList = [];

  List<dynamic> vacationList = [];

  List<dynamic> selectedVacationList = [];

  List<String> interestList = [];

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

  void UpdateaddRemoveDrink(int index) {
    updatedrinkIndex = index + 1;
    //drinkIndexList.length = index + 1;
    notifyListeners();

    //drinkIndex = index + 1;
    //notifyListeners();
  }

  deleteAccount() async {
    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
    var response = await dio.delete(
        Constants.BaseUrlPro + Constants.accountDelete,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"Authorization": "Token ${user!.token!}"}));
    // http
    //     .delete(Uri.http(Constants.BaseUrl, Constants.accountDelete), headers: {
    //   // 'content-type': 'application/json',
    //   // 'accept': 'application/json',
    //   'authorization': 'Token ${user!.token!}',
    // });

    logOutUser();
    print(response.data);
  }

  List<FollowersList> follower = [];

  // followers() async {
  //   NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
  //   var response = await dio.get(Constants.BaseUrlPro + Constants.followersList,
  //       options:
  //           Options(contentType: Headers.formUrlEncodedContentType, headers: {
  //         'Authorization': 'Token ${user!.token!}',
  //       }));
  //   // http.get(
  //   //     Uri.http(Constants.BaseUrlPro, Constants.followersList),
  //   //     headers: {'authorization': 'Token ${user!.token!}'});
  //   print(response.data);
  //   // var jsonData = jsonDecode(response.data);
  //   follower =
  //       (response.data as List).map((e) => FollowersList.fromJson(e)).toList();
  //   notifyListeners();
  // }

  Ratings? ratingKaData;
  RatingData? forTime;
  int?  barIndex;

  rating() async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();

    var response = await dio.get(Constants.BaseUrlPro + Constants.rating,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"Authorization": "Token ${user!.token!}"})
        // Options(headers: {'Authorization': 'Token ${user!.token!}'})
        );
    print(response);
    forTime = RatingData.fromJson(response.data);
    getTime();
  }

  var currentPosition;
  double longitude = 0.0;
  double latitude = 0.0;

  // var currentPosition;
  Future updateCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      // currentPosition = position;
      notifyListeners();
      // currentPosition;
      longitude = position.longitude;
      latitude = position.latitude;
      notifyListeners();
      var updatelocationResponse = await updateLocation.UpdateLocation(
          latitude.toStringAsFixed(5),
          longitude.toStringAsFixed(5),
          userModel!.id.toString());

      print(updatelocationResponse);
    }).catchError((e) {
      print(e);
    });
  }

  Future updateCurrentLocationBar() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      // currentPosition = position;
      notifyListeners();
      // currentPosition;

      latitude = position.latitude;
      longitude = position.longitude;

      notifyListeners();
      var updatelocationResponse = await updateLocation.UpdateLocationBar(
          latitude.toStringAsFixed(5),
          longitude.toStringAsFixed(5),
          barModel!.id.toString());

      print(updatelocationResponse);
    }).catchError((e) {
      print(e);
    });
  }

  // var channel = "getting_started";

  List chats = [];
  var message = '';

  String? timeZone;

  getTime() {
    var checking = ratingKaData!.data![0].toString();
    var dateTime =
        DateFormat("yyyy-MM-dd").parse(checking.replaceAll('T', ' '), true);
    var dateLocal = dateTime.toLocal();
    timeZone = dateLocal.toString();
    print(dateLocal);
    return dateLocal;
  }
  
  DeactivateAccount() async {
    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
    var response = await dio.post(
        Constants.BaseUrlPro + Constants.accountDeactivate,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Token ${user!.token!}'}));
    //  http.post(
    //     Uri.http(Constants.BaseUrlPro, Constants.accountDeactivate),
    //     headers: {
    //       // 'content-type': 'application/json',
    //       // 'accept': 'application/json',
    //       'authorization': 'Token ${user!.token!}',
    //     });
    print(response.data);
    var jsonData = jsonDecode(response.data);
    // DialogUtils().showDialog(MyErrorWidget(error: jsonData['detail']));
    logOutUser();
    // errorFlashMessage(jsonData['detail'], context);
  }

  List<UserForChat> userForChats = [];
  List<UserForChat> usersList = [];
  List barsList = [];
  // List usersList = [];

  /// Get Match
  var matchUser = MatchUsers();
  List<UserModel> matchedUsers = [];

  matchingUsers() async {
    var response = await matchUser.GetMatchedUsers();
    matchedUsers = response;
    notifyListeners();
  }

  bool userComing = false;

  getAllUserForChat() async {
    userComing = true;
    // notifyListeners();
    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
    var response = await dio.get(
        Constants.BaseUrlPro + Constants.allUserForChat,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Token ${user!.token!}'}));
    print(response.data);
    userForChats =
        (response.data as List).map((e) => UserForChat.fromJson(e)).toList();
    //usersList.add(userForChats.where((element) => element.id == 1).toList());
    usersList = userForChats.where((element) => element.role == 1).toList();
    barsList = userForChats.where((element) => element.role == 2).toList();
    print(usersList);
    userComing = false;
    notifyListeners();
  }

  getAllBarForChat() async {
    userComing = true;
    // notifyListeners();
    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
    var response = await dio.get(
        Constants.BaseUrlPro + Constants.allUserForChat,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Token ${user!.token!}'}));
    print(response.data);
    userForChats =
        (response.data as List).map((e) => UserForChat.fromJson(e)).toList();
    //usersList.add(userForChats.where((element) => element.id == 1).toList());
    usersList = userForChats.where((element) => element.role == 1).toList();
    barsList = userForChats.where((element) => element.role == 2).toList();
    print(usersList);
    userComing = false;
    notifyListeners();
  }

  String getConversationID(String userID, String peerID) {
    return userID.hashCode <= peerID.hashCode
        ? userID + '_' + peerID
        : peerID + '_' + userID;
  }

  List<PubnubChannel>? pnChannel = [];

  getGroupChannelFromPubnub() async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    var response = await dio.get('https://ps.pndsn.com/' + 'v2/presence/sub-key/'
        //'sub-c-8825eb94-8969-11ec-a04e-822dfd796eb4'
        'sub-c-f77ff5d6-c477-11ec-a5a3-fed9c56767c0'
        '/uuid/${user!.id}');
    print(response.data);
    var encodedData = jsonEncode(response.data);
    print(encodedData);
    var jsonData = jsonDecode(encodedData);
    print(jsonData);
    pnChannel = (jsonData['channels'] as List)
        .map((e) => PubnubChannel.fromJson(e))
        .toList();
  }

  List<Discover> discoverPeople = [];

  DiscoverPeople() async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    var response = await dio.get(Constants.BaseUrlPro + Constants.discover,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Token ${user!.token!}'}));
    print(response.data);
    discoverPeople =
        (response.data as List).map((e) => Discover.fromJson(e)).toList();
  }

  double? rate;
  var barId;

  giveRatingToBar() async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    var data = {'rate': rate, 'comments': barGiveRating.text, 'bar': selectedBar!.id!};
    var encodedData = jsonEncode(data);
    var response = await http.post(
        Uri.http(Constants.BaseUrl, '/api/rating/add/'),
        body: encodedData,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Token ${user!.token!}'
        });

    var jsonData = jsonDecode(response.body);
    print(jsonData);

    // dio.post(Constants.BaseUrlPro + Constants.giveRating,
    //     data: FormData.fromMap(
    //         {'rate': rate, 'comments': barGiveRating.text, 'bar': 78}),
    //     options: Options(
    //         contentType: Headers.formUrlEncodedContentType,
    //         headers: {'Authentication': 'Token ${user!.token!}'}));
    // print(response.data);
  }

  String? drinkingFrom;
  String? drinkingTo;
  bool updateStatus = false;

  drinkStatus() async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    var startTimeofDrinking = DateFormat('jm')
        .parse(drinkingFrom!)
        .toString()
        .split(' ')[1]
        .substring(0, 5);
    var endTimeOfDrinking = DateFormat('jm')
        .parse(drinkingTo!)
        .toString()
        .split(' ')[1]
        .substring(0, 5);
    print(startTimeofDrinking);
    print(endTimeOfDrinking);
    var data = FormData.fromMap({
      'quantity': drinkIndex,
      'start_time': startTimeofDrinking,
      'end_time': endTimeOfDrinking,
    });
    // var encodedData = jsonEncode(data);

    var response = await dio.post(Constants.BaseUrlPro + Constants.drinkStatus,
        data: data, options: Options(
            // contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Token ${user!.token!}'}));
    print(response.data);
    getStatus = DrinkStatus.fromJson(response.data);
    getStatus!.start_time = TimeOfDay(
            hour: int.parse(getStatus!.start_time!.split(":")[0]),
            minute: int.parse(getStatus!.start_time!.split(":")[1]))
        .format(navigationService.navigationKey.currentContext!);
    getStatus!.end_time = TimeOfDay(
            hour: int.parse(getStatus!.end_time!.split(":")[0]),
            minute: int.parse(getStatus!.end_time!.split(":")[1]))
        .format(navigationService.navigationKey.currentContext!);
    updatedrinkIndex = getStatus!.quantity!;
    notifyListeners();
  }

  updateDrinkStatus(BuildContext context) async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    var startTimeofDrinking = DateFormat('jm')
        .parse(drinkingFrom ?? TimeOfDay(hour: TimeOfDay.now().hour, minute: 0).format(context))
        .toString()
        .split(' ')[1]
        .substring(0, 5);
    var endTimeOfDrinking = DateFormat('jm')
        .parse(drinkingTo ?? TimeOfDay(hour: TimeOfDay.now().hour, minute: 0).format(context))
        .toString()
        .split(' ')[1]
        .substring(0, 5);
    print(startTimeofDrinking);
    print(endTimeOfDrinking);
    var data = {
      'quantity': updatedrinkIndex,
      'start_time': startTimeofDrinking,
      'end_time': endTimeOfDrinking,
    };
    var response = await dio.post(Constants.BaseUrlPro + Constants.drinkStatus,
        data: data,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Token ${user!.token!}'}));
    print(response.data);
    getStatus = DrinkStatus.fromJson(response.data);
    getStatus!.start_time = TimeOfDay(
            hour: int.parse(getStatus!.start_time!.split(":")[0]),
            minute: int.parse(getStatus!.start_time!.split(":")[1]))
        .format(navigationService.navigationKey.currentContext!);
    getStatus!.end_time = TimeOfDay(
            hour: int.parse(getStatus!.end_time!.split(":")[0]),
            minute: int.parse(getStatus!.end_time!.split(":")[1]))
        .format(navigationService.navigationKey.currentContext!);
    updatedrinkIndex = getStatus!.quantity!;
    notifyListeners();
  }

  DrinkStatus? getStatus;

  getDrinkStatus() async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    var response = await dio.get(
        Constants.BaseUrlPro + "api/user/drinkStatus/${user!.id!}/",
        // queryParameters: {'user_id': user!.id!},
        options: Options(
            // contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Token ${user.token!}'}));
    print(response.data);
    getStatus = DrinkStatus.fromJson(response.data);
    DateFormat("hh:mm a").format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ));
    getStatus!.start_time = TimeOfDay(
            hour: int.parse(getStatus!.start_time!.split(":")[0]),
            minute: int.parse(getStatus!.start_time!.split(":")[1]))
        .format(navigationService.navigationKey.currentContext!);
    getStatus!.end_time = TimeOfDay(
            hour: int.parse(getStatus!.end_time!.split(":")[0]),
            minute: int.parse(getStatus!.end_time!.split(":")[1]))
        .format(navigationService.navigationKey.currentContext!);
    updatedrinkIndex = getStatus!.quantity!;

    notifyListeners();
    // print(getStatus);
  }

  barList() async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    var response = await dio.get(
        Constants.BaseUrlPro + Constants.allUserForChat,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Token ${user!.token!}'}));
    print(response.data);
    userForChats =
        (response.data as List).map((e) => UserForChat.fromJson(e)).toList();
    userComing = false;
    notifyListeners();
  }

  void scrollDown() {
    chatScroll.jumpTo(chatScroll.position.maxScrollExtent);
  }

  void navigateToProfileScreen(
      List<String> images,
      String? name,
      String address,
      List alcoholDrink,
      List nightClub,
      List partyVacation,
      dynamic id,
      int? distance,
      List? drinking_motivation
      ) {
    navigationService.navigateToProfileScreen(
        images, name, address, alcoholDrink, nightClub, partyVacation, id, distance!, drinking_motivation);
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

  void navigateToServerErrorPage() {
    navigationService.navigateToServerErrorPage();
  }

  void navigateToGroupScreen() {
    navigationService.navigateToGroupScreen();
  }

  void navigateToUserProfileAccountScreen() {
    navigationService.navigateToUserProfileAccountScreen();
  }

  void navigateToUserProfileScreen() {
    navigationService.navigateToUserProfileScreen(4);
  }

  void navigateToBarGroup() {
    navigationService.navigateToBarGroup();
  }

  void navigateToStaticTermsAndConditionScreen() {
    navigationService.navigateToStaticTermsAndConditionScreen();
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

  void navigateToUserFeedbackScreen() {
    navigationService.navigateToUserFeedbackScreen();
  }

  void navigateToFollowersListScreen() {
    navigationService.navigateToFollowersListScreen();
  }

  void navigateToBarAndClubsScreen() {
    navigationService.navigateToBarAndClubsScreen();
  }

  void navigateToFriendListScreen() {
    navigationService.navigateToFriendListScreen();
  }

  void navigateToOngoingUsersScreen() {
    navigationService.navigateToOngoingUsersScreen();
  }

  void navigateToMsgCreateGroupScreen() {
    navigationService.navigateToMsgCreateGroupScreen();
  }

  void navigateToUserGroupChatScreen() {
    navigationService.navigateToUserGroupChatScreen();
  }

  void navigateToMsgCreateGroupBarScreen() {
    navigationService.navigateToMsgCreateGroupBarScreen();
  }

  void navigateToAddParticipantsScreen() {
    navigationService.navigateToAddParticipantsScreen();
  }

  void navigateToBarGroupScreen() {
    navigationService.navigateToBarGroupScreen();
  }

  void navigateToInvitePeopleScreen() {
    navigationService.navigateToInvitePeopleScreen();
  }

  void navigateToHomeBarScreen() {
    navigationService.navigateToHomeBarScreen();
  }

  void navigateToNotFound() {
    navigationService.navigateToNotFound();
  }

  void navigateAndRemoveSignInScreen() {
    navigationService.navigateAndRemoveSignInScreen();
  }

  void navigateToSwipeScreen() {
    navigationService.navigateUntilToSwipeScreen();
  }

  void navigateToFriendListScreen1() {
    navigationService.navigateToFriendListScreen1();
  }

  void navigateToBarTimingTypeScreen() {
    navigationService.navigateToBarTimingTypeScreen();
  }

  void navigateToOrderDetailsScreen() {
    navigationService.navigateToOrderDetailsScreen();
  }

  void navigateToMapSearchScreen() {
    navigationService.navigateToMapSearchScreen();
  }

  void navigateToMapScreen() {
    navigationService.navigateToMapScreen(3);
  }

  // void navigateToEventDetailsScreen( dynamic image,
  //       dynamic eventName,
  //       dynamic eventDate,
  //       dynamic eventStartTime,
  //       dynamic eventEndTime,
  //       dynamic location,
  //       dynamic about) {
  //   navigationService.navigateToEventDetailScreen(image: image,eventName: eventName,eventDate: eventDate,eventStartTime: eventStartTime,eventEndTime: eventEndTime,location: location,about: about);
  // }

  void navigateToEventDetailScreen(
      dynamic image,
      dynamic eventName,
      dynamic eventDate,
      dynamic eventStartTime,
      dynamic eventEndTime,
      dynamic location,
      dynamic about,
      dynamic barName,
      dynamic barImage) {
    navigationKey.currentState!.push(PageTransition(
        child: EventDetails(
          image: image,
          eventName: eventName,
          eventDate: eventDate,
          eventStartTime: eventStartTime,
          eventEndTime: eventEndTime,
          location: location,
          about: about,
          barName: barName,
          barImage: barImage,
        ),
        type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToUserDetailSettings() {
    navigationService.navigateToUserDetailSettings();
  }

  void navigateToUpcomingBarEventDetails() {
    navigationService.navigateToUpcomingBarEventDetails();
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

  void navigateToMatchedProfileUser() {
    navigationService.navigateToMatchedProfileUser();
  }

  void navigateToBarFollowerDet() {
    navigationService.navigateToBarFollowerDet();
  }

  void navigateToListOfBar() {
    navigationService.navigateToListOfBar();
  }

  void navigateToTermsScreen() {
    navigationService.navigateToTermsScreen();
  }

  void navigateToAlCommentsUserScreen() {
    navigationService.navigateToAlCommentsUserScreen();
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

  void navigateToBarIndividualChatScreen() {
    navigationService.navigateToBarIndividualChatScreen();
  }

  void navigateToChangePassword() {
    navigationService.navigateToChangePassword();
  }

  void navigateToFriendListForUser() {
    navigationService.navigateToFriendListForUser();
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

  void navigateToAddressBookScreen() {
    navigationService.navigateToAddressBookScreen();
  }

  void navigateToChooseDrinkScreen() {
    navigationService.navigateToChooseDrinkScreen();
  }

  void navigateToAddAddressScreen() {
    navigationService.navigateToAddAddressScreen();
  }

  void navigateToBarEventMapScreen() {
    navigationService.navigateToBarEventMapScreen();
  }

  void navigateToBarFollowersListScreen() {
    navigationService.navigateToBarFollowersListScreen();
  }

  void navigateToFilterEventScreen() {
    navigationService.navigateToFilterEventScreen();
  }

  void navigateToMatchDetailScreen(
    dynamic images,
    String? name,
    String address,
    List alcoholDrink,
    List nightClub,
    List partyVacation,
    dynamic id,
  ) {
    navigationService.navigateToMatchDetailScreen(
        images, name, address, alcoholDrink, nightClub, partyVacation, id);
  }

  /*Future saveUserDetails() async {
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

    for (int i = 0; i < imageFiles.length; i++) {
      if ((imageFiles[i] is File)) {
        if (imageFiles[i].path.isEmpty) {
          DialogUtils().showDialog(
              MyErrorWidget(
                error: "Select All Images" *//*+i.toString()*//*,
              ),
              isDismissable: true);
          return;
        }
      }

      // bool hasImages = false;
      // if (!hasImages) {
      //   if ((imageFiles[i] is String && (imageFiles[i] as String).isEmpty) ||
      //       imageFiles[i].path.isEmpty) {
      //     DialogUtils().showDialog(MyErrorWidget(
      //       error: "Select at least one Image",
      //     ));
      //     return;
      //   } else {
      //     hasImages = true;
      //     break;
      //   }
      // }
    }
    editProfile = true;
    notifyListeners();
    var userUpdateResponse = await updateUser.UpdateUserProfile(
        (genderList.indexOf(genderValueStr) + 1).toString(), imageFiles);
    if (userUpdateResponse is UserModel) {
      UserModel user = userUpdateResponse;
      user.token = userModel!.token!;
      user.favorite_alcohol_drinks = user.favorite_alcohol_drinks!;
      user.favorite_musics = user.favorite_musics!;
      user.favorite_party_vacation = user.favorite_party_vacation!;
      await prefrencesViewModel.saveUser(user);
      notifyListeners();
    }
    editProfile = false;
    notifyListeners();
  }*/

  Future updateAccountDetials() async {
    isLoading = true;
    notifyListeners();
    var updateAccountDetailResponse = await updateUser.UpdateAccountDetails(
        updateSignUpPhoneController.text, updateLocations.text);
    if (updateAccountDetailResponse is UserModel) {
      UserModel user = updateAccountDetailResponse;
      user.token = userModel!.token!;

      await prefrencesViewModel.saveUser(user);
      notifyListeners();
    }
    isLoading = false;
    navigateToUserProfileScreen();
    notifyListeners();
  }

  saveBarDetails() async {

    editProfile = true;
    notifyListeners();
    List tempList = [];

    for(int i=0; i<6; i++)
      {
        if(i<imageFiles.length)
          {
            tempList.add(imageFiles[i]);
          }
        else{
          tempList.add(File(""));
        }
      }
    NewBarModel? barmodel = await prefrencesViewModel.getBarUser();

    var barUpdateResponse = await updateBar.UpdateBarProfile(

      barmodel!.id,
      barNameController.text,
      barmodel.role,
      updateBarAbout.text,
      tempList,
    );
    print(barUpdateResponse);

    if (barUpdateResponse is NewBarModel) {
      NewBarModel barUser = barUpdateResponse;
      //barUser.bar_name = barUser.bar_name;
      barUser.token = barModel!.token!;
      // user.favorite_alcohol_drinks = user.favorite_alcohol_drinks!;
      // user.favorite_night_club = user.favorite_night_club!;
      // user.favorite_party_vacation =user.favorite_party_vacation!;
      await prefrencesViewModel.saveBarUser(barUser);
      barModel = barUser;
      print(barModel);
      //notifyListeners();
    }

    editProfile = false;
    notifyListeners();
  }

  logOutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    getStatus = null;
    navigateAndRemoveSignInScreen();
  }

  // List<NewsfeedPostId> posts = [];

  void getUserData() async {
    userModel = (await prefrencesViewModel.getUser())!;
    barModel = (await prefrencesViewModel.getBarUser())!;
    notifyListeners();
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

  void getBarData() async {
    barModel = await prefrencesViewModel.getBarUser();
    notifyListeners();
  }

  getBarPost() async {
    isPost = true;
    var getNewsfeed = await createBarPost.GetPost();
    if (getNewsfeed is List<NewsfeedPostId>) {
      posts = getNewsfeed;
    }
    isPost = false;
    print(getNewsfeed);
    notifyListeners();
  }

  getPrivacyPolicy() async {
    isPrivacyPolicy = true;

    var getPrivacyPolicy = await privacyPolicy.GetPrivacyPolicy();
    if (getPrivacyPolicy is String) {
      privacy = getPrivacyPolicy;
      //isPrivacyPolicy = false;

    } else {
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

    var getTerms = await termCondition.GetTermsCondition();
    if (getTerms is String) {
      termsAndCondition = getTerms;
      //isPrivacyPolicy = false;

    } else {
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

    var getDaraProtection = await dataProtection.GetDataProtection();
    if (getDaraProtection is String) {
      protection = getDaraProtection;
      //isPrivacyPolicy = false;

    } else {
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
    if (getFaqList is List<FaqsModel>) {
      faqs = getFaqList;
    } else {
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

  getListOfbars() async {
    isFaqs = true;

    var getListofbar = await listOfBars.ListOfBars();
    print(getListofbar);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }
    if (getListofbar is List<ListOfBarsModel>) {
      listOfBar = getListofbar;
      print(listOfBar);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isFaqs = false;
    notifyListeners();
    //print(getFaqsList);
  }

  getListOfAllBars() async {
    isFaqs = true;

    var getListofAllBar = await getAllBar.GetAllBarUsers();
    print(getListofAllBar);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }ListOfBarsModel
    if (getListofAllBar is List<ListOfBarsModel>) {
      listOfAllBars = getListofAllBar;
      print(listOfAllBars);
    } else {
      // DialogUtils().showDialog(MyErrorWidget(
      //   error: "Some thing went wrong",
      // ));
      // //isPrivacyPolicy = false;
      //
      // return;
    }
    isFaqs = false;
    notifyListeners();
    //print(getFaqsList);
  }

  getListOfUpcomingEvents() async {
    isFaqs = true;

    var listOfUpcomingEvent = await getBarUpcomingEvents.GetUpcomingEvents();
    print(listOfUpcomingEvent);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }ListOfBarsModel
    if (listOfUpcomingEvent is List<GetEvent>) {
      listOfUpcomingEvents = listOfUpcomingEvent;
      // for(var v in listOfUpcomingEvent){
      //   //v.going_users!;
      //   selectUser!.add(v.going_users![0]);
      //   print(selectUser);
      // }
      print(listOfUpcomingEvents);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isFaqs = false;
    //notifyListeners();
    //print(getFaqsList);
  }

  getListOfPastEvents() async {
    isFaqs = true;

    var listOfPastEvent = await getPastEvents.GetPastEvents();
    print(listOfPastEvent);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }ListOfBarsModel
    if (listOfPastEvent is List<GetEvent>) {
      listOfPastEvents = listOfPastEvent;
      // for(var v in listOfUpcomingEvent){
      //   //v.going_users!;
      //   selectUser!.add(v.going_users![0]);
      //   print(selectUser);
      // }
      print(listOfPastEvents);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isFaqs = false;
    notifyListeners();
    //print(getFaqsList);
  }

  getBarsFollowers() async {
    isFaqs = true;

    var getListofBarFollowers = await getbarFollowers.GetBarFollowers();
    print(getListofBarFollowers);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }ListOfBarsModel
    if (getListofBarFollowers is List<GetBarFollower>) {
      getbarfollowers = getListofBarFollowers;
      print(getbarfollowers);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;
      isFaqs = false;
      notifyListeners();
      return;
    }
    isFaqs = false;
    notifyListeners();
    //print(getFaqsList);
  }

  getBarsFollowerList() async {
    isFaqs = true;

    var BarFollowersList = await getbarFollowers.GetBarFollowersLists();
    print(BarFollowersList);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }ListOfBarsModel
    if (BarFollowersList is List<GetBarFollowersList>) {
      getFollowerList = BarFollowersList;
      print(getFollowerList);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isFaqs = false;
    notifyListeners();
    //print(getFaqsList);
  }

  // getBarsFollowerForChat() async {
  //   isFaqs = true;
  //
  //   var BarFollowersListForChat = await getbarFollowers.GetFollowersForGroupChat();
  //   print(BarFollowersListForChat);
  //   // if (getFaqList is String){
  //   //   faqs = getFaqList;
  //   //   //isPrivacyPolicy = false;
  //   //
  //   // }ListOfBarsModel
  //   if (BarFollowersListForChat is List<GetBarFollowersList>) {
  //     getFollowerList = BarFollowersListForChat;
  //     print(getFollowerList);
  //   }   else {
  //     DialogUtils().showDialog(MyErrorWidget(
  //       error: "Error",
  //     ));
  //     //isPrivacyPolicy = false;
  //
  //     return;
  //   }
  //   isFaqs = false;
  //   notifyListeners();
  //   //print(getFaqsList);
  // }

  postBarFollow() async {
    isFollowBar = true;
    notifyListeners();
    bool follow = !selectedBar!.is_follow!;
    var getListofbar = await followbar.FollowBar(selectedBar!.id!, follow);
    print(getListofbar);
    if (getListofbar is FollowBAR) {
      var index = listOfAllBars.indexWhere((element) => element.id==selectedBar!.id);
      listOfAllBars[index].is_follow =
          (getListofbar as FollowBAR).user!.is_follow!;
      selectedBar!.is_follow = (getListofbar as FollowBAR).user!.is_follow!;
      if(follow){
        selectedBar!.total_followers = selectedBar!.total_followers! + 1;
      }
      else{
        selectedBar!.total_followers = selectedBar!.total_followers! - 1;
      }
      //isLoading = false;
      //notifyListeners();
    } else {
      // isLoading = false;
      // DialogUtils().showDialog(MyErrorWidget(
      //   error: "Some thing went wrong",
      // ));
      //isPrivacyPolicy = false;

      //return;
    }
    isFollowBar = false;
    notifyListeners();
    //print(getFaqsList);
  }

  bool isAttend = false;
  bool isAttendingEvent = false;

  attendedEvent() async {
    isLoading = true;
    notifyListeners();
    //bool follow =! selectedBar!.is_follow!;
    var getAttendUser =
        await attendEvent.AttendEvent(selectedUpcomingEvents!.id!);
    print(getAttendUser);

    if (getAttendUser == true) {
      var index = listOfUpcomingEvents.indexOf(selectedUpcomingEvents!);
      selectedUpcomingEvents!.is_attend = true;
      if (index != -1) {
        listOfUpcomingEvents[index].is_attend = true;
      }
      notifyListeners();
      DialogUtils().showDialog(MyErrorWidget(
        error: "You'll attend this event!",
      ));
      notifyListeners();
    } else {
      isLoading = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;
      return;
    }
    isLoading = false;
    notifyListeners();
    print(getFaqsList);
  }

  removeAttendedEvent() async {
    isLoading = true;
    notifyListeners();
    //bool follow =! selectedBar!.is_follow!;
    var getAttendUser =
        await attendEvent.RemoveAttendEvent(selectedUpcomingEvents!.id!);
    print(getAttendUser);

    if (getAttendUser == true) {
      var index = listOfUpcomingEvents.indexOf(selectedUpcomingEvents!);
      selectedUpcomingEvents!.is_attend = false;
      listOfUpcomingEvents[index].is_attend = false;
      notifyListeners();
      DialogUtils().showDialog(MyErrorWidget(
        error: "You'll not attend this event!",
      ));
      notifyListeners();
    } else {
      isLoading = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;
      return;
    }
    isLoading = false;
    notifyListeners();
    print(getFaqsList);
  }

  bool eventLoader = false;

  List<BarEventModel>? barEventModel = [];

  void getEvent(BuildContext context) async {
    NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();

    try {
      eventLoader = true;
      notifyListeners();
      var response = await dio.get("${Constants.GetEvents}",
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${user!.token!}"}));
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

  void getContacts() async {
    bool permissionGranted = false;

    var status = await Permission.contacts.status;
    if (status.isDenied) {
      await Permission.contacts.request();
    }
    //await Permission.storage.request();

    if (await Permission.contacts.isRestricted ||
        await Permission.contacts.isDenied) {
      permissionGranted = false;
      //await Permission.contacts.request();
    } else {
      permissionGranted = true;
    }
    if (permissionGranted) {
      List<Contact> contacts = await ContactsService.getContacts();
      List<dynamic> contactsToSend = [];
      for (Contact contact in contacts) {
        if (contact.displayName != null && contact.phones != null) {
          if (contact.phones!.isNotEmpty) {
            var data = {
              "username": contact.displayName,
              "phone_no": contact.phones!.first.value!,
            };
            contactsToSend.add(data);
          }
        }
      }
      var getContactList = await contactList.AddressBookList(contactsToSend);
      if (getContactList is List<AddressBook>) {
        contactBook = getContactList;
      }
      print(getContactList);
    }
  }

  List<UserModel>? discoverModel = [];
  List catalogImages = [];
  bool discoverLoader = false;

  void getDiscover(BuildContext context) async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    try {
      discoverLoader = true;
      notifyListeners();
      catalogImages = [];
      // user!.token!
      var response = await dio.get("${Constants.GetDiscover}",
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${user!.token!}"}));
      print(response);

      if (response.statusCode == 200) {
        discoverModel =
            (response.data as List).map((e) => UserModel.fromJson(e)).toList();

        for (UserModel userName in discoverModel!) {
          matchName.add(userName.toJson()['username']);
        }

        for (UserModel user in discoverModel!) {
          List<String> images = [];
          for (int i = 1; i < 6; i++) {
            if (user.toJson()["catalogue_image${i}"] != null) {
              images.add(user.toJson()["catalogue_image${i}"]);
            }
          }
          if (images.isNotEmpty) {
            catalogImages.add(images);
          }
          print(images);
        }

        print(discoverModel!.length);

        discoverLoader = false;
        notifyListeners();
      } else {
        print(response.statusCode);
        discoverLoader = false;
        notifyListeners();

        // showErrorMessage(context, 'Something went wrong. Please try again');
      }
    } on DioError catch (e) {
      print(e);
      discoverLoader = false;
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

  bool userMatchLoader = false;

  Future UserMatches(BuildContext context, dynamic id, {dynamic img}) async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();

    try {
      userMatchLoader = true;
      notifyListeners();
      //catalogImages = [];

      var matchParams = FormData.fromMap({'customer2': id});
      print(matchParams);

      var response = await dio.post("${Constants.matchUser}",
          data: matchParams,
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${user!.token}"}));
      print(response);

      if (response.statusCode == 201) {
        // DialogUtils().showDialog(MyErrorWidget(
        //   error: "Request Send Successfully",
        // ));
        //getDiscover(context);
        catalogImages.remove(img);
        if (catalogImages.isEmpty) {
          getDiscover(context);
        }
        userMatchLoader = false;
        notifyListeners();
      } else {
        print(response.statusCode);
        userMatchLoader = false;
        notifyListeners();
      }
    } on DioError catch (e) {
      print(e.response!.data['details']);
      var errorResponse = e.response!.data['details'];
      userMatchLoader = false;
      notifyListeners();
      if (errorResponse == "Match Request Already sent") {
        DialogUtils().showDialog(MyErrorWidget(
          error: "Request Already Send",
        ));
      }
      // print(e.response!.data['customer2'][0]);
      getDiscover(context);
      userMatchLoader = false;
      notifyListeners();
    }
  }

  RequestMatchModel? requestProfileDetails;

  List<RequestMatchModel> requestModel = [];
  bool matchesLoader = false;

  void requestMatches(BuildContext context) async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();

    // catalogImages = [];
    try {
      matchesLoader = true;
      notifyListeners();
      // user!.token!
      var response = await dio.get("${Constants.requestMatchUser}",
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${user!.token!}"}));
      print(response);

      if (response.statusCode == 200) {
        requestModel = (response.data as List)
            .map((e) => RequestMatchModel.fromJson(e))
            .toList();

        // for (UserModel userName in discoverModel!) {
        //   matchName.add(userName.toJson()['username']);
        // }
        // for (UserModel user in discoverModel!) {
        //   List<String> images = [];
        //   for (int i = 1; i < 6; i++) {
        //     if (user.toJson()["catalogue_image${i}"] != null) {
        //       images.add(user.toJson()["catalogue_image${i}"]);
        //     }
        //   }
        //   catalogImages.add(images);
        //   print(images);
        // }

        print(discoverModel!.length);

        matchesLoader = false;
        notifyListeners();
      } else {
        print(response.statusCode);
        matchesLoader = false;
        notifyListeners();
        // showErrorMessage(context, 'Something went wrong. Please try again');
      }
    } on DioError catch (e) {
      print(e);
      matchesLoader = false;
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

  Future orderDrinks() async {
    Drinkorder().DrinkOrder(int.parse(result!.code!), drinksSelected);
  }

  bool acceptRequestLoader = false;

  Future acceptRequest(BuildContext context, dynamic id) async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    catalogImages = [];
    try {
      matchesLoader = true;
      notifyListeners();

      var requestAccept = FormData.fromMap({'id': id});

      print(requestAccept);

      var response = await dio.post("${Constants.requestAccept}",
          data: requestAccept,
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${user!.token}"}));
      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // DialogUtils().showDialog(MyErrorWidget(
        //   error: "Request Accept Successfully",
        // ));
        requestMatches(context);
        getDiscover(context);
        matchesLoader = false;
        notifyListeners();
      } else {
        DialogUtils().showDialog(MyErrorWidget(
          error: "Something went wrong",
        ));
        print(response.statusCode);

        matchesLoader = false;
        notifyListeners();
        matchesLoader = false;
        notifyListeners();
      }
    } on DioError catch (e) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Something went wrong",
      ));
      print(e);
      matchesLoader = false;
      notifyListeners();
    }
  }

  Future deleteRequest(BuildContext context, dynamic id) async {
    UserModel? user = await locator<PrefrencesViewModel>().getUser();
    catalogImages = [];
    try {
      matchesLoader = true;
      notifyListeners();

      var requestDelete = FormData.fromMap({'id': id});

      print(requestDelete);

      var response = await dio.delete("${Constants.requestDelete}",
          data: requestDelete,
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${user!.token}"}));
      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // DialogUtils().showDialog(MyErrorWidget(
        //   error: "Delete Successfully",
        // ));
        requestMatches(context);
        getDiscover(context);
        matchesLoader = false;
        notifyListeners();
      } else {
        DialogUtils().showDialog(MyErrorWidget(
          error: "Something went wrong",
        ));
        print(response.statusCode);

        matchesLoader = false;
        notifyListeners();
        matchesLoader = false;
        notifyListeners();
      }
    } on DioError catch (e) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Something went wrong",
      ));
      print(e);
      matchesLoader = false;
      notifyListeners();
    }
  }

  bool matched = false;

  List<UserMatchedModel> acceptMatchedtModel = [];
  UserMatchedModel? getMatchedUserData;

  bool acceptMatchesLoader = false;

  List matcheImages = [];
  List matcheName = [];

   acceptMatched(BuildContext context) async {
    isLoading = true;
    UserModel? user = await locator<PrefrencesViewModel>().getUser();

    matcheImages = [];
    try {
      acceptMatchesLoader = true;
      notifyListeners();
      // user!.token!
      var response = await dio.get("${Constants.matchUser}",
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${user!.token!}"}));
      print(response);

      if (response.statusCode == 200) {
        acceptMatchedtModel = (response.data as List)
            .map((e) => UserMatchedModel.fromJson(e))
            .toList();

        for (UserModel userName in discoverModel!) {
          matcheName.add(userName.toJson()['username']);
        }

        for (UserModel user in discoverModel!) {
          List<String> images = [];
          for (int i = 1; i < 6; i++) {
            if (user.toJson()["catalogue_image${i}"] != null) {
              images.add(user.toJson()["catalogue_image${i}"]);
            }
          }
          isLoading =false;
          matcheImages.add(images);
          print(images);
        }

        print(discoverModel!.length);

        acceptMatchesLoader = false;
        isLoading =false;
        notifyListeners();
      } else {
        print(response.statusCode);
        isLoading =false;
        acceptMatchesLoader = false;
        notifyListeners();

        // showErrorMessage(context, 'Something went wrong. Please try again');
      }
    } on DioError catch (e) {
      print(e);
      isLoading =false;
      acceptMatchesLoader = false;
      notifyListeners();
    }
  }

// QrImage(
// data: "123457890",
// version: QrVersions.auto,
// size: 200.0,
// ),
  void initBarPubNub() async {
    NewBarModel barUser = (await locator<PrefrencesViewModel>().getBarUser())!;
    //UserModel user = (await locator<PrefrencesViewModel>().getUser())!;
    pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey:
            'sub-c-f77ff5d6-c477-11ec-a5a3-fed9c56767c0',
            //'sub-c-8825eb94-8969-11ec-a04e-822dfd796eb4',
            publishKey:
            'pub-c-086f026a-7f2a-4f5d-ab18-879296d860a7',
            //'pub-c-1f404751-6cfb-44a8-bfea-4ab9102975ac',
            uuid: UUID("${barUser.id.toString()}")));
  }

  void initUserGrpPubNub() async {
    //NewBarModel barUser = (await locator<PrefrencesViewModel>().getBarUser())!;
    UserModel user = (await locator<PrefrencesViewModel>().getUser())!;
    pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey:
            'sub-c-f77ff5d6-c477-11ec-a5a3-fed9c56767c0',
            //'sub-c-8825eb94-8969-11ec-a04e-822dfd796eb4',
            publishKey:
            'pub-c-086f026a-7f2a-4f5d-ab18-879296d860a7',
            //'pub-c-1f404751-6cfb-44a8-bfea-4ab9102975ac',
            uuid: UUID("${user.id.toString()}")));
  }

  void initUserPubNub() async {
    UserModel user = (await locator<PrefrencesViewModel>().getUser())!;
    pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey:
            'sub-c-f77ff5d6-c477-11ec-a5a3-fed9c56767c0',
            //'sub-c-8825eb94-8969-11ec-a04e-822dfd796eb4',
            publishKey:
            'pub-c-086f026a-7f2a-4f5d-ab18-879296d860a7',
            //'pub-c-1f404751-6cfb-44a8-bfea-4ab9102975ac',
            uuid: UUID("${user.id.toString()}")));
  }

  addFavoritedrink1() async {
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

  addFavoriteclub1() async {
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
      //clubList = await Addfavorites().GetFavoritesDrink();
      addNewClubController.clear();
      notifyListeners();
    }
  }

  addFavoritePartyVacation1() async {
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

 Future getAnitherUserInfo(String id) async {
    isLoading = true;

    var getAnotherUserDetails = await getUserInfo.GetAnotherUserInfo(id);
    //print(getAnotherUserDetails);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }ListOfBarsModel
    if (getAnotherUserDetails is UserModel) {
      matchedUser = getAnotherUserDetails;
      //print(matchedUser);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      //return;
    }
    isLoading = false;
    notifyListeners();
    //print(getFaqsList);
  }

  addEventFilters() async {
    addDrink = true;
    notifyListeners();
    //drinkList = await Addfavorites().GetFavoritesDrink();
    var getFiltersEvent = await addBarFilter.BarFilters(
        mapSearchController.text,
        currentEventSelected != null
            ? currentEventSelected! + 1
            : currentEventSelected,
        timeValue,
        lowerValue,
        upperValue);
    if (getFiltersEvent is List<GetEvent>) {
      addFilters = getFiltersEvent;
      // for(var v in listOfUpcomingEvent){
      //   //v.going_users!;
      //   selectUser!.add(v.going_users![0]);
      //   print(selectUser);
      // }
      print(addFilters);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    // if (addFavoriteResponce is FavoritesModel) {
    //   var name = addFavoriteResponce.name;
    //   // drinks = addFavoriteResponce;
    //   drinkList.add(addFavoriteResponce);
    //   notifyListeners();
    // }
    print(addFilters);
    navigateToMapSearchScreen();

    // navigateBack();
    // addDrink = false;
    // drinkList = await Addfavorites().GetFavoritesDrink();
    // addNewDrinkController.clear();
    notifyListeners();
  }

  createGroupChatUser() async {

    if (chatController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Group name is required",
      ));
      return;
    }
    else if (createEventImage!.path.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Group image is required",
      ));
      return;
    }

    addDrink = true;
    notifyListeners();
    //drinkList = await Addfavorites().GetFavoritesDrink();
    String media = "data:${lookupMimeType(createEventImage!.path)};base64," +
        base64Encode(createEventImage!.readAsBytesSync());
    var createGroupUser =
        await createGroup.CreateGroup(
            chatController.text,
            getUserId,
            1,
            media

        );
    if (createGroupUser is List<CreateGroupChat>) {
      getUserGroup = createGroupUser;
      print(getUserGroup);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }

    print(addFilters);
    //navigateToMapSearchScreen();
    notifyListeners();
  }

  updateUsers() async {
    addDrink = true;
    notifyListeners();
    //drinkList = await Addfavorites().GetFavoritesDrink();
    var updateUsers = await createGroup.UpdateGroupUsers(
        chatController.text,
        getUserId,
        userModel!.id.toString(),

    );
    if (updateUsers is CreateGroupChat) {
      groupChatUser = updateUsers;
      print(groupChatUser);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }

    print(addFilters);
    //navigateToMapSearchScreen();
    notifyListeners();
  }

  createGroupChatBar() async {

    if (barGroupNameController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Group name is required",
      ));
      return;
    }

    if (createEventImage!.path.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Group image is required",
      ));
      return;
    }


    addDrink = true;
    notifyListeners();
    String media = "data:${lookupMimeType(createEventImage!.path)};base64," +
        base64Encode(createEventImage!.readAsBytesSync());
    //drinkList = await Addfavorites().GetFavoritesDrink();
    var createGroupUser = await createGroup.CreateGroupBar(

        barGroupNameController.text,
        getUserId,
        1,
        media

    );
    if (createGroupUser is List<CreateGroupChat>) {
      getUserGroup = createGroupUser;
      print(getUserGroup);
    }
    else {
      // DialogUtils().showDialog(MyErrorWidget(
      //   error: "Some thing went wrong",
      // ));
      // //isPrivacyPolicy = false;
      //
      // return;
    }

    print(createGroupUser);
    //navigateToMapSearchScreen();
    notifyListeners();

  }

  getGroupList() async {
    isFaqs = true;

    var getList = await getGroup.GetGroups();
    print(getList);
    // if (getFaqList is String){
    //   faqs = getFaqList;
    //   //isPrivacyPolicy = false;
    //
    // }ListOfBarsModel
    if (getList is List<CreateGroupChat>) {
      getListGroup = getList;
      print(getListGroup);
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;

      return;
    }
    isFaqs = false;
    notifyListeners();
    //print(getFaqsList);
  }


  feedBack() async {

    addDrink = true;
    notifyListeners();
    //drinkList = await Addfavorites().GetFavoritesDrink();
    var feedBack = await feedbackUser.UserFeedback(

        feedbackController.text,

    );
    if (feedBack is UserFeedBack) {
      getMessage = feedBack;
      print(getMessage);
      DialogUtils().showDialog(MyErrorWidget(
        error: "Feedback has been send",
      ));
      addDrink = false;
      feedbackController.clear();
    }
    else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;
      return;
    }
    print(addFilters);
    //navigateToMapSearchScreen();
    notifyListeners();

  }

  postLikeNewsFeed(int index) async {
    isLoading = true;
    notifyListeners();
    bool like = true;
    var userlike = await userLike.NewfeedLike(selectedPost!.id!, like);
    print(userlike);
    if (userlike is LikeNewsFeed) {
      likes = userlike;
      posts[index].likes_count = posts[index].likes_count! + 1;
      posts[index].is_like = true;
      //increment = true;
      //notifyListeners();
      print(likes);
      // DialogUtils().showDialog(MyErrorWidget(
      //   error: "You liked this news feed!",
      // ));
      // isLoading = false;
      // notifyListeners();
    } else {

      //isLoading = true;
      like = false;
      posts[index].likes_count = posts[index].likes_count!  - 1 ;
      posts[index].is_like = false;
      //decrement = true;
      //notifyListeners();

      var userlike = await userLike.NewfeedLike(selectedPost!.id!, like);

      // DialogUtils().showDialog(MyErrorWidget(
      //   error: "You disliked this new feed",
      // ));
      // isLoading = false;
      // notifyListeners();
      //isPrivacyPolicy = false;

      //return;
    }
    isLoading = false;
    notifyListeners();
    //print(getFaqsList);
  }

  Future sendImageMessage(int id) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowMultiple: false,
    );

    if (result != null) {
      File file = File(result.files.first.path!);

      await pubnub!.files.sendFile(getConversationID(
              barModel!.id.toString(),
              id.toString()
      ), result.files.first.name, file.readAsBytesSync().toList(),fileMessage: {
        "userID" : barModel!.id,
        "time" : DateTime.now().toString(),
        "name" : barModel!.username
      }).then((value){
        print(value);
      })
          .catchError((error){
        print(error);
      });
      DialogUtils().showDialog(MyErrorWidget(
        error: "File has been uploaded!",
      ));
    }

  }

  Future sendImageMessageUser(int id ) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowMultiple: false,
    );

    if (result != null) {
      File file = File(result.files.first.path!);

      await pubnub!.files.sendFile(
          getConversationID(
              barModel!.id.toString(),
              id.toString()
          ),
          result.files.first.name, file.readAsBytesSync().toList(),fileMessage: {
        "userID" : userModel!.id,
        "time" : DateTime.now().toString(),
        "name" : userModel!.username
      }).then((value){
        print(value);
        DialogUtils().showDialog(MyErrorWidget(
          error: "File has been uploaded!",
        ));
      })
          .catchError((error){
        print(error);
        if(error.message == "request failed (Out of Memory)")
          {
            DialogUtils().showDialog(MyErrorWidget(
              error: "Request failed, Out of Memory",
            ));
          }
      });
    }
  }

  Future sendImageMessageGrpUser(int id, String username ) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowMultiple: false,
    );

    if (result != null) {
      File file = File(result.files.first.path!);

      await pubnub!.files.sendFile(
          username,
          result.files.first.name, file.readAsBytesSync().toList(),fileMessage: {
        "userID" : userModel!.id,
        "time" : DateTime.now().toString(),
        "name" : userModel!.username
      }).then((value){
        print(value);
        DialogUtils().showDialog(MyErrorWidget(
          error: "File has been uploaded!",
        ));
      })
          .catchError((error){
        print(error);
        if(error.message == "request failed (Out of Memory)")
        {
          DialogUtils().showDialog(MyErrorWidget(
            error: "Request failed, Out of Memory",
          ));
        }
      });
    }
  }

  Future sendImageMessageGrpBar(int id, String username ) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowMultiple: false,
    );

    if (result != null) {
      File file = File(result.files.first.path!);

      await pubnub!.files.sendFile(
          username,
          result.files.first.name, file.readAsBytesSync().toList(),fileMessage: {
        "userID" : barModel!.id,
        "time" : DateTime.now().toString(),
        "name" : barModel!.username
      }).then((value){
        print(value);
        DialogUtils().showDialog(MyErrorWidget(
          error: "File has been uploaded!",
        ));
      })
          .catchError((error){
        print(error);
        if(error.message == "request failed (Out of Memory)")
        {
          DialogUtils().showDialog(MyErrorWidget(
            error: "Request failed, Out of Memory",
          ));
        }
      });
    }
  }

  Future<bool> openCameraUser(int id) async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    _pickedFile = image;
    if (_pickedFile != null) {
      File file = File(_pickedFile!.path);

      await pubnub!.files.sendFile(
          getConversationID(
              userModel!.id.toString(),
              id.toString()
          ),
          _pickedFile!.name, file.readAsBytesSync().toList(),fileMessage: {
        "userID" : userModel!.id,
        "time" : DateTime.now().toString(),
        "name" : userModel!.username
      }).then((value){
        print(value);
        DialogUtils().showDialog(MyErrorWidget(
          error: "File has been uploaded!",
        ));
      })
          .catchError((error){
        print(error);
        if(error.message == "request failed (Out of Memory)")
        {
          DialogUtils().showDialog(MyErrorWidget(
            error: "Request failed, Out of Memory",
          ));
        }
      });
    }
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  Future<bool> openCameraBar(int id) async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    _pickedFile = image;
    if (_pickedFile != null) {
      File file = File(_pickedFile!.path);

      await pubnub!.files.sendFile(
          getConversationID(
              barModel!.id.toString(),
              id.toString()
          ),
          _pickedFile!.name, file.readAsBytesSync().toList(),fileMessage: {
        "userID" : barModel!.id,
        "time" : DateTime.now().toString(),
        "name" : barModel!.username
      }).then((value){
        print(value);
        DialogUtils().showDialog(MyErrorWidget(
          error: "File has been uploaded!",
        ));
      })
          .catchError((error){
        print(error);
        if(error.message == "request failed (Out of Memory)")
        {
          DialogUtils().showDialog(MyErrorWidget(
            error: "Request failed, Out of Memory",
          ));
        }
      });
    }
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  Future<bool> openCameraGrp(int id, String username) async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    _pickedFile = image;
    if (_pickedFile != null) {
      File file = File(_pickedFile!.path);

      await pubnub!.files.sendFile(
          username,
          _pickedFile!.name, file.readAsBytesSync().toList(),fileMessage: {
        "userID" : userModel!.id,
        "time" : DateTime.now().toString(),
        "name" : userModel!.username
      }).then((value){
        print(value);
        DialogUtils().showDialog(MyErrorWidget(
          error: "File has been uploaded!",
        ));
      })
          .catchError((error){
        print(error);
        if(error.message == "request failed (Out of Memory)")
        {
          DialogUtils().showDialog(MyErrorWidget(
            error: "Request failed, Out of Memory",
          ));
        }
      });
    }
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  Future<bool> openCameraGrpBar(int id, String username) async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    _pickedFile = image;
    if (_pickedFile != null) {
      File file = File(_pickedFile!.path);

      await pubnub!.files.sendFile(
          username,
          _pickedFile!.name, file.readAsBytesSync().toList(),fileMessage: {
        "userID" : barModel!.id,
        "time" : DateTime.now().toString(),
        "name" : barModel!.username
      }).then((value){
        print(value);
        DialogUtils().showDialog(MyErrorWidget(
          error: "File has been uploaded!",
        ));
      })
          .catchError((error){
        print(error);
        if(error.message == "request failed (Out of Memory)")
        {
          DialogUtils().showDialog(MyErrorWidget(
            error: "Request failed, Out of Memory",
          ));
        }
      });
    }
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }






  Future<bool> openCamera() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    _pickedFile = image;
    if (_pickedFile != null) {
      profileFileImage = File(_pickedFile!.path);
    }
    // if (_pickedFile != null) {
    //   File file = File(_pickedFile!.path);
    //
    //   await pubnub!.files.sendFile(
    //       username,
    //       _pickedFile!.name, file.readAsBytesSync().toList(),fileMessage: {
    //     "userID" : userModel!.id,
    //     "time" : DateTime.now().toString(),
    //   }).then((value){
    //     print(value);
    //     DialogUtils().showDialog(MyErrorWidget(
    //       error: "File has been uploaded!",
    //     ));
    //   })
    //       .catchError((error){
    //     print(error);
    //     if(error.message == "request failed (Out of Memory)")
    //     {
    //       DialogUtils().showDialog(MyErrorWidget(
    //         error: "Request failed, Out of Memory",
    //       ));
    //     }
    //   });
    // }
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  // getUserDetails

   String? userGender;
   dynamic userGenderValue;

   String? currentRelation;
   dynamic currentRelationValue;

   UserModel? currentUserResponse;

  usersDetails() async {
    isUserProfile = true;
     List usersGender = [];
     List usersRelation = [];
    //UserModel? user = await locator<PrefrencesViewModel>().getUser();
    List<UserModel> response = await currentUserDetails.GetUserDetails();
    currentUserResponse = response[0];
    notifyListeners();
     usersGender.add(response.map((e) => e.gender).first) ;
     userGender = usersGender[0];
     usersRelation.add(response.map((e) => e.relation_ship).first) ;
     currentRelation = usersRelation[0];
     notifyListeners();
     isUserProfile = false;
  }

  setValues(){
    if(userGender == "Male"){
      userGenderValue = 1;
      notifyListeners();
    }
    else if(userGender == "Female"){
      userGenderValue = 2;
      notifyListeners();
    }
    if(currentRelation == "Single"){
      currentRelationValue = 1;
      notifyListeners();
    }
    else if(currentRelation == "Married"){
      currentRelationValue = 2;
      notifyListeners();
    }
    else if(currentRelation == "Relationship"){
      currentRelationValue = 3;
      notifyListeners();
    }
    else if(currentRelation == "Open Relationship"){
      currentRelationValue = 4;
      notifyListeners();
    }
    else if(currentRelation == "it's complicated"){
      currentRelationValue = 5;
      notifyListeners();
    }
  }

  updatingUser() async {
    editProfile = true;
    notifyListeners();
    List tempList = [];
    for (int i = 0;i<6;i++)
    {
      if(i<imageFiles.length){
        tempList.add(imageFiles[i]);
      }
      else{
        tempList.add(File(""));
      }
    }

    var  response = await updateUserDetails.updateUser(
        currentUserResponse!.id!,
        currentUserResponse!.phone_no!,
        updateUserAbout.text,
        userGenderValue,
        currentUserResponse!.address!,
        currentUserResponse!.dob!,
        currentRelationValue  /*== "Single" ? 1 :
        currentUserResponse!.relation_ship == "Married" ? 2 :
        currentUserResponse!.relation_ship == "Relationship" ? 3 :
        currentUserResponse!.relation_ship == "Open Relationship" ? 4 : 5*/ ,
        currentUserResponse!.role!,
        selectedDrinkList,
        selectedClubList,
        selectedVacationList,
        //currentUserResponse!.profile_picture!,
        tempList,
        true,
        true,
    );
    print(response);
    if (response is UserModel) {
      UserModel user = response;
      user.about = user.about!;


      user.token = userModel!.token!;
      userModel = user;
      await prefrencesViewModel.saveUser(user);
    }
    //await prefrencesViewModel.saveUser(user);
    editProfile = false;
    notifyListeners();
    navigateToUserProfileScreen();
  }

  XFile? _createEventPickedFile;
  File? createEventImage;

  Future<bool> createEventGetImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    _createEventPickedFile = image;
    createEventImage = File(_createEventPickedFile!.path);
    if (createEventImage == null) {
      return false;
    } else {
      //bannerImageSelected = true;
      //createEventImages.add(createEventImage);
      notifyListeners();
      return true;
    }}

  postingComments() async {
    isLoading = true;
    notifyListeners();
    if(postCommentController.text.isNotEmpty){
      var userComments = await postComments.postComments(postCommentController.text, selectedCommentId!);
      if(userComments == NewsfeedComments){
        getBarPost();
      }
    }
    else{
      DialogUtils().showDialog(MyErrorWidget(
        error: "Enter Some Text",
      ));
    }
    isLoading = false;
    notifyListeners();
    //print(getFaqsList);
  }

  postingCommentsBar() async {
    isLoading = true;
    notifyListeners();
    if(postCommentController.text.isNotEmpty){
      var barComments = await postComments.postCommentsBar(postCommentController.text, selectedCommentId!);
      if(barComments == NewsfeedCommentsBar){
        getBarPost();
      }
    }
    else{
      DialogUtils().showDialog(MyErrorWidget(
        error: "Enter Some Text",
      ));
    }
    isLoading = false;
    notifyListeners();
    //print(getFaqsList);
  }

  gettingComments() async {
    isLoading = true;
    userComments = await getComments.getComments(selectedCommentId!);
    print(userComments);
    isLoading = false;
    //print(getFaqsList);
  }

  gettingCommentsBars() async {
    isLoading = true;
    barComments = await getComments.getCommentsBar(selectedCommentId!);
    print(barComments);
    isLoading = false;
    //print(getFaqsList);
  }

  getCommentNewsFeed(int index) async {
    isLoading = true;
    notifyListeners();
    var userComments = await getComments.getComments(selectedCommentId!);
    if (userComments != null) {
      posts[index].comments_count = posts[index].comments_count! + 1;
      notifyListeners();
      //feedbackController.clear();

      // var index = listOfAllBars.indexOf();
      // listOfAllBars[index].like =
      // (getListofbar as LikeNewsFeed).user!.like!;
    } else {
      //isLoading = true;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Something went wrong",
      ));
      //notifyListeners();
      //isPrivacyPolicy = false;

      //return;
    }
    isLoading = false;
    notifyListeners();
    //print(getFaqsList);
  }

  getCommentNewsFeedBar(int index) async {
    isLoading = true;
    notifyListeners();
    var barComments = await getComments.getCommentsBar(selectedCommentId!);
    if (barComments != null) {
      posts[index].comments_count = posts[index].comments_count! + 1;
      notifyListeners();
      //feedbackController.clear();

      // var index = listOfAllBars.indexOf();
      // listOfAllBars[index].like =
      // (getListofbar as LikeNewsFeed).user!.like!;
    } else {
      //isLoading = true;
      DialogUtils().showDialog(MyErrorWidget(
        error: "Something went wrong",
      ));
      //notifyListeners();
      //isPrivacyPolicy = false;

      //return;
    }
    isLoading = false;
    notifyListeners();
    //print(getFaqsList);
  }

  reportUserIndChat() async {

    addDrink = true;
    notifyListeners();
    //drinkList = await Addfavorites().GetFavoritesDrink();
    var report = await postUserChat.UserReportChat(



    );
    if (report is ReportChat) {
     // getMessage = feedBack;
      print(getMessage);
      DialogUtils().showDialog(MyErrorWidget(
        error: "Report has been sent",
      ));
      addDrink = false;
      //feedbackController.clear();
    }
    else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;
      return;
    }
    print(addFilters);
    //navigateToMapSearchScreen();
    notifyListeners();

  }

  reportBarIndChat() async {

    addDrink = true;
    notifyListeners();
    //drinkList = await Addfavorites().GetFavoritesDrink();
    var report = await postUserChat.BarReportChat(

    );
    if (report is ReportChat) {
      // getMessage = feedBack;
      print(getMessage);
      DialogUtils().showDialog(MyErrorWidget(
        error: "Report has been sent",
      ));
      addDrink = false;
      //feedbackController.clear();
    }
    else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      //isPrivacyPolicy = false;
      return;
    }
    print(addFilters);
    //navigateToMapSearchScreen();
    notifyListeners();

  }


  Timer? _timer;
  Timer? _ampTimer;
  bool _isRecording = false;
  File? file;
  String? sdPath;
  final audioRecorder = Record();
  bool recordPressed = false;
  bool record = false;

  initializeRecording(){
    _isRecording = false;
  }

  disposeRecording(){
    _timer?.cancel();
    _ampTimer?.cancel();
    audioRecorder.dispose();
  }


  ///----------Audio recorder for user ------------///

  start() async {
    try {
      if (await audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        // final isSupported = await audioRecorder.isEncoderSupported(
        //   AudioEncoder.aacLc,
        // );
        // if (kDebugMode) {
        //   print('${AudioEncoder.aacLc.name} supported: $isSupported');
        // }

        getFilePath();
        await audioRecorder.start(
            encoder: AudioEncoder.AAC,
            path: Platform.isAndroid?null:sdPath!
        );


        // bool isRecording = await audioRecorder.isRecording();
        // await audioRecorder.stop();
        //isRecording = isRecording;
        //recordDuration = 0;
        notifyListeners();
        // setState(() {
        //   _isRecording = isRecording;
        //   _recordDuration = 0;
        // });

        //_startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  stop(int id) async {
    _timer?.cancel();
    _ampTimer?.cancel();
    _isRecording = false;
    file = await File((await audioRecorder.stop())!).create();
    await pubnub!.files.sendFile(getConversationID(
        userModel!.id.toString(),
        id.toString()
    ), "abc.mp3", file!.readAsBytesSync().toList(),fileMessage: {
      "userID" : userModel!.id,
      "time" : DateTime.now().toString(),
      "name" : userModel!.username
    }).then((value){
      print(value);
    })
        .catchError((error){
      print(error);
    });
    DialogUtils().showDialog(MyErrorWidget(
      error: "Voice has been uploaded!",
    ));
    // File test = await File(file!.path);
    // test.writeAsBytesSync(await file!.readAsBytesSync());
    // file = test;
    notifyListeners();
    //await firebaseChat.uploadRecording(attendeeFbId, otherUserId);
    notifyListeners();
    //widget.onStop(path!);
    //setState(() => _isRecording = false);
  }

  int i = 0;

  getFilePath() async {
    var storageDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    sdPath = await storageDirectory!.path + "/record/audio.mp4";
    notifyListeners();
    //var d = Directory(sdPath!);
    // if (!d.existsSync()) {
    //   d.createSync(recursive: true);
    // }
    //return sdPath! + "/test_${i++}.mp3";
  }


  ///------------- Audio Recorder for bar------------///

  startBarVoiceRecord() async {
    try {
      if (await audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        // final isSupported = await audioRecorder.isEncoderSupported(
        //   AudioEncoder.aacLc,
        // );
        // if (kDebugMode) {
        //   print('${AudioEncoder.aacLc.name} supported: $isSupported');
        // }

        getFilePath();
        await audioRecorder.start(
            encoder: AudioEncoder.AAC,
            path: Platform.isAndroid?null:sdPath!
        );


        // bool isRecording = await audioRecorder.isRecording();
        // await audioRecorder.stop();
        //isRecording = isRecording;
        //recordDuration = 0;
        notifyListeners();
        // setState(() {
        //   _isRecording = isRecording;
        //   _recordDuration = 0;
        // });

        //_startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  stopBarVoiceRecord(int id) async {
    _timer?.cancel();
    _ampTimer?.cancel();
    _isRecording = false;
    //print((await audioRecorder.stop())!);
    file = await File((await audioRecorder.stop())!).create();
    await pubnub!.files.sendFile(getConversationID(
        barModel!.id.toString(),
        id.toString()
    ), "abc.mp3", file!.readAsBytesSync().toList(),fileMessage: {
      "userID" : barModel!.id,
      "time" : DateTime.now().toString(),
      "name" : barModel!.username
    }).then((value){
      print(value);
    })
        .catchError((error){
      print(error);
    });
    DialogUtils().showDialog(MyErrorWidget(
      error: "Voice has been uploaded!",
    ));
    // File test = await File(file!.path);
    // test.writeAsBytesSync(await file!.readAsBytesSync());
    // file = test;
    notifyListeners();
    //await firebaseChat.uploadRecording(attendeeFbId, otherUserId);
    notifyListeners();
    //widget.onStop(path!);
    //setState(() => _isRecording = false);
  }

  int j = 0;

  getFilePathBarVoiceRecord() async {
    var storageDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    sdPath = await storageDirectory!.path + "/record/audio.mp4";
    notifyListeners();
    //var d = Directory(sdPath!);
    // if (!d.existsSync()) {
    //   d.createSync(recursive: true);
    // }
    //return sdPath! + "/test_${i++}.mp3";
  }


  ///-------------Audio recorder for user group chat--------------///

  startGroupVoice() async {
    try {
      if (await audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        // final isSupported = await audioRecorder.isEncoderSupported(
        //   AudioEncoder.aacLc,
        // );
        // if (kDebugMode) {
        //   print('${AudioEncoder.aacLc.name} supported: $isSupported');
        // }

        getFilePath();
        await audioRecorder.start(
            encoder: AudioEncoder.AAC
        );


        // bool isRecording = await audioRecorder.isRecording();
        // await audioRecorder.stop();
        //isRecording = isRecording;
        //recordDuration = 0;
        notifyListeners();
        // setState(() {
        //   _isRecording = isRecording;
        //   _recordDuration = 0;
        // });

        //_startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  stopGroupVoice(int id, String username) async {
    _timer?.cancel();
    _ampTimer?.cancel();
    _isRecording = false;
    file = await File((await audioRecorder.stop())!).create();

    await pubnub!.files.sendFile(
        username,
        "abc.mp3", file!.readAsBytesSync().toList(),fileMessage: {
        "userID" : userModel!.id,
        "time" : DateTime.now().toString(),
      "name" : userModel!.username
    }).then((value){
      print(value);
    })
        .catchError((error){
      print(error);
    });
    DialogUtils().showDialog(MyErrorWidget(
      error: "Voice has been uploaded!",
    ));
    // File test = await File(file!.path);
    // test.writeAsBytesSync(await file!.readAsBytesSync());
    // file = test;
    notifyListeners();
    //await firebaseChat.uploadRecording(attendeeFbId, otherUserId);
    notifyListeners();
    //widget.onStop(path!);
    //setState(() => _isRecording = false);
  }

  int k = 0;

  getFilePathGroupVoice() async {
    var storageDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    sdPath = await storageDirectory!.path + "/record/audio.mp4";
    notifyListeners();
    //var d = Directory(sdPath!);
    // if (!d.existsSync()) {
    //   d.createSync(recursive: true);
    // }
    //return sdPath! + "/test_${i++}.mp3";
  }


  ///------------ Audio recorder for bar group chat ----------------///

  startGroupVoiceBar() async {
    try {
      if (await audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        // final isSupported = await audioRecorder.isEncoderSupported(
        //   AudioEncoder.aacLc,
        // );
        // if (kDebugMode) {
        //   print('${AudioEncoder.aacLc.name} supported: $isSupported');
        // }

        getFilePath();
        await audioRecorder.start(
            encoder: AudioEncoder.AAC
        );


        // bool isRecording = await audioRecorder.isRecording();
        // await audioRecorder.stop();
        //isRecording = isRecording;
        //recordDuration = 0;
        notifyListeners();
        // setState(() {
        //   _isRecording = isRecording;
        //   _recordDuration = 0;
        // });

        //_startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  stopGroupVoiceBar(int id, String username) async {
    _timer?.cancel();
    _ampTimer?.cancel();
    _isRecording = false;
    file = await File((await audioRecorder.stop())!).create();

    await pubnub!.files.sendFile(
        username,
        "abc.mp3", file!.readAsBytesSync().toList(),fileMessage: {
      "userID" : barModel!.id,
      "time" : DateTime.now().toString(),
      "name" : barModel!.username
    }).then((value){
      print(value);
    })
        .catchError((error){
      print(error);
    });
    DialogUtils().showDialog(MyErrorWidget(
      error: "Voice has been uploaded!",
    ));
    // File test = await File(file!.path);
    // test.writeAsBytesSync(await file!.readAsBytesSync());
    // file = test;
    notifyListeners();
    //await firebaseChat.uploadRecording(attendeeFbId, otherUserId);
    notifyListeners();
    //widget.onStop(path!);
    //setState(() => _isRecording = false);
  }

  int l = 0;

  getFilePathGroupVoiceBar() async {
    var storageDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    sdPath = await storageDirectory!.path + "/record/audio.mp4";
    notifyListeners();
    //var d = Directory(sdPath!);
    // if (!d.existsSync()) {
    //   d.createSync(recursive: true);
    // }
    //return sdPath! + "/test_${i++}.mp3";
  }






}


