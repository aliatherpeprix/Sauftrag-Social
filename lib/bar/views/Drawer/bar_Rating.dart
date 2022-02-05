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
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:sauftrag/widgets/rating_dialog_box.dart';
import 'package:stacked/stacked.dart';

class BarRating extends StatefulWidget {
  const BarRating({Key? key}) : super(key: key);

  @override
  _BarRatingState createState() => _BarRatingState();
}

class _BarRatingState extends State<BarRating> {
  List people = [
    {
      'name': "Nellie Mendez",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.Nil,
    },
    {
      'name': "Ron Wright",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.ron
    },
    {
      'name': "Nellie Mendez",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.Nil,
    },
    {
      'name': "Ron Wright",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.ron
    }
  ];

  List ratingDialog = [
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.ron,
    },
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.ron
    },
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.ron,
    },
    {
      'name': "Nick Walker",
      'date': "10 December, 2020",
      'detail':
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.",
      'image': ImageUtils.ron
    }
  ];

  List places = [
    {
      'image': ImageUtils.place1,
      'eventName': 'Trivia Nights',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'locationIcon': ImageUtils.locationPin
    },
    {
      'image': ImageUtils.place2,
      'eventName': 'Bar Crawl Stop',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'locationIcon': ImageUtils.locationPin
    },
    {
      'image': ImageUtils.place3,
      'eventName': 'Singles Night',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'locationIcon': ImageUtils.locationPin
    },
    {
      'image': ImageUtils.place4,
      'eventName': 'Bar Olympics',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
      'locationIcon': ImageUtils.locationPin
    },
  ];

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
                body: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(children: [
                      Container(
                        height: 45.h,
                        child: SafeArea(
                          child: Stack(
                            children: [
                              Container(
                                  width: 370.w,
                                  height: 35.h,
                                  child: Image.asset(
                                    ImageUtils.BarProfileImage,
                                    fit: BoxFit.fill,
                                  )),
                              Positioned(
                                  top: 5.h,
                                  left: 5.w,
                                  child: Container(
                                      width: 10.w,
                                      height: 6.h,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: BackArrowContainer())),
                              Positioned(
                                  top: 30.6.h,
                                  child: Container(
                                    width: 16.w,
                                    height: 10.h,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: Image.asset(ImageUtils.barCircle),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.horizontalPadding),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "John Milton's Bar",
                                      style: TextStyle(
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 2.5.t),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {},
                                    //   child: Container(
                                    //     height: 4.5.h,
                                    //     decoration: BoxDecoration(
                                    //         color: ColorUtils.red_color,
                                    //         borderRadius: BorderRadius.circular(18)),
                                    //     child: Padding(
                                    //       padding: EdgeInsets.symmetric(horizontal: 30),
                                    //       child: Center(
                                    //           child: Text(
                                    //             "Follow",
                                    //             style: TextStyle(
                                    //                 color: ColorUtils.white,
                                    //                 fontSize: 2.t,
                                    //                 fontFamily: FontUtils.modernistBold),
                                    //           )),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "198",
                                          style: TextStyle(
                                              fontSize: 2.5.t,
                                              color: ColorUtils.red_color,
                                              fontFamily:
                                                  FontUtils.modernistBold),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text(
                                          "Followers",
                                          style: TextStyle(fontSize: 1.7.t),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                      child: VerticalDivider(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "50",
                                          style: TextStyle(
                                              fontSize: 2.5.t,
                                              color: ColorUtils.red_color,
                                              fontFamily:
                                                  FontUtils.modernistBold),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text(
                                          "Following",
                                          style: TextStyle(fontSize: 1.7.t),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                      child: VerticalDivider(
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "291",
                                          style: TextStyle(
                                              fontSize: 2.5.t,
                                              color: ColorUtils.red_color,
                                              fontFamily:
                                                  FontUtils.modernistBold),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text(
                                          "Posts",
                                          style: TextStyle(fontSize: 1.7.t),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.5.h,
                                ),
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna. Donec bibendum velit vitae lacus rutrum mollis tempus vitae leo. Ut commodo, elit sit amet pretium dapibus, arcu orci tempor massa.",
                                  style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.8.t),
                                ),
                                SizedBox(
                                  height: 1.8.h,
                                ),
                                TabBar(
                                  indicatorColor: ColorUtils.text_red,
                                  labelColor: ColorUtils.text_red,
                                  labelStyle: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 1.8.t,
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.8.t,
                                  ),
                                  unselectedLabelColor: ColorUtils.icon_color,
                                  tabs: [
                                    Tab(
                                      text: "News Feed",
                                    ),
                                    Tab(
                                      text: "Ratings",
                                    ),
                                    // Tab(
                                    //   text: "",
                                    // ),
                                  ],
                                ),
                                Container(
                                  height: 100.h,
                                  child: TabBarView(children: [
                                    ///----New Feed Tab----///
                                    Container(
                                      margin: EdgeInsets.only(top: 1.h),
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 4,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.5.h,
                                                horizontal: 2.w),
                                            //width: 6.h,
                                            //height: 30.h,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ColorUtils.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 0,
                                                  blurRadius: 10,
                                                  offset: Offset(0,
                                                      5), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                              //border: Border.all(color: ColorUtils.red_color),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          people[index]
                                                              ['image'],
                                                          height: 10.i,
                                                        ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        Text(
                                                          people[index]["name"],
                                                          style: TextStyle(
                                                              fontFamily: FontUtils
                                                                  .modernistBold),
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .more_vert_rounded,
                                                          color:
                                                              Colors.grey[500],
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(height: 1.h),
                                                Text(
                                                  people[index]['detail'],
                                                  style: TextStyle(
                                                      fontFamily: FontUtils
                                                          .modernistRegular,
                                                      fontSize: 1.7.t),
                                                ),
                                                Divider(
                                                  height: 2.5.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      ImageUtils.comment,
                                                      scale: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      "68",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontFamily: FontUtils
                                                              .modernistRegular),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    Image.asset(
                                                      ImageUtils.like,
                                                      scale: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      "53.5 k",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontFamily: FontUtils
                                                              .modernistRegular),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    1.5,
                                          );
                                        },
                                      ),
                                    ),

                                    ///----Rating Tab----///
                                    Container(
                                      margin: EdgeInsets.only(top: 1.h),
                                      child: Column(
                                        children: [
                                          Container(

                                              // padding: EdgeInsets.symmetric( horizontal: 2.w),
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // ElevatedButton(
                                              //     onPressed: () {
                                              //       model.rating();
                                              //     },
                                              //     child: Text("Click ,me")),
                                              SizedBox(
                                                height: 2.5.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Customer Rating",
                                                    style: TextStyle(
                                                        fontFamily: FontUtils
                                                            .modernistBold,
                                                        fontSize: 2.2.t),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      model
                                                          .navigateToAllBarRating();
                                                    },
                                                    child: Text(
                                                      "See all",
                                                      style: TextStyle(
                                                        color: ColorUtils
                                                            .red_color,
                                                        fontFamily: FontUtils
                                                            .modernistRegular,
                                                        fontSize: 1.7.t,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.5.h,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0.5.h,
                                                      horizontal: 3.w),
                                                  decoration: BoxDecoration(
                                                    // boxShadow: [
                                                    //   BoxShadow(
                                                    //     color: ColorUtils.black.withOpacity(0.1),
                                                    //     spreadRadius: 0,
                                                    //     blurRadius: 10,
                                                    //     offset: Offset(0, 5), // changes position of shadow
                                                    //   ),
                                                    // ],
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                18)),
                                                    border: Border.all(
                                                        color: ColorUtils
                                                            .text_red),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      RatingBar.builder(
                                                        tapOnlyMode: false,
                                                        initialRating: model
                                                            .ratingKaData!
                                                            .total_rating!,
                                                        minRating: 1,
                                                        ignoreGestures: true,
                                                        direction:
                                                            Axis.horizontal,
                                                        //allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 10.i,
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    3.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star_rounded,
                                                          color: ColorUtils
                                                              .red_color,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          //print(rating);
                                                        },
                                                      ),
                                                      Text(
                                                        "${model.ratingKaData!.total_rating} out of 5",
                                                        style: TextStyle(
                                                          color: ColorUtils
                                                              .red_color,
                                                          fontFamily: FontUtils
                                                              .modernistRegular,
                                                          fontSize: 1.7.t,
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          )),
                                          SizedBox(
                                            height: 2.5.h,
                                          ),
                                          Container(
                                            // height: 20.h,
                                            child: ListView.separated(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: model
                                                  .ratingKaData!.data!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.5.h,
                                                      horizontal: 2.w),
                                                  //width: 6.h,
                                                  //height: 30.h,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: ColorUtils.black
                                                            .withOpacity(0.1),
                                                        spreadRadius: 0,
                                                        blurRadius: 10,
                                                        offset: Offset(0,
                                                            5), // changes position of shadow
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                18)),
                                                    //border: Border.all(color: ColorUtils.red_color),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.network(
                                                            model
                                                                .ratingKaData!
                                                                .data![index]
                                                                .user!
                                                                .profile_picture
                                                                .toString(),
                                                            height: 10.i,
                                                          ),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                model
                                                                    .ratingKaData!
                                                                    .data![
                                                                        index]
                                                                    .user!
                                                                    .username
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 2.h,
                                                                  fontFamily:
                                                                      FontUtils
                                                                          .modernistBold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 0.5.h,
                                                              ),
                                                              Text(
                                                                model.timeZone!
                                                                    .substring(
                                                                        0, 10)
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: ColorUtils
                                                                        .text_grey,
                                                                    fontFamily:
                                                                        FontUtils
                                                                            .modernistRegular,
                                                                    fontSize:
                                                                        1.3.h),
                                                              ),
                                                            ],
                                                          ),
                                                          RatingBar.builder(
                                                            initialRating: model
                                                                .ratingKaData!
                                                                .data![index]
                                                                .rate!,
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            itemSize: 4.5.i,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        0.3.w),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons
                                                                  .star_rounded,
                                                              color: ColorUtils
                                                                  .red_color,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              print(rating);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 2.h),
                                                      Text(
                                                        model
                                                            .ratingKaData!
                                                            .data![index]
                                                            .comments
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily: FontUtils
                                                                .modernistRegular,
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
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      1.5,
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 2.5.h),
                                          Container(
                                            //width: 200.0,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0),
                                                ),
                                                border: Border.all(
                                                    color:
                                                        ColorUtils.icon_color)),
                                            child: TextField(
                                              onTap: () {},
                                              enabled: true,
                                              //readOnly: true,
                                              //focusNode: model.searchFocus,
                                              //controller: model.groupScreenChatController,
                                              decoration: InputDecoration(
                                                hintText: "Write your comment",
                                                hintStyle: TextStyle(
                                                  //fontFamily: FontUtils.proximaNovaRegular,
                                                  color: ColorUtils.icon_color,
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      1.9,
                                                ),
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: SizeConfig
                                                                .heightMultiplier *
                                                            1.8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///----Event Tab----///
                                    // Container(
                                    //   margin: EdgeInsets.only(top: 3.h),
                                    //   child:  ListView.separated(
                                    //     padding: EdgeInsets.zero,
                                    //     scrollDirection: Axis.vertical,
                                    //     physics: BouncingScrollPhysics(),
                                    //     shrinkWrap: true,
                                    //     itemBuilder: (context, index) {
                                    //       return Container(
                                    //
                                    //         decoration: BoxDecoration(
                                    //           boxShadow: [
                                    //             BoxShadow(
                                    //               color: ColorUtils.black.withOpacity(0.1),
                                    //               spreadRadius: 0,
                                    //               blurRadius: 10,
                                    //               offset: Offset(0, 5), // changes position of shadow
                                    //             ),
                                    //           ],
                                    //           color: Colors.white,
                                    //           borderRadius: BorderRadius.all(Radius.circular(18)),
                                    //           border: Border.all(color: ColorUtils.red_color),
                                    //         ),
                                    //         child: Column(
                                    //           mainAxisSize: MainAxisSize.min,
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Padding(
                                    //               padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                                    //               child: Row(
                                    //                 children: [
                                    //                   ClipRRect(
                                    //                     borderRadius: BorderRadius.circular(10),
                                    //                     child: Image.asset(places[index]["image"],
                                    //                       width: 20.i,
                                    //                       height: 20.i,
                                    //                       fit: BoxFit.cover,
                                    //                     ),
                                    //                   ),
                                    //                   SizedBox(width: 3.w,),
                                    //                   Column(
                                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                                    //                     children: [
                                    //                       Text(places[index]["date"],
                                    //                         style: TextStyle(
                                    //                             fontFamily: FontUtils.modernistRegular,
                                    //                             fontSize: 1.7.t,
                                    //                             color: ColorUtils.text_red
                                    //                         ),
                                    //                       ),
                                    //                       SizedBox(height: 1.h,),
                                    //                       Text(places[index]["eventName"],
                                    //                         style: TextStyle(
                                    //                             fontFamily: FontUtils.modernistBold,
                                    //                             fontSize: 2.2.t,
                                    //                             color: ColorUtils.black
                                    //                         ),
                                    //                       ),
                                    //                       SizedBox(height: 1.h,),
                                    //                       Row(
                                    //                         children: [
                                    //                           SvgPicture.asset(places[index]['locationIcon']),
                                    //                           SizedBox(width: 2.w,),
                                    //                           Text(places[index]["location"],
                                    //                             style: TextStyle(
                                    //                                 fontFamily: FontUtils.modernistRegular,
                                    //                                 fontSize: 1.7.t,
                                    //                                 color: ColorUtils.text_dark
                                    //                             ),
                                    //                           ),
                                    //                         ],
                                    //                       )
                                    //                     ],
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       );
                                    //     },
                                    //     separatorBuilder: (context, index) {
                                    //       return SizedBox(height:  SizeConfig.heightMultiplier * 2,);
                                    //     },
                                    //     itemCount: places.length,
                                    //   ),
                                    // ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ));
        });
  }
}
