import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/FadedScaleAnimation.dart';
import 'package:stacked/stacked.dart';

class BarAndClubs extends StatefulWidget {
  const BarAndClubs({Key? key}) : super(key: key);

  @override
  _BarAndClubsState createState() => _BarAndClubsState();
}

class _BarAndClubsState extends State<BarAndClubs>
    with TickerProviderStateMixin {
  late TabController tabController;
  int tabSlelected = 0;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
    init();
  }

  void init() async {
    //initialize agora engine
    // engine = await RtcEngine.create(APP_ID);

    //wait for room to be generated
    setState(() {
      //waitinguser = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(height: Dimensions.topMargin),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            model.navigateBack();
                          },
                          iconSize: 18.0,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: ColorUtils.black,
                            size: 4.5.i,
                          )),
                      SizedBox(width: 2.w),
                      Text(
                        "Bars & Clubs",
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 3.t,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0.4.h),
                      decoration: BoxDecoration(
                        color: ColorUtils.divider,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: TabBar(
                        onTap: (value) {
                          tabSlelected = value;
                        },padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
                        isScrollable: false,
                        //indicatorPadding: EdgeInsets.symmetric(horizontal: 15.w),
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: tabController,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          Container(
                            // margin: EdgeInsets.only(
                            //   // top: 3 * SizeConfig.heightMultiplier,
                            //     left: 3 * SizeConfig.widthMultiplier),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2 * SizeConfig.widthMultiplier),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                                color: tabSlelected == 0
                                    ? ColorUtils.white
                                    : ColorUtils.divider,
                                boxShadow: [
                                  BoxShadow(
                                    color: tabSlelected == 0
                                        ? ColorUtils.shadowColor
                                        .withOpacity(0.15)
                                        : ColorUtils.divider,
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                // border: Border.all(
                                //   color: tabSlelected == 0
                                //       ? Colors.blue
                                //       : Colors.grey,
                                // )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "All Bars & Clubs",
                                    style: TextStyle(
                                      fontSize: 1.8.t,
                                      color: tabSlelected == 0
                                          ? Colors.blue
                                          : ColorUtils.icon_color,
                                      fontFamily: FontUtils.modernistBold,
                                      fontWeight: tabSlelected == 0
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            // margin: EdgeInsets.only(
                            //   //top: 3 * SizeConfig.heightMultiplier,
                            //     right: 3 * SizeConfig.widthMultiplier),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2 * SizeConfig.widthMultiplier,),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(18)),
                                boxShadow: [
                                  BoxShadow(
                                    color: tabSlelected == 1
                                        ? ColorUtils.shadowColor
                                        .withOpacity(0.15)
                                        : ColorUtils.divider,
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: tabSlelected == 1
                                    ? ColorUtils.white
                                    : ColorUtils.divider,
                                // border: Border.all(
                                //   color: tabSlelected == 1
                                //       ? Colors.blue
                                //       : Colors.grey,
                                // )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Followed Bar & Clubs",
                                    style: TextStyle(
                                        fontSize: 1.8.t,
                                        color: tabSlelected == 1
                                            ? Colors.blue
                                            : ColorUtils.icon_color,
                                        fontWeight: tabSlelected == 1
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        fontFamily: FontUtils.modernistBold),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )),
                Expanded(
                  child: Container(
                    height: 50 * SizeConfig.heightMultiplier,
                    child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [
                          FadedScaleAnimation(
                            AllBarAndClubs(),
                            beginOffset: Offset(0, 0.3),
                            endOffset: Offset(0, 0),
                            slideCurve: Curves.linearToEaseOut,
                          ),
                          FadedScaleAnimation(
                            FollowedBarsAndClubs(),
                            beginOffset: Offset(0, 0.3),
                            endOffset: Offset(0, 0),
                            slideCurve: Curves.linearToEaseOut,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget AllBarAndClubs() {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model) {
        //model.followers();
        model.barModel;
        model.getListOfAllBars();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                 SizedBox(height: Dimensions.topMargin),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                //
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       IconButton(
                //           onPressed: () {
                //             model.navigateBack();
                //           },
                //           iconSize: 18.0,
                //           padding: EdgeInsets.zero,
                //           constraints: BoxConstraints(),
                //           icon: Icon(
                //             Icons.arrow_back_ios,
                //             color: ColorUtils.black,
                //             size: 4.5.i,
                //           )),
                //       SizedBox(width: 2.w),
                //       Text(
                //         "Bars & Clubs",
                //         style: TextStyle(
                //           color: ColorUtils.black,
                //           fontFamily: FontUtils.modernistBold,
                //           fontSize: 3.t,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 5.h,),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal:SizeConfig.widthMultiplier * 4,),
                        child: GestureDetector(
                          onTap: (){
                            // model.barId = model.listOfBar[index].id;
                            model.selectedBar = (model.listOfAllBars[index]);
                            model.navigateToBarProfile();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric( horizontal: 2.5.w, vertical: 1.5.h),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorUtils.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(0, 5), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              border: Border.all(color: ColorUtils.text_red),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(model.listOfAllBars[index].profile_picture!,
                                    width: 15.i,
                                    height: 15.i,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 2.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(model.listOfAllBars[index].bar_name!,
                                            style: TextStyle(
                                                fontFamily: FontUtils.modernistBold,
                                                fontSize: 1.9.t,
                                                color: ColorUtils.black
                                            ),
                                          ),
                                          SizedBox(width: 1.w,),
                                          // Text(model.listOfBar[index].bar_kind!.toString(),
                                          //   style: TextStyle(
                                          //       fontFamily: FontUtils.modernistRegular,
                                          //       fontSize: 1.6.t,
                                          //       color: ColorUtils.red_color
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      SizedBox(height: 0.8.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(ImageUtils.locationPin,),
                                          SizedBox(width: 1.5.w,),
                                          Container(
                                            width: 50.w,
                                            child: Text(model.listOfAllBars[index].address!,
                                              style: TextStyle(
                                                fontFamily: FontUtils.modernistRegular,
                                                fontSize: 1.6.t,
                                                color: ColorUtils.text_grey,
                                              ),

                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.8.h,),
                                      RatingBar.builder(
                                        tapOnlyMode: false,
                                        initialRating: model.listOfAllBars[index].total_ratings ?? 0.0,
                                        // minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 4.5.i,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star_rounded,
                                          color: ColorUtils.red_color,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                    },
                    itemCount: model.listOfAllBars.length,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Widget FollowedBarsAndClubs() {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
        model.getListOfbars();
      },

      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(height: Dimensions.topMargin),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                //
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       IconButton(
                //           onPressed: () {
                //             model.navigateBack();
                //           },
                //           iconSize: 18.0,
                //           padding: EdgeInsets.zero,
                //           constraints: BoxConstraints(),
                //           icon: Icon(
                //             Icons.arrow_back_ios,
                //             color: ColorUtils.black,
                //             size: 4.5.i,
                //           )),
                //       SizedBox(width: 2.w),
                //       Text(
                //         "Followed Bars & Clubs",
                //         style: TextStyle(
                //           color: ColorUtils.black,
                //           fontFamily: FontUtils.modernistBold,
                //           fontSize: 3.t,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 5.h,),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal:SizeConfig.widthMultiplier * 4,),
                        child: GestureDetector(
                          onTap: (){
                            model.barId = model.listOfBar[index].id;
                            model.selectedBar = (model.listOfBar[index]);
                            model.navigateToBarProfile();

                          },
                          child: Container(
                            padding: EdgeInsets.symmetric( horizontal: 2.5.w, vertical: 1.5.h),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorUtils.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(0, 5), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              border: Border.all(color: ColorUtils.text_red),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(model.listOfBar[index].profile_picture!,
                                    width: 15.i,
                                    height: 15.i,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 2.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(model.listOfBar[index].bar_name!,
                                            style: TextStyle(
                                                fontFamily: FontUtils.modernistBold,
                                                fontSize: 1.9.t,
                                                color: ColorUtils.black
                                            ),
                                          ),
                                          SizedBox(width: 1.w,),
                                          Text(model.ListOfBar[index]['type']!,
                                            style: TextStyle(
                                                fontFamily: FontUtils.modernistRegular,
                                                fontSize: 1.6.t,
                                                color: ColorUtils.red_color
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 0.8.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(model.ListOfBar[index]["locationIcon"],),
                                          SizedBox(width: 1.5.w,),
                                          Container(
                                            width: 50.w,
                                            child: Text(model.listOfBar[index].address!,
                                              style: TextStyle(
                                                fontFamily: FontUtils.modernistRegular,
                                                fontSize: 1.6.t,
                                                color: ColorUtils.text_grey,
                                              ),

                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.8.h,),
                                      RatingBar.builder(
                                        tapOnlyMode: false,
                                        initialRating: model.listOfBar[index].total_ratings ?? 0.0,
                                        // minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 4.5.i,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star_rounded,
                                          color: ColorUtils.red_color,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                    },
                    itemCount: model.listOfBar.length,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
