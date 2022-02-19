import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/views/Drawer/matched_people.dart';
import 'package:sauftrag/bar/views/Drawer/request_people.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/widgets/FadedScaleAnimation.dart';
import 'package:stacked/stacked.dart';

class MatchedScreen extends StatefulWidget {
  const MatchedScreen({Key? key}) : super(key: key);

  @override
  _MatchedScreenState createState() => _MatchedScreenState();
}

class _MatchedScreenState extends State<MatchedScreen>
    with TickerProviderStateMixin {
  List matchedImg = [
    {'image': ImageUtils.matchedImg1, 'title': 'Leona Mathis'},
    {'image': ImageUtils.matchedImg2, 'title': 'Josefina Ward'},
    {'image': ImageUtils.matchedImg3, 'title': 'Andre Patterson'},
    {'image': ImageUtils.matchedImg4, 'title': 'Nick Hoffman'},
    {'image': ImageUtils.matchedImg5, 'title': 'Henrietta Hall'},
    {'image': ImageUtils.matchedImg6, 'title': 'Hazel Ballard'},
  ];
  late TabController tabController1;

  int tabSlelected1 = 0;

  @override
  void initState() {
    tabController1 = TabController(
      length: 2,
      vsync: this,
    );
    tabController1.addListener(() {
      setState(() {});
    });
    super.initState();
    // init();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
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
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.homeTopMargin),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding,
                        vertical: Dimensions.verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
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
                              "Matched",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
                              ),
                            ),
                          ],
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: TabBar(
                                onTap: (value) {
                                  tabSlelected1 = value;
                                },
                                isScrollable: false,
                                indicatorSize: TabBarIndicatorSize.label,
                                controller: tabController1,
                                indicatorColor: Colors.transparent,
                                tabs: [
                                  Container(
                                      // margin: EdgeInsets.only(
                                      //   // top: 3 * SizeConfig.heightMultiplier,
                                      //     left: 3 * SizeConfig.widthMultiplier),
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              2 * SizeConfig.widthMultiplier),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: tabSlelected1 == 0
                                            ? ColorUtils.white
                                            : ColorUtils.divider,
                                        boxShadow: [
                                          BoxShadow(
                                            color: tabSlelected1 == 0
                                                ? ColorUtils.shadowColor
                                                    .withOpacity(0.15)
                                                : ColorUtils.divider,
                                            spreadRadius: 3,
                                            blurRadius: 8,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        // border: Border.all(
                                        //   color: tabSlelected == 0
                                        //       ? Colors.blue
                                        //       : Colors.grey,
                                        // )
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "UPCOMING",
                                            style: TextStyle(
                                              fontSize: 1.8.t,
                                              color: tabSlelected1 == 0
                                                  ? Colors.blue
                                                  : ColorUtils.icon_color,
                                              fontFamily:
                                                  FontUtils.modernistBold,
                                              fontWeight: tabSlelected1 == 0
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
                                          vertical:
                                              2 * SizeConfig.widthMultiplier),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: tabSlelected1 == 1
                                                ? ColorUtils.shadowColor
                                                    .withOpacity(0.15)
                                                : ColorUtils.divider,
                                            spreadRadius: 3,
                                            blurRadius: 8,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: tabSlelected1 == 1
                                            ? ColorUtils.white
                                            : ColorUtils.divider,
                                        // border: Border.all(
                                        //   color: tabSlelected == 1
                                        //       ? Colors.blue
                                        //       : Colors.grey,
                                        // )
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "PAST EVENT",
                                            style: TextStyle(
                                                fontSize: 1.8.t,
                                                color: tabSlelected1 == 1
                                                    ? Colors.blue
                                                    : ColorUtils.icon_color,
                                                fontWeight: tabSlelected1 == 1
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                                fontFamily:
                                                    FontUtils.modernistBold),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            )),
                        Container(
                          height: 75 * SizeConfig.heightMultiplier,
                          child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: tabController1,
                              children: [
                                FadedScaleAnimation(
                                  MatchedPeople(),
                                  beginOffset: Offset(0, 0.3),
                                  endOffset: Offset(0, 0),
                                  slideCurve: Curves.linearToEaseOut,
                                ),
                                FadedScaleAnimation(
                                  RequestedPeople(),
                                  beginOffset: Offset(0, 0.3),
                                  endOffset: Offset(0, 0),
                                  slideCurve: Curves.linearToEaseOut,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
