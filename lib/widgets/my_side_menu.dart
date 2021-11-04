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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //User
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.containerHorizontalPadding, vertical: Dimensions.containerVerticalPadding),
                child: Row(
                  children: [

                    RoundImage(
                        image: ImageUtils.userIcon,
                        height: 13.i,
                        width: 13.i
                    ),

                    SizedBox(width: 2.w),

                    Text(
                      "John Doe",
                      style: TextStyle(
                        color: ColorUtils.white,
                        fontFamily: FontUtils.modernistBold,
                        fontSize: 2.2.t,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),

              //Ranking List
              InkWell(
                onTap: (){},
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
                onTap: (){},
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
                onTap: (){},
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
                onTap: (){},
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
                onTap: (){},
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
                onTap: (){},
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
                onTap: (){},
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
                onTap: (){},
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
