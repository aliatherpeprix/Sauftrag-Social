import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/services/addFavorites.dart';
import 'package:sauftrag/services/updateUserProfile.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:stacked/stacked.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.topMargin),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Settings",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 3.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),

                      ///--------------Event Name--------------------///
                      GestureDetector(
                        onTap: () async {
                          model.isUserProfile = true;
                          model.notifyListeners();
                          model.navigateToUserDetailSettings();
                          PrefrencesViewModel prefs =
                              locator<PrefrencesViewModel>();
                          model.drinkList =
                              await Addfavorites().GetFavoritesDrink();
                          model.clubList =
                              await Addfavorites().GetFavoritesClub();
                          model.vacationList =
                              await Addfavorites().GetFavoritesPartyVacation();
                          model.userModel = (await prefs.getUser())!;
                          if (model.userModel!.profile_picture != null &&
                              model.userModel!.profile_picture!.isNotEmpty) {
                            model.imageFiles.removeAt(0);
                            model.imageFiles
                                .insert(0, model.userModel!.profile_picture!);
                          }
                          if (model.userModel!.catalogue_image1 != null &&
                              model.userModel!.catalogue_image1!.isNotEmpty) {
                            model.imageFiles.removeAt(1);
                            model.imageFiles
                                .insert(1, model.userModel!.catalogue_image1!);
                          }
                          if (model.userModel!.catalogue_image2 != null &&
                              model.userModel!.catalogue_image2!.isNotEmpty) {
                            model.imageFiles.removeAt(2);
                            model.imageFiles
                                .insert(2, model.userModel!.catalogue_image2!);
                          }
                          if (model.userModel!.catalogue_image3 != null &&
                              model.userModel!.catalogue_image3!.isNotEmpty) {
                            model.imageFiles.removeAt(3);
                            model.imageFiles
                                .insert(3, model.userModel!.catalogue_image3!);
                          }
                          if (model.userModel!.catalogue_image4 != null &&
                              model.userModel!.catalogue_image4!.isNotEmpty) {
                            model.imageFiles.removeAt(4);
                            model.imageFiles
                                .insert(4, model.userModel!.catalogue_image4!);
                          }
                          if (model.userModel!.catalogue_image5 != null &&
                              model.userModel!.catalogue_image5!.isNotEmpty) {
                            model.imageFiles.removeAt(5);
                            model.imageFiles
                                .insert(5, model.userModel!.catalogue_image5!);
                          }
                          model.isUserProfile = false;
                          model.notifyListeners();
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      //color: ColorUtils.red_color,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorUtils.black
                                              .withOpacity(0.12),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    // onPressed: () {
                                    //  /* showDialog(
                                    //       context: context,
                                    //       builder: (BuildContext context){
                                    //         return DrinkStatusDialogBox(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                    //       }
                                    //   );*/
                                    // },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image(
                                          image: NetworkImage(model
                                              .userModel!.profile_picture!),
                                          fit: BoxFit.cover,
                                          height: 15.i,
                                          width: 15.i,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.only(right: 20),
                                  //   child: RoundImage(
                                  //     url: widget.profile.imageurl,
                                  //     txtsize: 18,
                                  //     txt: widget.profile.fullName,
                                  //     width: 50,
                                  //     height: 50,
                                  //     borderRadius: 15,
                                  //   ),
                                  // ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 35.w,
                                        child: Text(
                                          model.userModel!.username!,
                                          style: TextStyle(
                                            color: ColorUtils.black,
                                            fontFamily: FontUtils.modernistBold,
                                            fontSize: 2.t,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        model.userModel!.phone_no!,
                                        style: TextStyle(
                                          color: ColorUtils.text_grey,
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 1.7.t,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 30,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: ColorUtils.text_red,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageUtils.levelStar,
                              height: 20.i,
                              width: 20.i,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Level 21",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      color: Colors.white,
                                      fontSize: 2.5.t,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 2.h,
                                  // ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      "You are just 25 points away to reach next level",
                                      style: TextStyle(
                                        fontFamily: FontUtils.modernistRegular,
                                        color: Colors.white,
                                        fontSize: 1.6.t,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: SizedBox(
                                        height: 8,
                                        child: LiquidLinearProgressIndicator(
                                          value: 0.45,
                                          // Defaults to 0.5.
                                          valueColor: AlwaysStoppedAnimation(
                                              ColorUtils.settingsProgress),
                                          // Defaults to the current Theme's accentColor.
                                          backgroundColor: Colors.white,
                                          // Defaults to the current Theme's backgroundColor.
                                          //borderColor: Colors.red, //border color of the bar
                                          //borderWidth: 5.0, //border width of the bar
                                          borderRadius: 12.0,
                                          //border radius
                                          direction: Axis.horizontal,
                                          // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                          //center: Text("50%"), //text inside bar
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),

                      ///--------------Settings Options--------------------///
                      ExpandTapWidget(
                        onTap: () async {
                          model.isUserProfile = true;
                          model.notifyListeners();
                          PrefrencesViewModel prefs = await locator<PrefrencesViewModel>();
                           await Updateuser().UpdateAccountDetails(model.updateSignUpPhoneController.text, model.updateLocations.text);
                          model.userModel = (await prefs.getUser())!;
                          model.navigateToUserProfileAccountScreen();
                          model.isUserProfile = false;
                          model.notifyListeners();
                        },
                        tapPadding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.userProfileAccount),
                                SizedBox(
                                  width: 1.5.h,
                                ),
                                Text(
                                  "Accounts",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      ExpandTapWidget(
                        onTap: () {
                          model
                              .navigateToUserProfileAccountNotificationScreen();
                        },
                        tapPadding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    ImageUtils.userProfileNotification),
                                SizedBox(
                                  width: 1.5.h,
                                ),
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      ExpandTapWidget(
                        onTap: () {
                          model.navigateToUserProfileAccountLegalTermScreen();
                        },
                        tapPadding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    ImageUtils.userProfileLegalTerms),
                                SizedBox(
                                  width: 1.5.h,
                                ),
                                Text(
                                  "Legal Terms",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                  ImageUtils.userProfileInviteFriends),
                              SizedBox(
                                width: 1.5.h,
                              ),
                              Text(
                                "Invite Your Friends",
                                style: TextStyle(
                                  color: ColorUtils.black,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 2.t,
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(right: 20),
                              //   child: RoundImage(
                              //     url: widget.profile.imageurl,
                              //     txtsize: 18,
                              //     txt: widget.profile.fullName,
                              //     width: 50,
                              //     height: 50,
                              //     borderRadius: 15,
                              //   ),
                              // ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                            color: Colors.black,
                          )
                        ],
                      ),
                      SizedBox(height: 3.h),
                      ExpandTapWidget(
                        onTap: () {
                          model.navigateToUserProfileAccountGpsScreen();
                        },
                        tapPadding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.userProfileGPs),
                                SizedBox(
                                  width: 1.5.h,
                                ),
                                Text(
                                  "GPS",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
