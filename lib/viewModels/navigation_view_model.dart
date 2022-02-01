
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/bar/views/Auth/barTimingType.dart';
import 'package:sauftrag/bar/views/Auth/media.dart';
import 'package:sauftrag/bar/views/Auth/signUp.dart';
import 'package:sauftrag/bar/views/Drawer/barEvent.dart';
import 'package:sauftrag/bar/views/Drawer/barProfile.dart';
import 'package:sauftrag/bar/views/Drawer/bar_Rating.dart';
import 'package:sauftrag/bar/views/Drawer/bar_all_rating.dart';
import 'package:sauftrag/bar/views/Drawer/follower_profile.dart';
import 'package:sauftrag/bar/views/Drawer/followers.dart';
import 'package:sauftrag/bar/views/Drawer/list_of_bar.dart';
import 'package:sauftrag/bar/views/Drawer/matched_screen.dart';
import 'package:sauftrag/bar/views/Drawer/notifications.dart';
import 'package:sauftrag/bar/views/Drawer/qr_code_scanner.dart';
import 'package:sauftrag/bar/views/Drawer/ranking_list.dart';
import 'package:sauftrag/bar/views/Drawer/upcoming_event.dart';
import 'package:sauftrag/bar/views/Home/bar_create_post.dart';
import 'package:sauftrag/bar/views/Home/bar_news_feed.dart';
import 'package:sauftrag/bar/views/Home/main_view.dart';
import 'package:sauftrag/bar/views/Home/order_details.dart';
import 'package:sauftrag/bar/views/Profile/bar_account_ownership.dart';
import 'package:sauftrag/bar/views/Profile/bar_accounts.dart';
import 'package:sauftrag/bar/views/Profile/bar_details.dart';
import 'package:sauftrag/bar/views/Profile/bar_profile.dart';
import 'package:sauftrag/bar/views/Home/bar_event.dart';
import 'package:sauftrag/views/Auth/check_email.dart';
import 'package:sauftrag/views/Auth/favorite.dart';
import 'package:sauftrag/views/Auth/forget_password.dart';
import 'package:sauftrag/views/Auth/login.dart';
import 'package:sauftrag/views/Auth/media.dart';
import 'package:sauftrag/views/Auth/resent_password.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/views/Auth/terms.dart';
import 'package:sauftrag/views/Auth/verification_code.dart';
import 'package:sauftrag/views/Home/main_view.dart';
import 'package:sauftrag/views/Home/match.dart';
import 'package:sauftrag/views/Home/profile.dart';
import 'package:sauftrag/views/Home/swipe.dart';
import 'package:sauftrag/views/MapSearch/map_screen.dart';
import 'package:sauftrag/views/MapSearch/search.dart';
import 'package:sauftrag/views/NewsFeed/all_event_list.dart';
import 'package:sauftrag/views/NewsFeed/upcoming_event_list.dart';
import 'package:sauftrag/views/UserFriendList/create_group.dart';
import 'package:sauftrag/views/UserFriendList/friend_list.dart';
import 'package:sauftrag/views/NewsFeed/event_detail.dart';
import 'package:sauftrag/views/UserFriendList/group_details.dart';
import 'package:sauftrag/views/UserFriendList/group_screen.dart';
import 'package:sauftrag/views/UserFriendList/invite_people.dart';
import 'package:sauftrag/views/UserFriendList/message_screen.dart';
import 'package:sauftrag/views/UserFriendList/select_individual_chat.dart';
import 'package:sauftrag/views/UserProfile/account.dart';
import 'package:sauftrag/views/UserProfile/accountOwnership.dart';
import 'package:sauftrag/widgets/change_password.dart';
import 'package:sauftrag/views/UserProfile/gps.dart';
import 'package:sauftrag/views/UserProfile/legalTerm.dart';
import 'package:sauftrag/views/UserProfile/notifications.dart';
import 'package:sauftrag/views/UserProfile/user_details.dart';
import 'package:sauftrag/widgets/bar_auth_viewmodel.dart';
import 'package:sauftrag/widgets/zoom_drawer.dart';
import 'package:stacked/stacked.dart';

