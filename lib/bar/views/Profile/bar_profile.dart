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

class BarProfile extends StatefulWidget {
  const BarProfile({Key? key}) : super(key: key);

  @override
  _BarProfileState createState() => _BarProfileState();
}

class _BarProfileState extends State<BarProfile> {
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
                        onTap: (){
                          model.navigateToBarDetails();
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(

                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            Row(
                              children: [
                                Image.asset(ImageUtils.profileImg),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jenny Sandals",
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontFamily: FontUtils.modernistBold,
                                        fontSize: 2.t,
                                      ),
                                    ),
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
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),

                      ///--------------Settings Options--------------------///
                      GestureDetector(
                        onTap: (){
                          model.navigateToBarAccounts();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.profile),
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
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),

                      GestureDetector(
                        onTap: (){
                          model.navigateToUserProfileAccountNotificationScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.notification),
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
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: (){
                          model.navigateToUserProfileAccountLegalTermScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.terms),
                                SizedBox(width: 1.5.h,),
                                Text(
                                  "Others",
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
                              color: Colors.grey,
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
                              SvgPicture.asset(ImageUtils.packages),
                              SizedBox(width: 1.5.h,),
                              Text(
                                "Packages",
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
                            color: Colors.grey,
                          )
                        ],
                      ),

                      //GPS
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: (){
                          model.navigateToUserProfileAccountGpsScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.gps),
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
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),

                      //Faqs
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: (){
                          model.navigateToFaqScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.gps),
                                SizedBox(width: 1.5.h,),
                                Text(
                                  "FAQ",
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
                              color: Colors.grey,
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
