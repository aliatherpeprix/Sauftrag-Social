import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/NewsFeed/events.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:sauftrag/widgets/my_side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {

  List newsEvents = [
    {
      'image': ImageUtils.person_1,
      'barOwnerName': 'Nellie Mendez',
      'para':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': false,
      'comment': '68',
      'commentIon': ImageUtils.msgIcon,
      'likes': '53.5 k',
      'likesIcon': ImageUtils.matchedIcon,
    },
    {
      'image': ImageUtils.person_2,
      'barOwnerName': 'Ron Wright',
      'para':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': true,
      'commentIon': ImageUtils.msgIcon,
      'comment': '68',
      'likesIcon': ImageUtils.matchedIcon,
      'likes': '53.5 k',
    },
    {
      'image': ImageUtils.person_1,
      'barOwnerName': 'Nellie Mendez',
      'para':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': false,
      'commentIon': ImageUtils.msgIcon,
      'comment': '68',
      'likesIcon': ImageUtils.matchedIcon,
      'likes': '53.5 k',
    },
  ];

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        //model.userNewsFeed = true;
        // model.getEvent(context);
      },
      builder: (context, model, child) {
        return SideMenu(
          key: model.sideMenuKey,
          closeIcon: Icon(Icons.remove,color: Colors.transparent,),
          type: SideMenuType.shrinkNSlide,
          background: ColorUtils.text_red,
          radius: BorderRadius.circular(30),
          menu: MySideMenu(),
          child: GestureDetector(
            onTap: (){
              context.unFocus();
              model.openGroupMenu = false;
              model.notifyListeners();
            },
            child: DefaultTabController(
              length: 2,
              child:
              SafeArea(
                top: false,
                bottom: false,
                child: GestureDetector(
                  onTap: (){
                    final _state = model.sideMenuKey.currentState;
                    if (_state!.isOpened)
                      _state.closeSideMenu(); // close side menu
                  },
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Container(
                      padding: EdgeInsets.only(
                        //horizontal: Dimensions.horizontalPadding,
                          top: Dimensions.verticalPadding
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: Dimensions.homeTopMargin),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.horizontalPadding),
                              child: ElevatedButton(
                                onPressed: () {
                                  final _state = model.sideMenuKey.currentState;
                                  if (_state!.isOpened)
                                    _state.closeSideMenu(); // close side menu
                                  else
                                    _state.openSideMenu();
                                },
                                child: SvgPicture.asset(ImageUtils.menuIcon),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorUtils.white,
                                  onPrimary: ColorUtils.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                      Dimensions.containerVerticalPadding),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.roundCorner),
                                      side: BorderSide(
                                          color: ColorUtils.divider, width: 1)),
                                  textStyle: TextStyle(
                                    color: ColorUtils.white,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 1.8.t,
                                    //height: 0
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          TabBar(
                            indicatorColor: ColorUtils.text_red,
                            labelColor: ColorUtils.text_red,
                            labelStyle: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.2.t,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 2.2.t,
                            ),
                            unselectedLabelColor: ColorUtils.icon_color,
                            tabs: [
                              Tab(
                                text: "NewsFeed",
                              ),
                              Tab(
                                text: "Events",
                              ),
                            ],
                            onTap: (value) {
                              if (value==1){
                               model.getBarPost();
                               model.rating();
                               model.getEvent(context);
                              }
                            },
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // first tab bar view widget
                                NewsFeedScreen(),

                                // second tab bar viiew widget
                                Events(),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
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


class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () => locator<MainViewModel>(),
        onModelReady: (model){
            model.getBarPost();
            model.rating();
            //model.getEvent(context);
        },
        builder: (context, model, child) {
          return model.isPost == true ? AllPageLoader() :Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: Dimensions.homeTopMargin),

                //Top bar
                // Container(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: Dimensions.horizontalPadding),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       ElevatedButton(
                //         onPressed: () {
                //           final _state = model.sideMenuKey.currentState;
                //           if (_state!.isOpened)
                //             _state.closeSideMenu(); // close side menu
                //           else
                //             _state.openSideMenu();
                //         },
                //         child: SvgPicture.asset(ImageUtils.menuIcon),
                //         style: ElevatedButton.styleFrom(
                //           primary: ColorUtils.white,
                //           onPrimary: ColorUtils.white,
                //           padding: EdgeInsets.symmetric(
                //               vertical:
                //               Dimensions.containerVerticalPadding),
                //           elevation: 0,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(
                //                   Dimensions.roundCorner),
                //               side: BorderSide(
                //                   color: ColorUtils.divider, width: 1)),
                //           textStyle: TextStyle(
                //             color: ColorUtils.white,
                //             fontFamily: FontUtils.modernistBold,
                //             fontSize: 1.8.t,
                //             //height: 0
                //           ),
                //         ),
                //       ),
                //       Text(
                //         "News Feed",
                //         style: TextStyle(
                //           color: ColorUtils.black,
                //           fontFamily: FontUtils.modernistBold,
                //           fontSize: 2.5.t,
                //         ),
                //       ),
                //       Container(
                //         // onPressed: () {
                //         //  /* showDialog(
                //         //       context: context,
                //         //       builder: (BuildContext context){
                //         //         return DrinkStatusDialogBox(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                //         //       }
                //         //   );*/
                //         // },
                //         child: Image.asset(ImageUtils.profileImg, height: 15.i,),
                //       ),
                //     ],
                //   ),
                // ),
                //SizedBox(height: 3.h),

                SizedBox(
                    height: 3.5.h
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      //horizontal: Dimensions.horizontalPadding,
                      //vertical: Dimensions.verticalPadding
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.5.w,
                          ),
                          child: Container(
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
                              border: Border.all(
                                  color: ColorUtils.text_grey
                                      .withOpacity(0.1)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w,
                                      vertical: 1.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius
                                                .circular(10),
                                            child: Image.network(
                                              model
                                                  .posts[index]
                                                  .user_id!
                                                  .profile_picture!,
                                              //newsEvents[index]["image"],
                                              width: 10.i,
                                              height: 10.i,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    model
                                                        .posts[
                                                    index]
                                                        .user_id!
                                                        .bar_name!,
                                                    //newsEvents[index]["barOwnerName"],
                                                    style: TextStyle(
                                                        fontFamily:
                                                        FontUtils
                                                            .modernistBold,
                                                        fontSize:
                                                        2.2.t,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: ColorUtils
                                                            .black),
                                                  ),
                                                  // if (model.posts[index].post_type! == '1')
                                                  //   {
                                                  //     Text("Abc")
                                                  //   }
                                                ],
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Text(
                                                model.posts[index]
                                                    .post_location!,
                                                //newsEvents[index]["barOwnerName"],
                                                style: TextStyle(
                                                    fontFamily:
                                                    FontUtils
                                                        .modernistRegular,
                                                    fontSize: 1.7.t,
                                                    //fontWeight: FontWeight.bold,
                                                    color:
                                                    ColorUtils
                                                        .black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              model.posts[index]
                                                  .post_content!,
                                              //newsEvents[index]["para"],
                                              style: TextStyle(
                                                  fontFamily: FontUtils
                                                      .modernistRegular,
                                                  fontSize: 1.8.t,
                                                  color: ColorUtils
                                                      .black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      if (model.posts[index]
                                          .media !=
                                          null &&
                                          model.posts[index].media!
                                              .length >
                                              0)
                                        Container(
                                            child:
                                            CachedNetworkImage(
                                              imageUrl: model
                                                  .posts[index]
                                                  .media![0]
                                                  .media!,
                                              //width: 100.i,
                                              height: 40.i,
                                              fit: BoxFit.cover,
                                            )),
                                      Divider(),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                ImageUtils.msgIcon,
                                                color: ColorUtils
                                                    .icon_color,
                                              ),
                                              SizedBox(
                                                width: 1.5.w,
                                              ),
                                              Text(
                                                "68",
                                                style: TextStyle(
                                                    fontFamily:
                                                    FontUtils
                                                        .modernistRegular,
                                                    fontSize: 1.5.t,
                                                    color: ColorUtils
                                                        .icon_color),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 7.w),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                ImageUtils
                                                    .matchedIcon,
                                                color: ColorUtils
                                                    .icon_color,
                                              ),
                                              SizedBox(
                                                width: 1.5.w,
                                              ),
                                              Text(
                                                "53.5 k",
                                                style: TextStyle(
                                                    fontFamily:
                                                    FontUtils
                                                        .modernistRegular,
                                                    fontSize: 1.5.t,
                                                    color: ColorUtils
                                                        .icon_color),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
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
                      itemCount: model.posts.length,
                    ),
                  ),
                ),


              ],
            ),
          );
        },
        disposeViewModel: false,
    );
  }
}