class NavigationViewModel extends BaseViewModel{

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  void navigateToLoginScreen(){
    navigationKey.currentState!.pushReplacement(PageTransition(child: Login(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToSignUpScreen(){
    navigationKey.currentState!.push(PageTransition(child: SignUp(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarSignUpScreen(){
    navigationKey.currentState!.push(PageTransition(child: SignUpBar(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToUploadBarMedia(){
    navigationKey.currentState!.push(PageTransition(child: BarMedia(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToFavoriteScreen(){
    navigationKey.currentState!.push(PageTransition(child: Favorite(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarProfileScreen(){
    navigationKey.currentState!.push(PageTransition(child: BarProfile(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToMediaScreen(){
    navigationKey.currentState!.push(PageTransition(child: Media(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToTermsScreen(){
    navigationKey.currentState!.push(PageTransition(child: TermsOfService(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToCreateEventScreen(){
    navigationKey.currentState!.push(PageTransition(child: CreateBarEvent(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarEventScreen(){
    navigationKey.currentState!.push(PageTransition(child: BarEvent(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToNotificationScreen(){
    navigationKey.currentState!.push(PageTransition(child: Notifications(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToFollowersListScreen(){
    navigationKey.currentState!.push(PageTransition(child: Followers(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToForgetPasswordScreen(){
    navigationKey.currentState!.push(PageTransition(child: ForgetPassword(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToCheckEmailScreen(){
    navigationKey.currentState!.push(PageTransition(child: CheckEmail(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToResentPasswordScreen(){
    navigationKey.currentState!.push(PageTransition(child: ResentPassword(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToVerificationCodeScreen(){
    navigationKey.currentState!.push(PageTransition(child: VerificationCode(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarHomeScreen(){
    navigationKey.currentState!.push(PageTransition(child: ZoomDrawerHome(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToHomeScreen(int index){
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: MainView(index: 3), type: PageTransitionType.rightToLeftWithFade),(Route<dynamic> route) => false);
  }

  void navigateToHomeBarScreen(){
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: MainViewBar(index: 0), type: PageTransitionType.rightToLeftWithFade),(Route<dynamic> route) => false);
  }

  void navigateToMapScreen(int index){
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: MainView(index: index), type: PageTransitionType.rightToLeftWithFade),(Route<dynamic> route) => false);
  }

  void navigateToProfileScreen(List<String> images){
    navigationKey.currentState!.push(PageTransition(child: Profile(images: images), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToMatchScreen(){
    navigationKey.currentState!.push(PageTransition(child: Match(), type: PageTransitionType.rightToLeftWithFade));
  }

  // void navigateToFriendListScreen(){
  //   navigationKey.currentState!.push(PageTransition(child: FriendList(), type: PageTransitionType.rightToLeftWithFade));
  // }

  void navigateToFriendListScreen1(){
    navigationKey.currentState!.push(PageTransition(child: MainViewBar(index: 1), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToFriendListScreen(){
    navigationKey.currentState!.push(PageTransition(child: MainView(index: 1), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToMsgCreateGroupScreen(){
    navigationKey.currentState!.push(PageTransition(child: CreateGroup(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToInvitePeopleScreen(){
    navigationKey.currentState!.push(PageTransition(child: InvitePeople(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarTimingTypeScreen(){
    navigationKey.currentState!.push(PageTransition(child: BarTimingAndType(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToOrderDetailsScreen(){
    navigationKey.currentState!.push(PageTransition(child: OrderDetails(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToSwipeScreen(){
    navigationKey.currentState!.push(PageTransition(child: MainView(index: 2), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateBack(){
    navigationKey.currentState!.pop();
  }

  void navigateToGroupDetail(){
    navigationKey.currentState!.push(PageTransition(child: GroupDetails(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToGroupScreen(){
    navigationKey.currentState!.push(PageTransition(child: GroupScreen(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToUserProfileAccountScreen(){
    navigationKey.currentState!.push(PageTransition(child: Account(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToUserProfileAccountOwnershipScreen(){
    navigationKey.currentState!.push(PageTransition(child: BarAccountOwnership(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToUserProfileAccountNotificationScreen(){
    navigationKey.currentState!.push(PageTransition(child: UserNotifications(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToUserProfileAccountLegalTermScreen(){
    navigationKey.currentState!.push(PageTransition(child: LegalTerm(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToUserProfileAccountGpsScreen(){
    navigationKey.currentState!.push(PageTransition(child: GPS(), type: PageTransitionType.rightToLeftWithFade));
  }


  void navigateAndRemoveSignInScreen(){
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: Login(), type: PageTransitionType.rightToLeftWithFade), (route) => false);
  }
  void navigateToEventDetailScreen(){
    navigationKey.currentState!.push(PageTransition(child: EventDetails(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToMapSearchScreen(){
    navigationKey.currentState!.push(PageTransition(child: Search(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToUserDetailSettings(){
    navigationKey.currentState!.push(PageTransition(child: UserDetails(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToUpcomingBarEventScreen(){
    navigationKey.currentState!.push(PageTransition(child: UpcomingBarEvent(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToAllEventListScreen(){
    navigationKey.currentState!.push(PageTransition(child: AllEventList(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToChangePassword(){
    navigationKey.currentState!.push(PageTransition(child: ChangePassword(), type: PageTransitionType.rightToLeftWithFade));
  }


///----Drawer------////
  void navigateToRatingList(){
    navigationKey.currentState!.push(PageTransition(child: RatingList(), type: PageTransitionType.rightToLeftWithFade));

  }
  void navigateToMatchedList(){
    navigationKey.currentState!.push(PageTransition(child: MatchedScreen(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToFollowerList(){
    navigationKey.currentState!.push(PageTransition(child: FollowerProfile(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToListOfBar(){
    navigationKey.currentState!.push(PageTransition(child: ListOfBar(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToBarProfile(){
    navigationKey.currentState!.push(PageTransition(child: Barprofile(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToUserBarCodeScanner(){
    navigationKey.currentState!.push(PageTransition(child: QRCodeScanner(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToUpcomingEvent(){
    navigationKey.currentState!.push(PageTransition(child: UpcomingEvent(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToMessageScreen(){
    navigationKey.currentState!.push(PageTransition(child: MessageScreen(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToSelectIndividualChatScreen(){
    navigationKey.currentState!.push(PageTransition(child: SelectIndividualChat(), type: PageTransitionType.rightToLeftWithFade));
  }





  ///------------------Bar Profile ---------------------------------///

  void navigateToBarProfile2(){
    navigationKey.currentState!.push(PageTransition(child: BarRating(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToAllBarRating(){
    navigationKey.currentState!.push(PageTransition(child: BarAllRating(), type: PageTransitionType.rightToLeftWithFade));

  }

///-----------------Bar Profile --------------------------------------///
  void navigateToBarDetails(){
    navigationKey.currentState!.push(PageTransition(child: BarDetail(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarAccounts(){
    navigationKey.currentState!.push(PageTransition(child: BarAccount(), type: PageTransitionType.rightToLeftWithFade));

  }

  void navigateToBarAccountOwnerShip(){
    navigationKey.currentState!.push(PageTransition(child: BarAccountOwnership(), type: PageTransitionType.rightToLeftWithFade));
  }

  void navigateToBarPostScreen(){
    navigationKey.currentState!.push(PageTransition(child: BarCreatePost(), type: PageTransitionType.rightToLeftWithFade));
  }











/*void navigateToWelcomeScreen(){
    navigationKey.currentState!.pushReplacement(PageTransition(child: Welcome(), type: PageTransitionType.fade));
  }

  void navigateToHomeScreen(int index){
    //navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: Home(), type: PageTransitionType.fade),(Route<dynamic> route) => false);
    navigationKey.currentState!.pushAndRemoveUntil(PageTransition(child: MainView(index: index), type: PageTransitionType.fade),(Route<dynamic> route) => false);
  }

  void navigateToRegisterScreen(int from){
    navigationKey.currentState!.push(PageTransition(child: Register(from: from), type: PageTransitionType.fade));
  }

  void navigateBack(){
    navigationKey.currentState!.pop(PageTransition(child: UserDetails(), type: PageTransitionType.fade));
  }*/
}