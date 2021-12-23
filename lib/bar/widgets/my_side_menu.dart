import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
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
          color: ColorUtils.text_red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //User
              GestureDetector(
                onTap: (){
                  model.navigateToBarDetails();
                },
                child: Container(
                  padding: EdgeInsets.symmetric( vertical: Dimensions.containerVerticalPadding),
                  child: Row(
                    children: [

                    Image.asset(ImageUtils.profileImg),


                      Text(
                        "Jenny Sandals",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 2.2.t,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.h),

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

              //Events
              InkWell(
                onTap: (){
                  model.navigateToBarEventScreen();
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
                  model.navigateAndRemoveSignInScreen();
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
