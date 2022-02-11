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
import 'package:sauftrag/widgets/rating_dialog_box.dart';
import 'package:stacked/stacked.dart';

class BarAllRating extends StatefulWidget {
  const BarAllRating({Key? key}) : super(key: key);

  @override
  _BarAllRatingState createState() => _BarAllRatingState();
}

class _BarAllRatingState extends State<BarAllRating>
    with TickerProviderStateMixin {
  late TabController tabController;

  List ratingDialog = [
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.nickWalkerImg,
    },
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.nickWalkerImg
    },
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.nickWalkerImg,
    },
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.nickWalkerImg
    },
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.nickWalkerImg
    }
  ];

  int tabSlelected = 0;

  @override
  void initState() {
    tabController = TabController(
      length: 6,
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
      onModelReady: (model) {
        model.rating();
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
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            model.rating();
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
                        "All Ratings",
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
                  height: 3.h,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                    child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0.4.h),
                  decoration: BoxDecoration(
                    // color: ColorUtils.divider,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: TabBar(
                    onTap: (value) {
                      tabSlelected = value;
                    },
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Container(
                          // margin: EdgeInsets.only(
                          //   // top: 3 * SizeConfig.heightMultiplier,
                          //     left: 3 * SizeConfig.widthMultiplier),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 2.w),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: tabSlelected == 0
                                  ? ColorUtils.ratingBoxColor
                                  : ColorUtils.white,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: tabSlelected == 0 ? ColorUtils.shadowColor.withOpacity(0.15) : ColorUtils.divider,
                              //     spreadRadius: 3,
                              //     blurRadius: 8,
                              //     offset: Offset(0, 3), // changes position of shadow
                              //   ),
                              // ],
                              border: Border.all(
                                width: 0.4.w,
                                color: tabSlelected == 0
                                    ? ColorUtils.ratingBoxColor
                                    : ColorUtils.divider,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "All Review",
                                style: TextStyle(
                                  fontSize: 1.8.t,
                                  color: tabSlelected == 0
                                      ? ColorUtils.red_color
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
                              vertical: 1.5.h, horizontal: 3.w),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: tabSlelected == 1
                              //         ? ColorUtils.shadowColor.withOpacity(0.15)
                              //         : ColorUtils.divider,
                              //     spreadRadius: 3,
                              //     blurRadius: 8,
                              //     offset:
                              //         Offset(0, 3), // changes position of shadow
                              //   ),
                              // ],
                              color: tabSlelected == 1
                                  ? ColorUtils.ratingBoxColor
                                  : ColorUtils.white,
                              border: Border.all(
                                width: 0.4.w,
                                color: tabSlelected == 1
                                    ? ColorUtils.ratingBoxColor
                                    : ColorUtils.divider,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: tabSlelected == 1
                                    ? ColorUtils.red_color
                                    : ColorUtils.icon_color,
                              ),
                              SizedBox(
                                width: 1.5.w,
                              ),
                              Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 1.8.t,
                                    color: tabSlelected == 1
                                        ? ColorUtils.red_color
                                        : ColorUtils.icon_color,
                                    fontWeight: tabSlelected == 1
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    fontFamily: FontUtils.modernistBold),
                              )
                            ],
                          )),
                      Container(
                          // margin: EdgeInsets.only(
                          //   //top: 3 * SizeConfig.heightMultiplier,
                          //     right: 3 * SizeConfig.widthMultiplier),
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.w),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: tabSlelected == 1
                              //         ? ColorUtils.shadowColor.withOpacity(0.15)
                              //         : ColorUtils.divider,
                              //     spreadRadius: 3,
                              //     blurRadius: 8,
                              //     offset:
                              //         Offset(0, 3), // changes position of shadow
                              //   ),
                              // ],
                              color: tabSlelected == 2
                                  ? ColorUtils.ratingBoxColor
                                  : ColorUtils.white,
                              border: Border.all(
                                width: 0.4.w,
                                color: tabSlelected == 2
                                    ? ColorUtils.ratingBoxColor
                                    : ColorUtils.divider,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: tabSlelected == 2
                                    ? ColorUtils.red_color
                                    : ColorUtils.icon_color,
                              ),
                              SizedBox(
                                width: 1.5.w,
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 1.8.t,
                                    color: tabSlelected == 2
                                        ? ColorUtils.red_color
                                        : ColorUtils.icon_color,
                                    fontWeight: tabSlelected == 2
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    fontFamily: FontUtils.modernistBold),
                              )
                            ],
                          )),
                      Container(
                          // margin: EdgeInsets.only(
                          //   //top: 3 * SizeConfig.heightMultiplier,
                          //     right: 3 * SizeConfig.widthMultiplier),
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.w),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: tabSlelected == 1
                              //         ? ColorUtils.shadowColor.withOpacity(0.15)
                              //         : ColorUtils.divider,
                              //     spreadRadius: 3,
                              //     blurRadius: 8,
                              //     offset:
                              //         Offset(0, 3), // changes position of shadow
                              //   ),
                              // ],
                              color: tabSlelected == 3
                                  ? ColorUtils.ratingBoxColor
                                  : ColorUtils.white,
                              border: Border.all(
                                width: 0.4.w,
                                color: tabSlelected == 3
                                    ? ColorUtils.ratingBoxColor
                                    : ColorUtils.divider,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: tabSlelected == 3
                                    ? ColorUtils.red_color
                                    : ColorUtils.icon_color,
                              ),
                              SizedBox(
                                width: 1.5.w,
                              ),
                              Text(
                                "3",
                                style: TextStyle(
                                    fontSize: 1.8.t,
                                    color: tabSlelected == 3
                                        ? ColorUtils.red_color
                                        : ColorUtils.icon_color,
                                    fontWeight: tabSlelected == 3
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    fontFamily: FontUtils.modernistBold),
                              )
                            ],
                          )),
                      Container(
                          // margin: EdgeInsets.only(
                          //   //top: 3 * SizeConfig.heightMultiplier,
                          //     right: 3 * SizeConfig.widthMultiplier),
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.w),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: tabSlelected == 1
                              //         ? ColorUtils.shadowColor.withOpacity(0.15)
                              //         : ColorUtils.divider,
                              //     spreadRadius: 3,
                              //     blurRadius: 8,
                              //     offset:
                              //         Offset(0, 3), // changes position of shadow
                              //   ),
                              // ],
                              color: tabSlelected == 4
                                  ? ColorUtils.ratingBoxColor
                                  : ColorUtils.white,
                              border: Border.all(
                                width: 0.4.w,
                                color: tabSlelected == 4
                                    ? ColorUtils.ratingBoxColor
                                    : ColorUtils.divider,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: tabSlelected == 4
                                    ? ColorUtils.red_color
                                    : ColorUtils.icon_color,
                              ),
                              SizedBox(
                                width: 1.5.w,
                              ),
                              Text(
                                "4",
                                style: TextStyle(
                                    fontSize: 1.8.t,
                                    color: tabSlelected == 4
                                        ? ColorUtils.red_color
                                        : ColorUtils.icon_color,
                                    fontWeight: tabSlelected == 4
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    fontFamily: FontUtils.modernistBold),
                              )
                            ],
                          )),
                      Container(
                          // margin: EdgeInsets.only(
                          //   //top: 3 * SizeConfig.heightMultiplier,
                          //     right: 3 * SizeConfig.widthMultiplier),
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.w),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: tabSlelected == 1
                              //         ? ColorUtils.shadowColor.withOpacity(0.15)
                              //         : ColorUtils.divider,
                              //     spreadRadius: 3,
                              //     blurRadius: 8,
                              //     offset:
                              //         Offset(0, 3), // changes position of shadow
                              //   ),
                              // ],
                              color: tabSlelected == 5
                                  ? ColorUtils.ratingBoxColor
                                  : ColorUtils.white,
                              border: Border.all(
                                width: 0.4.w,
                                color: tabSlelected == 5
                                    ? ColorUtils.ratingBoxColor
                                    : ColorUtils.divider,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: tabSlelected == 5
                                    ? ColorUtils.red_color
                                    : ColorUtils.icon_color,
                              ),
                              SizedBox(
                                width: 1.5.w,
                              ),
                              Text(
                                "5",
                                style: TextStyle(
                                    fontSize: 1.8.t,
                                    color: tabSlelected == 5
                                        ? ColorUtils.red_color
                                        : ColorUtils.icon_color,
                                    fontWeight: tabSlelected == 5
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
                  child: TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        FadedScaleAnimation(
                          AllRating(),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                        FadedScaleAnimation(
                          AllRating(),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                        FadedScaleAnimation(
                          AllRating(),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                        FadedScaleAnimation(
                          AllRating(),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                        FadedScaleAnimation(
                          AllRating(),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                        FadedScaleAnimation(
                          AllRating(),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget AllRating() {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       model.rating();
                //       // model.getTime();
                //     },
                //     child: Text("data")),
                ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.ratingKaData!.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.5.w),
                      //width: 6.h,
                      //height: 30.h,
                      decoration: BoxDecoration(
                        /* boxShadow: [
                                      BoxShadow(
                                        color: ColorUtils.black.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: Offset(0, 5), // changes position of shadow
                                      ),
                                    ],*/
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        //border: Border.all(color: ColorUtils.red_color),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    model.ratingKaData!.data![index].user!
                                        .profile_picture
                                        .toString(),
                                    height: 10.i,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.ratingKaData!.data![index].user!
                                            .username
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 2.h,
                                          fontFamily: FontUtils.modernistBold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        model.timeZone!
                                            .substring(0, 11)
                                            .toString(),
                                        style: TextStyle(
                                            color: ColorUtils.text_grey,
                                            fontFamily:
                                                FontUtils.modernistRegular,
                                            fontSize: 1.3.h),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              RatingBar.builder(
                                tapOnlyMode: false,
                                initialRating:
                                    model.ratingKaData!.total_rating ?? 0,
                                minRating: 1,
                                ignoreGestures: true,
                                direction: Axis.horizontal,
                                //allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 4.5.i,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 3.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star_rounded,
                                  color: ColorUtils.red_color,
                                ),
                                onRatingUpdate: (rating) {
                                  //print(rating);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            model.ratingKaData!.data![index].comments
                                .toString(),
                            style: TextStyle(
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.7.t),
                          ),
                          // Divider(
                          //   height: 2.5.h,
                          // ),
                          // Row(
                          //   children: [
                          //     Image.asset(
                          //       ImageUtils.comment,
                          //       scale: 5,
                          //     ),
                          //     SizedBox(
                          //       width: 2.w,
                          //     ),
                          //     Text(
                          //       "68",
                          //       style: TextStyle(
                          //           color: Colors.grey[400],
                          //           fontFamily: FontUtils
                          //               .modernistRegular),
                          //     ),
                          //     SizedBox(
                          //       width: 8.w,
                          //     ),
                          //     Image.asset(
                          //       ImageUtils.like,
                          //       scale: 5,
                          //     ),
                          //     SizedBox(
                          //       width: 2.w,
                          //     ),
                          //     Text(
                          //       "53.5 k",
                          //       style: TextStyle(
                          //           color: Colors.grey[400],
                          //           fontFamily: FontUtils
                          //               .modernistRegular),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    );
                  },
                ),
                SizedBox(height: 2.5.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget Comments() {
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
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorUtils.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            border: Border.all(color: ColorUtils.red_color),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 2.h),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        model.places[index]["image"],
                                        width: 20.i,
                                        height: 20.i,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.places[index]["date"],
                                          style: TextStyle(
                                              fontFamily:
                                                  FontUtils.modernistRegular,
                                              fontSize: 1.7.t,
                                              color: ColorUtils.text_red),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          model.places[index]["eventName"],
                                          style: TextStyle(
                                              fontFamily:
                                                  FontUtils.modernistBold,
                                              fontSize: 2.2.t,
                                              color: ColorUtils.black),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                model.places[index]["image1"]),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              model.places[index]["location"],
                                              style: TextStyle(
                                                  fontFamily: FontUtils
                                                      .modernistRegular,
                                                  fontSize: 1.7.t,
                                                  color: ColorUtils.text_dark),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: SizeConfig.heightMultiplier * 2.5,
                      );
                    },
                    itemCount: model.places.length,
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
