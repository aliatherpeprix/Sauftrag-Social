import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
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
                              fontSize: 2.5.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),

                      ///--------------Event Name--------------------///
                      Container(
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
                                  // onPressed: () {
                                  //  /* showDialog(
                                  //       context: context,
                                  //       builder: (BuildContext context){
                                  //         return DrinkStatusDialogBox(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                  //       }
                                  //   );*/
                                  // },
                                  child: Image.asset(ImageUtils.userProfileProfile,
                                  height: 15.i,
                                  width: 15.i,
                                  ),
                                ),
                                SizedBox(width: 2.w,),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "John Wick",
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 2.t,
                                      ),
                                    ),
                                    SizedBox(height: 1.h,),
                                    Text(
                                      "+62 1309 - 1710 - 1920",
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
                      SizedBox(height: 3.h,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: ColorUtils.text_red,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          children: [
                            Image.asset(ImageUtils.levelStar,
                            height: 20.i,
                            width: 20.i,
                            ),
                            SizedBox(width: 2.w,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Level 21",
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
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    child: Text("You are just 25 points away to reach next level",
                                      style: TextStyle(
                                        fontFamily: FontUtils.modernistRegular,
                                        color: Colors.white,
                                        fontSize: 1.6.t,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.0.h,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: SizedBox(
                                        height: 8,
                                        child:LiquidLinearProgressIndicator(
                                          value: 0.45, // Defaults to 0.5.
                                          valueColor: AlwaysStoppedAnimation(ColorUtils.settingsProgress), // Defaults to the current Theme's accentColor.
                                          backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                                          //borderColor: Colors.red, //border color of the bar
                                          //borderWidth: 5.0, //border width of the bar
                                          borderRadius: 12.0,//border radius
                                          direction: Axis.horizontal,
                                          // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                          //center: Text("50%"), //text inside bar
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),

                      ///--------------Settings Options--------------------///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(ImageUtils.userProfileAccount),
                              SizedBox(width: 1.5.h,),
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
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(ImageUtils.userProfileNotification),
                              SizedBox(width: 1.5.h,),
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
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(ImageUtils.userProfileLegalTerms),
                              SizedBox(width: 1.5.h,),
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
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(ImageUtils.userProfileInviteFriends),
                              SizedBox(width: 1.5.h,),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(ImageUtils.userProfileGPs),
                              SizedBox(width: 1.5.h,),
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
