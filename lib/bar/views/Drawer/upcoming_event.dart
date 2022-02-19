import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:sauftrag/widgets/FadedScaleAnimation.dart';

class UpcomingEvent extends StatefulWidget {
  const UpcomingEvent({Key? key}) : super(key: key);

  @override
  _UpcomingEventState createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent>
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
                        "Events",
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
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0.4.h),
                      decoration: BoxDecoration(
                        color: ColorUtils.divider,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: TabBar(
                        onTap: (value) {
                          tabSlelected = value;
                        },
                        isScrollable: false,
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
                                    "UPCOMING",
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
                                  vertical: 2 * SizeConfig.widthMultiplier),
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
                                    "PAST EVENT",
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
                            Audience(),
                            beginOffset: Offset(0, 0.3),
                            endOffset: Offset(0, 0),
                            slideCurve: Curves.linearToEaseOut,
                          ),
                          FadedScaleAnimation(
                            Comments(),
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

  Widget Audience() {
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
