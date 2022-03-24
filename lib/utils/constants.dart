class Constants {
  static const String lang = "EN";
  static const int user = 1;
  static const int bar = 2;
  //Pro Env
 // static const String BaseUrlPro = 'http://sauftragpro-environment.eba-4pafy8hm.ap-southeast-1.elasticbeanstalk.com/';
  //Dev Env
  static const String BaseUrlPro ='http://sauftragdev-environment.eba-yb3ya83i.ap-southeast-1.elasticbeanstalk.com/';
  static const String BaseUrl = 'sauftragdev-environment.eba-yb3ya83i.ap-southeast-1.elasticbeanstalk.com';
  //static const String BaseUrl = 'sauftragpro-environment.eba-4pafy8hm.ap-southeast-1.elasticbeanstalk.com';
  static const String SignUp = 'api/user/register/';
  static const String AllUsers = 'api/user/all/';
  static const String kGoogleApiKey = "AIzaSyDOmwYa7kxedwhjxFlxMHGyeJKdGS4qQ1U";
  static const String Login = 'api/user/login/';
  static const String ForgetPassword = 'api/user/password_reset_confirm/';
  static const String ResetPassword = 'api/user/password_reset_code_confirm/';
  static const String ConfirmNewPassword = 'api/user/forgot-password/';
  static const String CheckUser = 'api/user/check/';
  static const String ChangeUserPassword = 'api/user/change-password/';
  static const String UpdateUserProfile = 'api/user/register/';
  static const String UpdateBarProfile = 'api/user/register/';
  static const String AddFavoriteDrink = 'api/favorites/alcoholic_drink/';
  static const String AddFavoriteClub = 'api/favorites/night_club/';
  static const String AddFavoritePartyVacation = 'api/favorites/party_vaccation/';
  static const String AddressBook = 'api/invite/by-contact/';
  static const String QRCode = 'api/order/scan_qrcode/';
  static const String drinkStatus = 'api/user/drinkStatus/';
  static const String discover = 'api/user/discover/';
  static const String FollowBar = 'api/user/follow/';
  static const String CreateGrouppChat = 'api/group/create/';
  static const String AttendEvent = 'api/event/attend/';
  static const String RemoveAttendEvent = 'api/event/not_attend/';
  static const String filterEvents = 'api/filters/';

  static const String GetFavoriteDrink = 'api/favorites/alcoholic_drink/';
  static const String GetFavoriteClub = 'api/favorites/night_club/';
  static const String GetFavoritePartyVacation =
      'api/favorites/party_vaccation/';
  static const String CreateNewFeed = 'api/news_feed/add/';
  static const String GetNewFeed = 'api/news_feed/add/';
  static const String GetPrivacyPolicy = 'api/other/privacy-policy/';
  static const String GetTermsAndConditions = 'api/other/terms/';
  static const String GetDataProtection = 'api/other/data-protection/';
  static const String GetFaqs = 'api/other/FAQs/';
  static const String order = 'api/order/create/';
  static const String GetMatches = 'api/user/match/';
  static const String GetListOfBar = 'api/user/getBarProfile/';
  static const String GetUserToUserInfo = 'api/user/getAnotherUserProfile/';
  static const String GetUpcomingEvents = 'api/event/upcoming/';
  static const String GetPastEvent = 'api/event/past/';

  static const String accountDelete = 'api/account/delete/';
  static const String accountDeactivate = 'api/account/deactivate/';
  static const String followersList = 'api/followers/list/';
  static const String rating = 'api/rating/add/';
  static const String allUserForChat = 'api/user/all/';
  static const String giveRating = 'api/rating/add/';
  // static const String drinkStatus = 'api/user/drinkStatus/';
  static const String drinkStatuscheck = '/api/user/drinkStatus/';
  static const String GETdrinkStatus = 'api/user/drinkStatus/';
  static const String GetEvents = BaseUrlPro + 'api/event/add/';
  static const String GetDiscover = BaseUrlPro + 'api/user/discover/';
  static const String matchUser = BaseUrlPro + 'api/user/match/';
  static const String requestMatchUser =
      BaseUrlPro + 'api/user/requestedMatch/';
  static const String requestAccept =
      BaseUrlPro + 'api/user/acceptMatchRequest/';

  static const String requestDelete =
      BaseUrlPro + 'api/user/deleteMatchRequest/';



  static const int profileImage = 1;

  static final int camera = 1;
  static final int gallery = 2;
}
