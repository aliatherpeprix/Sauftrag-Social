import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/widgets/round_image.dart';
import 'package:stacked/stacked.dart';

class MySideMenu extends StatefulWidget {

  const MySideMenu({Key? key}) : super(key: key);

  @override
  _MySideMenuState createState() => _MySideMenuState();
}

class _MySideMenuState extends State<MySideMenu> {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeLoginModel(),
      builder: (context, model, child) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //User
              GestureDetector(
                onTap: (){
                  model.navigateToUserDetailSettings();
                },
                child: Container(
                  padding: EdgeInsets.symmetric( vertical: Dimensions.containerVerticalPadding, horizontal: Dimensions.containerHorizontalPadding),
                  child: Row(
                    children: [

                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            image: NetworkImage(model
                                .userModel!.profile_picture!),
                            fit: BoxFit.cover,
                            height: 15.i,
                            width: 15.i,
                          )),
                      SizedBox(width: 2.5.w,),
                      Flexible(
                        child: Text(
                          model.userModel!.username!,
                          style: TextStyle(
                            color: ColorUtils.white,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.2.t,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              //Ranking List
              InkWell(
                onTap: (){
                  model.navigateToRatingList();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                      SvgPicture.asset(ImageUtils.rankingListIcon),

                      SizedBox(width: 2.w),

                      Text(
                        "Ranking List",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 1.8.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Notification
              InkWell(
                onTap: (){
                  model.navigateToNotificationScreen();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                      SvgPicture.asset(ImageUtils.notificationIcon),

                      SizedBox(width: 2.w),

                      Text(
                        "Notification",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 1.8.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Matched
              InkWell(
                onTap: (){
                  model.navigateToMatchedList();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                      SvgPicture.asset(ImageUtils.matchedIcon),

                      SizedBox(width: 2.w),

                      Text(
                        "Matched",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 1.8.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Followers
              InkWell(
                onTap: (){
                  model.navigateToFollowersListScreen();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                      SvgPicture.asset(ImageUtils.followersIcon),

                      SizedBox(width: 2.w),

                      Text(
                        "Followers",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 1.8.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Bars
              InkWell(
                onTap: (){
                  model.navigateToListOfBar();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                      SvgPicture.asset(ImageUtils.barsIcon),

                      SizedBox(width: 2.w),

                      Text(
                        "Bars",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 1.8.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //QR Code
              InkWell(
                onTap: (){
                  model.navigateToUserBarCodeScanner();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                      SvgPicture.asset(ImageUtils.qrCodeIcon),

                      SizedBox(width: 2.w),

                      Text(
                        "QR Code",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 1.8.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Events
              InkWell(
                onTap: (){
                  model.navigateToUpcomingEvent();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                      SvgPicture.asset(ImageUtils.eventsIcon),

                      SizedBox(width: 2.w),

                      Text(
                        "Events",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 1.8.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Logout
              InkWell(
                onTap: (){
                  model.logOutUser();

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                      SvgPicture.asset(ImageUtils.logoutIcon),

                      SizedBox(width: 2.w),

                      Text(
                        "Logout",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 1.8.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
