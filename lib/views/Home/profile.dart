import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

class Profile extends StatefulWidget {
  List<String> images;
  String? name;

  Profile({Key? key, required this.images,required this.name}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentPageNotifier = ValueNotifier<int>(0);

  late PageController controller;

  @override
  void initState() {
    super.initState();

    controller = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeLoginModel(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                           //SizedBox(height: 4.3.h),
                        Container(
                          height: 53.5.h,
                          //color: Colors.red,
                          child: SafeArea(
                            child: Stack(
                              children: [
                                Container(
                                  height: 45.h,
                                  child: Stack(
                                    children: [
                                      PageView.builder(
                                        itemBuilder: (context, position) {
                                          return Container(

                                            decoration: BoxDecoration(
                                              //borderRadius: BorderRadius.all(Radius.circular(20)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    widget.images[position]),
                                                 fit: BoxFit.cover
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          );
                                        },
                                        itemCount: widget.images.length,
                                        controller: controller,
                                        onPageChanged: (int index) {
                                          currentPageNotifier.value = index;
                                        }, // Can be null
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 1.5.h),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15)),
                                            color: ColorUtils.white.withOpacity(0.6),
                                          ),
                                          child: SmoothPageIndicator(
                                              controller: controller, // PageController
                                              count: widget.images.length,
                                              effect: WormEffect(
                                                  spacing: 10,
                                                  dotWidth: 5,
                                                  dotHeight: 5,
                                                  dotColor:
                                                  ColorUtils.white.withOpacity(0.5),
                                                  activeDotColor: ColorUtils.white),
                                              axisDirection: Axis.horizontal,
                                              onDotClicked: (index) {}),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Positioned(
                                //     bottom: -2.2.h,
                                //     right: 3.w,
                                //     child: GestureDetector(
                                //       onTap: (){
                                //         model.navigateToMatchScreen();
                                //       },
                                //       child: Container(
                                //         width: 12.w,
                                //         height: 12.h,
                                //         decoration: BoxDecoration(shape: BoxShape.circle, color: ColorUtils.red_color,),
                                //         child: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,)
                                //       ),
                                //     )),
                                Positioned(
                                    top: 5.h,
                                    left: 5.w,
                                    child: Container(
                                        width: 10.w,
                                        height: 6.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10))),
                                        child: BackArrowContainer())),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 60.h,
                        //   color: Colors.red,
                        //   child: SizedBox(
                        //       height: MediaQuery.of(context).size.height * 0.45,
                        //       child: Stack(
                        //         children: [
                        //           PageView.builder(
                        //             itemBuilder: (context, position) {
                        //               return Container(
                        //                 decoration: BoxDecoration(
                        //                   //borderRadius: BorderRadius.all(Radius.circular(20)),
                        //                   image: DecorationImage(
                        //                       image: AssetImage(
                        //                           widget.images[position]),
                        //                       fit: BoxFit.cover),
                        //                 ),
                        //                 alignment: Alignment.center,
                        //               );
                        //             },
                        //             itemCount: widget.images.length,
                        //             controller: controller,
                        //             onPageChanged: (int index) {
                        //               currentPageNotifier.value = index;
                        //             }, // Can be null
                        //           ),
                        //           Align(
                        //             alignment: Alignment.bottomCenter,
                        //             child: Container(
                        //               padding: EdgeInsets.symmetric(
                        //                   horizontal: 3.w, vertical: 1.5.h),
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.only(
                        //                     topLeft: Radius.circular(15),
                        //                     topRight: Radius.circular(15)),
                        //                 color: ColorUtils.white.withOpacity(0.6),
                        //               ),
                        //               child: SmoothPageIndicator(
                        //                   controller: controller, // PageController
                        //                   count: widget.images.length,
                        //                   effect: WormEffect(
                        //                       spacing: 10,
                        //                       dotWidth: 5,
                        //                       dotHeight: 5,
                        //                       dotColor:
                        //                           ColorUtils.white.withOpacity(0.5),
                        //                       activeDotColor: ColorUtils.white),
                        //                   axisDirection: Axis.horizontal,
                        //                   onDotClicked: (index) {}),
                        //             ),
                        //           ),
                        //
                        //           // Align(
                        //           //   child: Container(
                        //           //     child:  CirclePageIndicator(
                        //           //       size: 5.0,
                        //           //       selectedSize: 7.0,
                        //           //       itemCount: 5,
                        //           //       dotColor: ColorUtils.white.withOpacity(0.5),
                        //           //       selectedDotColor: ColorUtils.white,
                        //           //       dotSpacing: 3.w,
                        //           //       currentPageNotifier: currentPageNotifier,
                        //           //     ),
                        //           //   ),
                        //           // )
                        //         ],
                        //       )),
                        // ),
                        //SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalPadding),
                          child: Text(
                            widget.name!,
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.6.t,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.location_pin,
                                  color: ColorUtils.text_dark),
                              Text(
                                "Germany",
                                style: TextStyle(
                                  color: ColorUtils.text_dark,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.5.h),
                        Divider(
                          color: ColorUtils.divider,
                          thickness: 1,
                        ),

                        ///-------Favorite Alcoholic Drink------------------////
                        SizedBox(height: 2.5.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalPadding),
                          child: Text(
                            "Lieblingsalkoholisches Getränk",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalPadding),
                          child: Wrap(
                            spacing: 2.5.w,
                            runSpacing: 1.5.h,
                            direction: Axis.horizontal,
                            children: model.favoriteAlcoholicDrink
                                .map((element) => ElevatedButton(
                                      onPressed: () {},
                                      child: Text(model.favoriteAlcoholicDrink[
                                          model.favoriteAlcoholicDrink.indexOf(element)]),
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorUtils.white,
                                        onPrimary: ColorUtils.text_red,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.8.h, horizontal: 5.w),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.roundCorner),
                                            side: BorderSide(
                                                color: ColorUtils.text_red,
                                                width: 1)),
                                        textStyle: TextStyle(
                                          //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                          fontFamily: FontUtils.modernistRegular,
                                          fontSize: 1.7.t,
                                          //height: 0
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),

                        ///-----------Favorite Night Club---------------------///
                        SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalPadding),
                          child: Text(
                            "Lieblings Nachtclub",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalPadding),
                          child: Wrap(
                            spacing: 2.5.w,
                            runSpacing: 1.5.h,
                            direction: Axis.horizontal,
                            children: model.favoriteNightClub
                                .map((element) => ElevatedButton(
                              onPressed: () {},
                              child: Text(model.favoriteNightClub[
                              model.favoriteNightClub.indexOf(element)]),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.8.h, horizontal: 5.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1)),
                                textStyle: TextStyle(
                                  //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.7.t,
                                  //height: 0
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                        ),

                        ///---------------Favorite Party Vacation --------------///
                        SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalPadding),
                          child: Text(
                            "Lieblings-Party-Urlaub",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalPadding),
                          child: Wrap(
                            spacing: 2.5.w,
                            runSpacing: 1.5.h,
                            direction: Axis.horizontal,
                            children: model.favoritePartyVacation
                                .map((element) => ElevatedButton(
                              onPressed: () {},
                              child: Text(model.favoritePartyVacation[
                              model.favoritePartyVacation.indexOf(element)]),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.8.h, horizontal: 5.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1)),
                                textStyle: TextStyle(
                                  //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.7.t,
                                  //height: 0
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                        ),

                        ///-------- Like & Dislike ---------///
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                model.navigateBack();
                              },
                              child: SvgPicture.asset(ImageUtils.dislikeIcon),
                              style: ElevatedButton.styleFrom(
                                shadowColor: ColorUtils.red_color,
                                primary: ColorUtils.red_color.withOpacity(0.9),
                                onPrimary: ColorUtils.white,
                                //padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding),
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  //side: BorderSide(color: ColorUtils.divider, width: 1)
                                ),
                                textStyle: TextStyle(
                                  color: ColorUtils.white,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              child: SvgPicture.asset(ImageUtils.repeatIcon),
                              backgroundColor: ColorUtils.white,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                model.navigateToMatchScreen();
                              },
                              child: SvgPicture.asset(ImageUtils.likeIcon),
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.green,
                                primary: Colors.green.withOpacity(0.9),
                                onPrimary: ColorUtils.white,
                                //padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding),
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  //side: BorderSide(color: ColorUtils.divider, width: 1)
                                ),
                                textStyle: TextStyle(
                                  color: ColorUtils.white,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
